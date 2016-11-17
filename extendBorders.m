function [ lines ] = extendBorders( lines,rate )
    [x,y] = size(lines);
    for i = 1:x
        lines(i,1) = lines(i,1) - rate;
        lines(i,2) = lines(i,2) + rate;
    end;
end

