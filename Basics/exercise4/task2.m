%% Read the image and adjust the kernel

I = imread('resources/rgb1.png');

r = I(:,:,1); 
g = I(:,:,2);
b = I(:,:,3);

kernels = [ 3 5 9 ]; 

%% Average filtering

for i = 1 : size(kernels,2)
    
    filtered = uint8(zeros(size(I)));
    for col = 1 : 3
        ha = fspecial('average', kernels(i));
        filtered(:,:,col) = imfilter(I(:,:,col),ha);
    end
    subplot(1,3,i);
    imshow(filtered);
end

%% Meadian filtering

for p = 1 : size(kernels,2)
    filtered = uint8(zeros(size(I)));
    
    for col = 1 : 3
        med = medfilt2(I(:,:,col),[kernels(p),kernels(p)]);
        filtered(:,:,col) = med;
    end
    subplot(1,3,p);
    imshow(filtered);
end
