function param = findParameter(letter, data)
% Helper functio to find particular string set in a cell data.
%   Splits each set and returns '420' if none were found.

out = '420';
for i = 1 : size(data,2)
    target = strsplit(cell2mat(data(i)), letter);
    % strsplit returns 1x1 cell if it was not able to find anything
    % to split.
    if(size(target,2) > 1)
        out = cell2mat(target(2));
        break;
    end
end
param = out;
end

