%% Load the images

masks_conff = load('resources/masks.mat');
masks = masks_conff.maskit;

I1 = imread('resources/k325.bmp');
I2 = imread('resources/k327.bmp');

%% Maskthe images in a loop

for i = 1 : size(masks,1)
    
    h = cell2mat(masks(i));
    text = cell2mat(masks(i,2));
    
    masked1 = imfilter(I1, h);
    masked2 = imfilter(I2, h);
    
    subplot(7, 2, i);
    
    imshowpair(masked1, masked2, 'montage');
    title(text);

end

%% Filter and calculate the G using the masks

h1 = cell2mat(masks(13));
h2 = cell2mat(masks(14));

Gx = imfilter(I2, h1);
Gy = imfilter(I2, h2);

G = Gx + Gy;

Gx = Gx/max(Gx(:)); 
Gx = uint8(255*(1-Gx)); 

Gy = Gy/max(Gy(:)); 
Gy = uint8(255*(1-Gy)); 

G = G/max(G(:)); 
G = uint8(255*(1-G)); 


figure(1); imshow(Gx,[]); hold on;
figure(2); imshow(Gy,[]); hold on;
figure(3); imshow(G,[]); hold on; 
