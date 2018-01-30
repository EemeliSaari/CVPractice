function parts = split_image(image, dim1, dim2, step)
% Splits the image to equal slices determined by step
%   Returns a cell of the slices.

h = 1;
img_parts = cell(dim1, dim2); % Parts are stored into cell as well
for x = 1 : size(img_parts,1)
    w = 1;
    for y = 1 : size(img_parts,2)
        slice = image((h:h+step-1),(w:w+step-1),:);
        w = w + step;
        img_parts{x,y} = num2cell(slice);
    end
    h = h + step;
end

parts = img_parts;

end

