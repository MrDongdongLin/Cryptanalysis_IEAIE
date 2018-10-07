% remove elements of the same value
function vecout=uniqueVec(vecin)
countf=zeros(1,length(vecin));
countv=zeros(1,length(vecin));
for i=1:length(vecin)
    countf(i)=countv(vecin(i))+1;
    countv(vecin(i))=countv(vecin(i))+1;
end
ind=find(countv==0);
for i=1:length(countf)
    if countf(i)>1
        vecin(i)=ind(1);
        ind=ind(2:end);
    end
end
vecout=vecin;
end