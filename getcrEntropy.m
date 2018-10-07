function [eh,ev]=getcrEntropy(data)
[m,n]=size(data);
eh=zeros(1,m); ev=zeros(1,n);
for i=1:m
    eh(i)=testEntropy(data(i,:));
end
for i=1:n
    ev(i)=testEntropy(data(:,i));
end
end