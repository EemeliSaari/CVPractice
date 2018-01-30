
%% Load the previous task workspace

task1();

%% DFT for the image

DFT = fftshift(fft2(img));

%% Gaussian low-pass filter

figure;
D0 = 10;
for i = 1 : 9
    text = ["Gaussian filter ", "Do = ", num2str(D0)];
    H = Gauss(:,:,i);
    Ks = filtering(DFT,H);
    subplot(3,3,i);
    
    K = ifft2(ifftshift(Ks));
    imshowpair(H, uint8(real(K)), 'montage')
    title(join(text));
    
    D0 = D0 + 10;
end

%% Butterworth's low-pass filter

figure;
for i = 1 : 12
    text = ["Gaussian filter ", "n = ", num2str(i)];

    H = Butt(:,:,i);
    Ks = filtering(DFT,H);
    subplot(3,4,i);
    
    K = ifft2(ifftshift(Ks));
    imshowpair(H, uint8(real(K)), 'montage')
    title(join(text));
end

%% Ideal low-pass filter

figure;
Ks = filtering(DFT,Hi);
K = ifft2(ifftshift(Ks));
imshowpair(Hi, uint8(real(K)), 'montage');
title("Ideal filter with Do = 50");
