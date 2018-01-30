function [frames, N, frameformat] = visualize(framepath)
% Visualize the frames from framepath
%   Returns frames, N frames and format of the frame

formats = load('formats.mat');
format = formats.formats;

d = dir(framepath);

frames = cell(1,length(d)-2);

N = 0;
length_d = size(d,1);
index = 1;

for i = 1 : length_d
    file_name = d(i).name;
    if(strcmp(file_name, '.') == 0 && strcmp(file_name,'..') == 0)
        N = N + 1;
        frames{index} = imread(fullfile(framepath, file_name));
        index = index + 1;
    end
end

frame_size = size(frames{1},2);
length_f = size(format,2);
name = cell(1);
for i = 1 : length_f
    if(format(i).horizontalsize == frame_size)
        name{1} = format(i).name; 
    end
end
frameformat = name{1};

rows = N / 3;
columns = N / rows;

figure(1);
for i = 1 : N
    subplot(columns,rows,i);
    imshow(frames{i});
end

posvec=[50 150 1024 768]; 
figure('Color',[0.5 0.5 0.5],'Position',posvec)
rgbframe=frames{1}; 
imagehandle=image(rgbframe,'EraseMode','None');
axis equal; axis off;
for index=2 : max(size(frames)) 
   rgbframe=frames{index}; 
   set(imagehandle,'Cdata',rgbframe); drawnow;
   pause(0.1) 
end 

end

