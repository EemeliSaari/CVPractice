% Functio syntax in Matlab

% cr: returning value
% listing: function name
% path: functio parameter
function cr = listing( path )
% Lists all full paths of files in a directory path
%   Adds all file names with complete path to a cell.
    d = dir(path);
    dir_size = size(d);

    % initialize a cell for specific size to increase the speed
    % dir struct has '.' and '..' that we don't want to add.
    c = cell(dir_size(1) - 2 , 1);
    counter = 1;
    
    for n = 1 : dir_size(1)
        file_name = d(n).name;
        
        % ignore the '.' and '..' from d struct.
        if (strcmp(file_name, '.' ) == 0) && (strcmp(file_name, '..' ) == 0)
            f_path = [d(n).folder, file_name];
            c{counter} = join(f_path);
            counter = counter + 1;
        end

    end

    cr = c;

end
