function [ array ] = cutZeros( input_array )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [x,y] = size(input_array);
    count = 0;
    for i = 1: x
        flag = false;
        for j = 1:y
            if input_array(i,j)~=0
                flag = true;
            end
        end
        if flag == true
            count = count+1;
        end
    end
    
    array = zeros(count,4);
    for i = 1: count
        
        for j = 1:y
           array(i,j) = input_array(i,j);
        end
        
    end

end

