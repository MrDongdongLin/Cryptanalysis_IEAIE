function D=attackGray(R,B)
[m,n]=size(B);
D=zeros(m,n);
for i=1:m
    for j=1:n
        D(m,n) = mod( R(i,j) - M*N -i-j, 256 );
    end
end
end