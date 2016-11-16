function [ image ] = drawBorders( image,lines )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
[x,y] = size(lines);
[imx,imy] = size(image);
    for k =1:x
        if(lines(k,1~=0))
            for i = 1:imx
               
                for j = 1:imy
                     if i == lines(k,1) || i == lines(k,2) 
                        image(i,j) = 1;
                    end
                end
            end
        end
    end

end

