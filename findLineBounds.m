function [ bounds ] = findLineBounds( dilatedImage, noizeRate, minLineLength )
%findLineBounds Returns 2 dimensional array which consists the indexex of the
%start and the end of the line by x and by y 
%   Detailed explanation goes here
[x,y] = size(dilatedImage);
bounds = zeros(x,4);
prev_i = 1;
start_l_x = 0;
end_l_x = 0;
start_l_y = y;
end_l_y = 0;
disp(y);
for i = 1:x
    start = 0;
    en = 0;
    for j = 1:y
        if(dilatedImage(i,j) ~=0)
            if(start == 0)
            start = j;
            end
            en = j;
        end  
    end
    
    if(en-start>minLineLength)
       if(~emptyRowInBorders(dilatedImage(i,:),start,en,noizeRate))
           
           if(start<start_l_y)
               start_l_y=start;
           end;
           
           if(en>end_l_y)
               end_l_y=en;
           end;
           
           end_l_x = i;
       end
    else
        if(end_l_x>start_l_x)
            bounds(prev_i,1) = start_l_x+1;
            bounds(prev_i,2) = end_l_x;
            bounds(prev_i,3) = start_l_y;
            bounds(prev_i,4) = end_l_y;
            prev_i = prev_i+1;
            start_l_y = y;
            end_l_y = 0;
        end
        start_l_x = i;
    end
    
end;

end

