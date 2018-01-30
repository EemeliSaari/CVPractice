function rgb = read_img(fid, pos, heigth, width)
% Reads the frame from a video file.
%   Returns rgb image from a given position of the file


keyword='FRAME';
seglen = (heigth*width*1.5)+length(keyword)+1;

status = fseek(fid, pos, 'bof');

data = fread(fid, seglen-length(keyword)-1, 'uint8');

%reading the y component
yy=data(1:width*heigth);

%reading the Cb component
ccb=data(length(yy)+1:length(yy)+((heigth/2)*(width/2)));

%reading the Cr compone
ccr=data(length(yy)+length(ccb)+1:length(yy)+length(ccb)+((heigth/2)*(width/2)));

Y = reshape(yy,[width,heigth])' - 16;
Cb = imresize(reshape(ccb,[width/2,heigth/2])',2) - 128;
Cr = imresize(reshape(ccr,[width/2,heigth/2])',2) - 128;

input = cat(2, Y(:), Cb(:), Cr(:));
rgb = uint8(ycbcr2rgb(input , heigth, width));

end

