function Ks = filtering(K, H)
%Calculate NxM and NxM Matrixes values product
%   Returns a NxM matrix.

empty = zeros(size(K));
for i = 1 : size(K,1)
    for p = 1 : size(K,2)
        empty(i,p) = K(i,p) * H(i,p);
    end
end

Ks = empty;

end

