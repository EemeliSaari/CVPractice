% Practical assignment for course SGN-12001 Introduction to image and video
% processing.

%% 1. Loading images

frame1 = padarray(imread('rgbframe3338.png'), [20, 20], 'both');
frame2 = imread('rgbframe3339.png');
frame3 = padarray(imread('rgbframe3340.png'), [20, 20], 'both');

%% 2. Split the image to 40x40 slices.

target = split_image(frame2, 9, 16, 40);

%% 3. Finding the differences between frames by calculating MSE (mean square
%  error) between target image slices and slice from the search frames.

center = 21;

MSEkartta = zeros(9,16);
LVK = zeros(9,16,3);
for x = 1 : size(target,1)
    
    for y = 1 : size(target,2)
    
        frame1_comp = zeros(40,40);
        frame3_comp = zeros(40,40);
        
        slice_c = cell2mat(target{x,y});
        
        % Starting indexes for the search slices
        row_t = 20 + 1 + ((x-1)*40);
        col_t = 20 + 1 + ((y-1)*40);

        index_r = 1;
        for row = row_t : (row_t + 39)
            
            index_c = 1;
            for col = col_t : (col_t + 39)
                % First slice would be: [1:40,1:40]
                slice1 = frame1((row-20):(row+19),(col-20):(col+19),:);
                slice2 = frame3((row-20):(row+19),(col-20):(col+19),:);
                
                % Calculate the MSE with immse and store it into a matrix.
                frame1_comp(index_r,index_c) = immse(slice1, slice_c);
                frame3_comp(index_r,index_c) = immse(slice1, slice_c);
                
                index_c = index_c + 1;
            end
            index_r = index_r + 1;
        end
        
        % find the smallest MSE value
        min_frame1 = min(frame1_comp(:));
        min_frame3 = min(frame3_comp(:));
        
        % compare the mse values and determin which frame
        if(min_frame1 > min_frame3)
            [sf_x, sf_y] = find(frame3_comp == min_frame3);
            min_f = min_frame3;
            f = 2;
        elseif(min_frame1 == min_frame3)
            % Bias towards the frame which had the smallest overall
            % MSE in case the smallest MSE is the same in both frames.
            % Random otherwise.
            if(sum(min_frame1) > sum(min_frame3))
                f = 2;
            elseif(sum(min_frame1) < sum(min_frame3))
                f = 1;
            else    
                f = randi(2);
            end
            min_f = min_frame1;
            [sf_x, sf_y] = find(frame3_comp == min_frame3);
        else
            [sf_x, sf_y] = find(frame3_comp == min_frame3);
            min_f = min_frame3;
            f = 1;
        end
        % calculate difference to the center of the target slice
        sf_x = sf_x - center;
        sf_y = sf_y - center;
        % Save the results.
        LVK(x,y,:) = [sf_x, sf_y, f];
        MSEkartta(x,y) = min_f;
    end
end
