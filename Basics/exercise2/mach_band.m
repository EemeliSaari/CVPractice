function img = mach_band(heigth, width, N)
% Mach band of columns from left to right
%   Generates a image of size(heigth, width)
%   with N many different grayscale shades.

N_ = 1:N;
Ni = 0:N-1;
empty_img = zeros(heigth,width);
step = width / N;
gray_val = 255 / N;

n = 1;
for y = 1 : width
    
    empty_img(1:heigth,y) = gray_val * Ni(n);
    display(n)
    if (y == step * N_(n))
        n = n + 1;
    end
end

img = uint8(empty_img);

end
