B = zeros(256,256);
R = B;
[m,n] = size(B);
for i=1:m
    for j=1:n
        R(i,j) = mod( B(i,j) + m*n +i +j, 256 );
    end
end
R = uint8(R);
clear B m n i j