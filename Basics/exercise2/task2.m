% Quantization

%% Initialize the image and k vector

I1 = imread('images/cameraman.tif');
[ix, iy] = size(I1);

k = 2.^[8:-1:1];

% counter for subplot
counter = 1;

% bin for hist() function
bin = 0:255;

for n = 1 : size(k,2)
    k_ = 256 / k(n);
    
    subplot(4,4, counter);
    % Quantify the image
    quant_img = uint8(floor(double(I1) ./ k_) .* k_);
    imshow(quant_img);
    counter = counter + 1 ;
    
    % Title
    if (n == 1)
        title('Original 256 shades');
    else
        text = ['Quantization ', int2str(k(n)), ' shades'];
        title(join(text));
    end
    
    % plot the histogram
    subplot(4,4, counter);
    hist(double(quant_img), bin);
    counter = counter + 1 ;
    
end