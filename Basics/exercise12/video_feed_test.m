% Testing the read_img funtion in practice

%% Read file and needed params from the file.

filename = 	'resources/akiyo_qcif.y4m';
fid = fopen(filename,'r');
datavector=fread(fid,100,'uint8');
keyword='FRAME';

fclose(fid);	
headerline=char(datavector');

%searching where the frame data begins
index=strfind(headerline,keyword);
%read only the header
header = headerline(1:index-2);

data = strsplit(header);

W = findParameter('W', data);
H = findParameter('H', data);

% read the image data for processing:

%define cols and rows according to the header
cols = str2num(W);
rows = str2num(H);

Nmax=50; 			%number of frames to read max
fid = fopen(filename,'r'); 	%open the file
keyword='FRAME';		%the frame tag to search for

%computing the segment length:
segmentlength = (rows*cols*1.5)+length(keyword)+1;

%searching the first index
firstindex=strfind(char(datavector)',keyword);

%variable for locations, first column defines index number, second the location
locations=[1 2];

%searching the frame locations:
for frameindex=1 : Nmax
   location=(frameindex-1)*segmentlength+firstindex;
   locations=cat(1,locations,[frameindex location]); %collect the frame locations to 2 x Nmax vector
end

%the first location is false and thus left out
locations = locations(2:end,:);

%% Calculate the position and display the frames from loop.

posvec=[50 150 1024 768]; 
figure('Color',[0.5 0.5 0.5],'Position',posvec)

rgbframe=read_img(fid,locations(1,1),rows,cols);

imagehandle=image(rgbframe,'EraseMode','None');
axis equal; axis off;
for index=1 : size(locations,1) 
	pointeroffset=locations(index,2)+length(keyword);
    rgbframe=read_img(fid,pointeroffset, rows,cols); 
    set(imagehandle,'Cdata',rgbframe); drawnow;
    pause(0.05) 
end 