% Reding images from directory and using loop to plot subplots

%% Load images to a dir

% 112 sample images
path = 'resources/';
img_struct = dir(path);

%% Display the images in 8 by 14 subplot

struct_info = size(img_struct);
counter = 1;

% measure the loop time
tic

for n = 1 : struct_info(1)
    
    file_name = img_struct(n).name;
    
    % only interest in 'kuva' files
    if (strfind(file_name,'kuva') ~= 0) 
        subplot(8, 14, counter);
        
        img = imread(file_name);
        
        imshow(img);
        
        img_size = size(img); 
        
        x = img_size(1);
        y = img_size(2);
        
        text = [x, "x", y];
        % show the img size as (XxY)
        title(join(text));
        counter = counter + 1;
    end
end

% measure the loop time
toc