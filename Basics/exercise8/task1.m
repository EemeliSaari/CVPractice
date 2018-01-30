% Practice color dimensions

%% RGB

RGB = imread('resources/rgb1.png');

for i = 1 : 3
    subplot(3,1,i);
    imagesc(RGB(:,:,i)); colormap gray;
    
end

%% CVI

CVI = zeros(size(RGB));

for i = 1 : 3
    CVI(:,:,i) = 1 - double(RGB(:,:,i));
    
    subplot(3,1,i);
    imagesc(CVI(:,:,i)); colormap gray;
end

%% HSV

HSV = rgb2hsv(RGB);

for i = 1 : 3
    subplot(3,1,i);
    imagesc(HSV(:,:,i)); colormap gray;
    
end

%% YCbCr

Y = zeros(size(RGB,1),size(RGB,2));
Cb = zeros(size(RGB,1),size(RGB,2));
Cr = zeros(size(RGB,1),size(RGB,2));

for x = 1 : size(RGB,1)
    for y = 1 : size(RGB,2)
        
        Y(x,y) = 0.299 * RGB(x,y,1) + 0.587 * RGB(x,y,2) + 0.114 * RGB(x,y,3);
        Cb(x,y) = - 0.169 * RGB(x,y,1) - 0.331 * RGB(x,y,2) +  0.500 * RGB(x,y,3);
        Cr(x,y) = 0.500 * RGB(x,y,1) - 0.419 * RGB(x,y,2) + 0.081 * RGB(x,y,3);
    
    end
    
end

subplot(3,1,1);
imagesc(Y); colormap gray;
subplot(3,1,2);
imagesc(Cb); colormap gray;
subplot(3,1,3);
imagesc(Cr); colormap gray;

%%
