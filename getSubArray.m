function [ subArray ] = getSubArray( array, coord )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [xi,yi,zi] = size(array);
    subArray = zeros(coord(2)-coord(1),coord(4)-coord(3),zi);
    [x,y,z] = size(subArray);
    for i = 1:x
        for j =1:y
            for k = 1:zi
                subArray(i,j,k) = array(coord(1)-1+i,coord(3)-1+j,k)/255;
            end
        end;
    end

end

