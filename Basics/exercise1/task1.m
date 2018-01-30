% Very first task to introduction course to Image processing
% Task was to practice basics of Matlabs Image Process Toolkit

%% Loading the image
pics = load("kuvat.mat");

I1 = pics.I;
I2 = pics.I2;

% Double values should all be between 1 and 0 but I3 is type
% double with values rangeing from 0 to 255.
I3 = pics.I3;

%% Saving the image
Imwrite(I1, 'kuva1.jpg');

%% Playing with the image matrix

% source: http://photojournal.jpl.nasa.gov/jpeg/PIA14317.jpg 
img = imread('resources/PIA14317.jpg');

[x, y] = size(img);

% taking the center row of image
center_row = img((x / 2), :);
plot(center_row);

%% Take region from image
% source: http://imgsrc.hubblesite.org/hu/db/images/hs-2006-01-a-1680x1050_wallpaper.jpg
wp = imread('resources/hs-2006-01-a-1680x1050_wallpaper.jpg');
figure; 
hold on;
f1 = imshow(wp);

% use ginput to get two points from user
[p1, p2] = ginput(2);

set(f1,'Visible','off')

x1 = uint16(p2(1));
x2 = uint16(p2(2));
y1 = uint16(p1(1));
y2 = uint16(p1(2));

roi = wp(x1:x2,y1:y2);

imshow(roi);
