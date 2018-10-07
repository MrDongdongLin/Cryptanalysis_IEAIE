function D=attackDiffusion(I,C)
% I and C are the plaintext image and its corresponding ciphertext image
[m,n]=size(I);
% local entropy $d$
d=zeros(1,n);
for i=1:n
    if i==n
        d(i)=1;
    else
        Rj=I(1:m,i+1:n);
        Rj=uint8(Rj);
        p=imhist(Rj)/(m*(n-i+1));
        p(p==0)=[];
        dd=mod(ceil(-sum(p.*log(p))*10^14),n)+1;
        d(i)=uint32(dd);
    end
end
% equivalent secret key $\mathbf{D}$ in diffusion procedure
D=zeros(m,n);
for i=1:m
    for j=1:n
        SS = 0;
        for h=1:j
            for k=h+1:j
                BB = prod(d(k:j));
            end
            SS = SS + I(i,h) * BB;
        end
        D(i,j) = mod( C(i,j) - SS, 256);
    end
end
% breaking the changing gray distribution procedure

end