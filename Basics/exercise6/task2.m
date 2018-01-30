% Testing the median filter

%% Loading test images

I1 = imread('resources/filtered1.png');
I2 = imread('resources/filtered2.png');

%% Testing 3x3 mask and 5x5 mask

medianad1 = median2ad(I1,7);

medianad2 = median2ad(I2,7);

figure(1);
subplot(2,1,1);
imagesc(cat(2,I1,medianad1)); colormap gray;

subplot(2,1,2);
imagesc(cat(2,I2,medianad2)); colormap gray;