function [u,v]=attackPermutation(I,B)
% if u,v have zero elements, then this function can be executed for any
% times.
[m,n]=size(B);
u=zeros(1,n); v=zeros(1,m);
[eh_I,ev_I]=getEntropy(I);
[eh_B,ev_B]=getEntropy(B);
for i=1:n
    if u(i)==0
        u(i) = find(ev_B==ev_I(i));
    end
end
for i=1:m
    if v(i)==0
        v(i) = find(eh_B==eh_I(i));
    end
end
u=uint32(u); v=uint32(v);
% Bstar=B(vv,:); II=Bstar(:,uu);
end