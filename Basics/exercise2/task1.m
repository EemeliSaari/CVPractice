% Interpolation

%% Reads image and sets scale values to a matrix

I1 = imread('resurces/cameraman.tif');
[ix, iy] = size(I1);

resolutions = [ix/ix 64/ix 55/ix 45/ix 36/ix 27/ix 17/ix 8/ix];

%% For loop each scale value

for n = 1 : size(resolutions,2)
   
    % plot the images to a subplot
    subplot(2, 4, n);
    % scales the image first down
    scaled_d = imresize(I1, resolutions(n), 'nearest');
    % then back to original size
    scaled_u = imresize(scaled_d, 1/resolutions(n), 'nearest');
    imshow(scaled_u);
    
    % Title:
    if (n == 1)
        a = 'Original ';
    else
        a = 'Sampled '; 
    end
    b = int2str(resolutions(n) * ix);
    text = [a, b, 'x', b,' pixels'];
    title(join(text));
end