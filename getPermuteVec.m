function [r,c] = getPermuteVec(x0,y0,x0_,y0_,mu,I)
% x0=0.0056; y0=0.3678; x0_=0.6229; y0_=0.7676; mu=0.8116;
% I = imread('Lenna_256.bmp');
[m,n]=size(I);
% i=1;
r = zeros(1,m);
c = zeros(1,n);
for i=1:n
    I1 = zeros(m,n);
    I2 = zeros(m,n);
    I1(:,i)=1;
    I2(:,i)=2;
    [C1,~,~,~]=encrypt(x0,y0,x0_,y0_,mu,I1);
    [C2,~,~,~]=encrypt(x0,y0,x0_,y0_,mu,I2);
    cmp = C1(1,:)==C2(1,:);
    c(i) = find(cmp~=1,1,'first');
end
s = uint8(1:1:256);
for i=1:m
    ind = find(s~=i,2,'first');
    I1 = zeros(m,n);
    I2 = zeros(m,n);
    I3 = zeros(m,n);
    I1(i,:) = 1;
    I2(ind(1),:) = 1;
    I3(ind(2),:) = 2;
    [C1,~,~,~]=encrypt(x0,y0,x0_,y0_,mu,I1);
    [C2,~,~,~]=encrypt(x0,y0,x0_,y0_,mu,I2);
    [C3,~,~,~]=encrypt(x0,y0,x0_,y0_,mu,I3);
    cmp1 = C1(:,1)==C2(:,1);
    cmp2 = C1(:,1)==C3(:,1);
    cmp = cmp1|cmp2;
    r(i) = find(cmp~=1,1,'first');
end
end