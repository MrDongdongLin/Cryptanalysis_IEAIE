x0=0.0056; y0=0.3678; x0_=0.6229; y0_=0.7676; mu=0.8116;
I = imread('Lenna_256.bmp');
[C,~,~,~]=encrypt(x0,y0,x0_,y0_,mu,I);
[r,c] = getPermuteVec(x0,y0,x0_,y0_,mu,I);
R=zeros(m,n);
tR(r,c) = I; tR = double(tR);
for i=1:m
    for j=1:n
        R(i,j)=mod(tR(i,j)+m*n+i+j,256);
    end
end
% get equivalent version of the secret key from R and C
d = 1; C0 = 0;
for i=m:-1:1
    if i==m
        D(:,i) = mod(C(:,i) - R(:,i) - d*C(:,i-1), 256);
    else
        d = getEntropy(R(:,i+1:end));
        D(:,i) = mod(C(:,i) - R(:,i) - d*C(:,i-1), 256);
    end
end