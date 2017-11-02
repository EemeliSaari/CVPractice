%% IMAGE REGISTRATION

% Topics:
%   template matching
%   cross-correlation as similarity measure
%   estimating and applying affine transformation

%% Read two images
I1 = imread('images/kivikko.png');
I2 = imread('images/kivikko3.png');

%% Plot the images side by side

subplot(1, 2, 1);
imshow(I1);
title('image1');

subplot(1, 2, 2);
imshow(I2);
title('image2');

%% Generating an equispace grid of points

xref = 51:100:size(I1,2) - 50;
yref = 51:100:size(I1,1) - 50;

[XR, YR] = meshgrid(xref, yref);
% reference points
xr = [XR(:) YR(:)];
xs = xr;

% display the points of interest for the equispace grid
figure(1);
hlr = line(xr(:,1), xr(:,2), 'linestyle', 'none', 'marker','x','color','red');

%template size
d = 5;
ds = 2 * d + 1;

%% Loop through points in the grid

for n = 1 : size(xs,1)
   x0 = xr(n,1);
   y0 = xr(n,2);
   
   % creates the template
   template = I1(y0-d:y0+d, x0-d:x0+d);
   
   % crop the image 2
   crop_img = I2(y0-d-ds:y0+d+ds, x0-d-ds:x0+d+ds);
   
   % calculate the correlation value for the template
   corr_ = normxcorr2(template, crop_img);
   
   % selects the matching point where corr is maximized.
   [best_point, loc] = max(corr(:));
   
   % match the cordinates with 
   [iy, ix] = ind2sub(size(corr), loc);
   
   xs(n,1) = x0 + ix - (2 * ds + 1);
   xs(n,2) = y0 + iy - (2 * ds + 1);
end

%% affline transformation

s = size(xr,1);
u_ = xs(:);
X = [xr ones(s,1) zeros(s,3); zeros(s,3) xr ones(s,1)];
t_ = X\u_;
T = [t_(1) t_(2) t_(3); t_(4) t_(5) t_(6); 0 0 1];

% affine2d function needs a transpose of the transform matrix
tform = affine2d(T');

%% Transform the image and display

warped_img = imwarp(I1, tform, 'OutputView', imref2d(size(I2)));

figure(1);imshow(warped_img);
% figure(2);imshow(I1);
% figure(3);imshow(I2);

%% Check if the allignment was succesfull:

corr_before = corr(double(I2(:)), double(I1(:)));
corr_after = corr(double(I2(:)), double(warped_img(:)));
