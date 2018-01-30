function filtered = median2ad(image, Smax)
% 2D median filter
%   Filters the image using Smax param

empty = zeros(size(image));

step = floor(Smax/2);
n = Smax - step;

for x = n : size(image,1) - n
    for y = n : size(image,2) - n
        
        zmi = 0;
        zma = 0;
        zme = 0;
        
        state = 1;
        
        zxy = image(x,y);
        start = 3;
        while start <= Smax
            substep = floor(start/2);
            
            med_area = image((x-substep):(x+substep),(y-substep):(y+substep));
            sorted_area = sort(med_area(:));
            
            zmed = sorted_area(ceil((start*start)/2));
            
            zmin = sorted_area(1);
            zmax = sorted_area(start*start);
            
            if(zmed == zmin || zmed == zmax)
                zmi = zmin;
                zma = zmax;
                zme = zmed;
                start = start + 2;
            else
                state = 0;
                break;
            end
        end
            
        if(state == 1 && zxy == zmi || zxy == zma)
            empty(x,y) = zme;
        else
            empty(x,y) = zxy;
        end
    end
end

filtered = uint8(empty);

end
