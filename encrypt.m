function [C,d,xbar,ybar]=encrypt(x0,y0,x0_,y0_,mu,I)
% x0=0.0056; y0=0.3678; x0_=0.6229; y0_=0.7676; mu=0.8116;
[m,n]=size(I);
C=zeros(m,n);
% entropy
p=imhist(I)/(m*n);
p(p==0)=[];
s=-sum(p.*log(p));
% initial condition
xbar=mod((x0+(s+1)/(s+x0_+y0_+1)),1);
ybar=mod((y0+(s+2)/(s+x0_+y0_+2)),1);
xbar_=mod((x0_+1/(x0+y0+1)),1);
ybar_=mod((y0_+2/(x0+y0+2)),1);
% construct matrix P (from 200 to MN/2, the same with K)
P=[xbar,ybar];
for i=1:200+m*n/2-1
    [xt,yt]=lasmMap(P(end-1),P(end),mu);
    P=[P xt yt];
end
P=P(401:end);
P=reshape(P,m,n)';
% construct matrix K
K=[xbar_,ybar_];
for i=1:200+m*n/2-1
    [xt,yt]=lasmMap(K(end-1),K(end),mu);
    K=[K xt yt];
end
K=K(401:end);
K=reshape(K,m,n)';
K=mod(ceil(K*10^14),256);
% permutation vectors
a=mod(ceil((x0+y0+1)*10^7),m)+1;
b=mod(ceil((x0_+y0_+2)*10^7),n)+1;
u=P(a,:); v=P(:,b); v=v';
u=mod(ceil(u*10^14),m)+1;
v=mod(ceil(v*10^14),n)+1;
u=uniqueVec(uint32(u));
v=uniqueVec(uint32(v));
Bstar=I(:,u); B=Bstar(v,:);
% change gray distribution
R=zeros(m,n);
B=double(B);
for i=1:m
    for j=1:n
        R(i,j)=mod(B(i,j)+m*n+i+j,256);
    end
end
% diffusion
d=zeros(1,n);
for i=1:n
    if i==n
        d(i)=1;
    else
        Rj=R(1:m,i+1:n);
        Rj=uint8(Rj);
        p=imhist(Rj)/(m*(n-i+1));
        p(p==0)=[];
        dd=mod(ceil(-sum(p.*log(p))*10^14),n)+1;
        d(i)=uint32(dd);
    end
end
for i=1:m
    for j=1:n
        if j-1==0
            C(i,j)=mod(R(i,j)+d(j)*K(i,j)+K(i,d(j)),256);
        else
            C(i,j)=mod(R(i,j)+d(j)*C(i,j-1)+d(j)*K(i,j)+K(i,d(j)),256);
        end
    end
end
C=uint8(C);
end

