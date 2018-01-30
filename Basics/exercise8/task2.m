%% Read the sample images

img1 = imread('resources/808test.jpg');
img2 = imread('resources/rgb1.png');

%% make median 3x3 filter to HSV's V-component

hsv1 = rgb2hsv(img1);
hsv2 = rgb2hsv(img2);

v1 = medfilt2(hsv1(:,:,3), [3 3]);
v2 = medfilt2(hsv2(:,:,3), [3 3]);

filt1 = hsv1;
filt1(:,:,3) = v1;

filt2 = hsv2;
filt2(:,:,3) = v2;

%% Plot the images and compare the differences

figure('Name','Median 3x3');

subplot(1,2,1);
imshow(hsv2rgb(filt1));
title('Filterd HSV JPG image');

subplot(1,2,2);
imshow(hsv2rgb(filt2));
title('Filtered HSV PNG image');

%% Load exercise 4 masks

masks_conff = load('masks.mat');
masks = masks_conff.maskit;

lab = cell2mat(masks(4,1));

%% Filter with Laplace

v11 = imfilter(hsv1(:,:,3),lab);
v22 = imfilter(hsv2(:,:,3),lab);

filt11 = hsv1;
filt11(:,:,3) = v11;

filt22 = hsv2;
filt22(:,:,3) = v22;

filtRGB1 = zeros(size(img1));
filtRGB2 = zeros(size(img2));

for i = 1 : 3
   
    filtRGB1(:,:,i) = imfilter(img1(:,:,i), lab);
    filtRGB2(:,:,i) = imfilter(img2(:,:,i), lab);
    
end

%% Plot images and compare

figure('Name','Laplace');
subplot(2,2,1);
imagesc(hsv2rgb(filt11));
title('Filterd HSV JPG image');

subplot(2,2,2);
imagesc(hsv2rgb(filt22));
title('Filterd HSV PNG image');

subplot(2,2,3);
imagesc(uint8(filtRGB1));
title('Filterd RGB JPG image');

subplot(2,2,4);
imagesc(uint8(filtRGB2));
title('Filterd RGB PNG image');

%% Filter images with Wiener 7x7

[v111, noise1] = wiener2(hsv1(:,:,3), [7 7]);
[v222, noise2] = wiener2(hsv2(:,:,3), [7 7]);

filt111 = hsv1;
filt111(:,:,3) = v111;

filt222 = hsv2;
filt222(:,:,3) = v222;

filtRGB11 = zeros(size(img1));
filtRGB22 = zeros(size(img2));

for i = 1 : 3
    
    [filtered1, n1] = wiener2(img1(:,:,i), [7 7]);
    [filtered2, n2] = wiener2(img2(:,:,i), [7 7]);
    
    filtRGB11(:,:,i) = filtered1;
    filtRGB22(:,:,i) = filtered2;
    
end

%% Plot and compare difference

figure('Name','Wiener 7x7');
subplot(2,2,1);
imagesc(hsv2rgb(filt111));
title('Filterd HSV JPG image');

subplot(2,2,2);
imagesc(hsv2rgb(filt222));
title('Filterd HSV PNG image');

subplot(2,2,3);
imagesc(uint8(filtRGB11));
title('Filterd RGB JPG image');

subplot(2,2,4);
imagesc(uint8(filtRGB22));
title('Filterd RGB PNG image');

%% Filter with Gaussian 7x7

h = fspecial('gaussian', 7,7);

v1111 = imfilter(hsv1(:,:,3), h);
v2222 = imfilter(hsv2(:,:,3), h);

filt1111 = hsv1;
filt1111(:,:,3) = v11;

filt2222 = hsv2;
filt2222(:,:,3) = v22;

filtRGB111 = zeros(size(img1));
filtRGB222 = zeros(size(img2));

for i = 1 : 3
   
    filtRGB111(:,:,i) = imfilter(img1(:,:,i), h);
    filtRGB222(:,:,i) = imfilter(img2(:,:,i), h);
    
end

%% Plot images and compare

figure('Name','Gaussian 7x7');
subplot(2,2,1);
imagesc(hsv2rgb(filt1111));
title('Filterd HSV JPG image');

subplot(2,2,2);
imagesc(hsv2rgb(filt2222));
title('Filterd HSV PNG image');

subplot(2,2,3);
imagesc(uint8(filtRGB111));
title('Filterd RGB JPG image');

subplot(2,2,4);
imagesc(uint8(filtRGB222));
title('Filterd RGB PNG image');
