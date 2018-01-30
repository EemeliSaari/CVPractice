function filtered = median2(image, m, n)
%2D median filter
%   Calculates the median value for each pixel in the input
%   image for m x n sized area.

empty = zeros(size(image));

stepx = floor(m/2);
stepy = floor(n/2);

sx = m - stepx;
sy = n - stepy;

for x = sx : size(image,1) - sx
    for y = sy : size(image,2) - sy
        
        area = image((x-stepx):(x+stepx),(y-stepy):(y+stepx));
        sorted_vec = sort(area(:));
        median_value = sorted_vec(ceil(size(sorted_vec,1)/2));
        empty(x,y) = median_value;
    
    end
end

filtered = uint8(empty);

end


