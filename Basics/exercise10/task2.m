% Converting YCbCr image to RGB

%% Read the .mat file

YCbCr_data = load('resources/ycbcr.mat');

%% split the data by rows and columns
x = YCbCr_data.rows;
y = YCbCr_data.cols;

size = x * y;

comp_y = reshape(YCbCr_data.yy,[y,x])';
comp_cb = reshape(YCbCr_data.ccb,[y/2,x/2])'; 
comp_cr = reshape(YCbCr_data.ccr,[y/2,x/2])';

%% Plot the components

figure(1);

subplot(1,3,1);
imshow(uint8(comp_y));

subplot(1,3,2);
imshow(uint8(comp_cb));

subplot(1,3,3);
imshow(uint8(comp_cr));

%% Resize the components

Y = comp_y - 16;
Cb = imresize(comp_cb, 2) - 128;
Cr = imresize(comp_cr, 2) - 128;

%% Reformat the matrix

YCbCr = cat(2, Y(:), Cb(:), Cr(:));
YCbCr2RGB = [1.164 0.0 1.596; 1.164 -0.392 -0.813; 1.164 2.017 0.0];

RGB = YCbCr2RGB * YCbCr';

%% Shape the RGB -components 

R = reshape(RGB(1,:),[x,y]);
G = reshape(RGB(2,:),[x,y]);
B = reshape(RGB(3,:),[x,y]);

img = uint8(cat(3, R, G, B));

%% Plot the result

imshow(img);
