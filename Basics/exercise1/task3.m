% Remaking image from tables data. 

%% 
% Index matrix get values over 255, so the type is uint16
index_matrix = load('resources/tables/index_matrix.mat');
index_matrix = index_matrix.indeksimatriisi; 
[M, N] = size(index_matrix);

% Table has floating point values, so it needs to be double
table = load('resources/tables/table.mat');
table = table.taulukko;

%% Creating image by reading data from table.

% create matrix according to index matrix size filled with zeros.
img = zeros(M, N, 3);

% nested for loop that goes through each row, column and color.

% columns
for x = 1 : M
    
    % rows
    for y = 1 : N
        
        % colors
        for i= 1 : 3
            % convert double values to uint8
            img(y,x,i) = uint8(255 * table(index_matrix(M, N))); 
        end
    end
end

imshow(uint8(img));
