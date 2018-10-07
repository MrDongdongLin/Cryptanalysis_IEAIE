function e=getEntropy(data)
data=uint8(data);
[m,n]=size(data);
data = uint8(data);
p=imhist(data)/(m*n);
p(p==0)=[];
e=-sum(p.*log(p));
end