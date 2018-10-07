function I=decrypt(xbar,ybar,x0,y0,x0_,y0_,mu,C,d)%(K,u,v,C,d)%
% x0=0.0056; y0=0.3678; x0_=0.6229; y0_=0.7676; mu=0.8116;
[m,n]=size(C);
I=zeros(m,n);
% initial condition
xbar_=mod((x0_+1/(x0+y0+1)),1);
ybar_=mod((y0_+2/(x0+y0+2)),1);
% construct matrix P
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
% reverse process of diffusion
C=double(C);
for i=1:m
    for j=1:n
        if j-1==0
            R(i,j)=mod(C(i,j)-d(j)*K(i,j)-K(i,d(j)),256);
        else
            R(i,j)=mod(C(i,j)-d(j)*C(i,j-1)-d(j)*K(i,j)-K(i,d(j)),256);
        end
    end
end
% reverse process of changing gray distribution
B=zeros(m,n);
R=double(R);
for i=1:m
    for j=1:n
        B(i,j)=mod(R(i,j)-m*n-i-j,256);
    end
end
% permutation vectors
a=mod(ceil((x0+y0+1)*10^7),m)+1;
b=mod(ceil((x0_+y0_+2)*10^7),n)+1;
u=P(a,:); v=P(:,b); v=v';
u=mod(ceil(u*10^14),m)+1;
v=mod(ceil(v*10^14),n)+1;
u=uniqueVec(uint32(u));
v=uniqueVec(uint32(v));
Bstar(v,:)=B; I(:,u)=Bstar;
I=uint8(I);
end