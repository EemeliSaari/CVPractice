% Testing the median filter

%% Loading test images

I1 = imread('resources/filtered1.png');
I2 = imread('resources/filtered2.png');

%% Testing 3x3 mask and 5x5 mask

median1_3 = median2(I1,3,3);
median1_5 = median2(I1,5,5);

median2_3 = median2(I2,3,3);
median2_5 = median2(I2,3,3);

figure(1);
subplot(2,1,1);
imagesc(cat(2,I1,median1_3)); colormap gray;
subplot(2,1,2);
imagesc(cat(2,I1,median1_5)); colormap gray;

figure(2);
subplot(2,1,1);
imagesc(cat(2,I2,median2_3)); colormap gray;
subplot(2,1,2);
imagesc(cat(2,I2,median2_5)); colormap gray;
