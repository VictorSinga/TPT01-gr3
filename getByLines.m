function [ linesImages ] = getByLines( image, lines )
%UNTITLED get the array of images of lines of the text

    [x,y] = size(lines);
    for i = 1 : x
        disp(lines(i,:));
        linesImages{i} = getSubArray(image,lines(i,:));
    end

end

