% In this assignment the task was to parse info out from the matlabs struct
% file and then create own struct that was created by parsing a string.

%% Load the video file info file and display the index, header, name.

video_diff = load("resources/videofileinfo.mat");
video_info = video_diff.videofileinfo;

for i = 1 : size(video_info,2)
   
    index = int2str(video_info(i).index);
    header = video_info(i).header;
    name = video_info(i).name;
    
    text = join([index, "...", header, "...", name]);
    
    disp(text);
end

%% Create a struct for the videofile info

parameters(1,1).name = [];
parameters(1,2).W = [];
parameters(1,3).H = [];
parameters(1,4).F = [];
parameters(1,5).I = [];
parameters(1,6).A = [];
parameters(1,7).C = [];

% parse the header info for the info using the 
% function findParameter(string, data).
for i = 1 : size(video_info, 2)
    
    info = video_info(i).header;
    name = video_info(i).name;
    data = strsplit(info);    
    
    parameters(i).name = name; % added the name of the file
    parameters(i).W = findParameter('W', data);
    parameters(i).H = findParameter('H', data);
    parameters(i).F = findParameter('F', data);
    parameters(i).I = findParameter('I', data);
    parameters(i).A = findParameter('A', data);
    parameters(i).C = findParameter('C', data);
    
end

%% Test the struct.

% courses test script - name added.
for n=1:length(parameters)
    disp(['Name:' parameters(n).name ' W: ' num2str(parameters(n).W) ...
        ' H: ' num2str(parameters(n).H) ' F: ' parameters(n).F ...
        ' I: ' parameters(n).I ' A: ' parameters(n).A ' C: ' parameters(n).C]) 
end
