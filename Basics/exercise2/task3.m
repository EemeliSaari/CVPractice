t% Histogram

%% Initialize the directory full of images.

d = dir('resources');

% counter for subplot
c = 1;

%% Iterate every image in directory

for n = 1 : size(d,1)
    file_name = d(n).name;
    
    % ignore '.' and '..'
    if(strcmp(file_name, '.') == 0 && strcmp(file_name, '..') == 0)
        img = imread(file_name);
        subplot(4, 4, c);
        imshow(img);
        
        c = c + 1;
        
        subplot(4, 4, c);
        
        % speeds things up by a lot to first just use histcount
        % to get a vector 
        h = histcounts(double(img), 0:255);
        bar(h);
        
        c = c + 1;
        
        % to keep track of for loop
        display(n);
    end
end