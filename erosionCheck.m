%morphology erosion algorithm
function [isMatch] = erosionCheck(strElem,pos_x,pos_y,img)
    [x_s,y_s] = size(strElem);
    
    isMatch = true;
    for i = 1:x_s
        for j = 1:y_s
            if img(pos_x-int16(x_s/2)-1+i,pos_y-int16(y_s/2)-1+j)~=strElem(i,j)
                isMatch = false;
            end;
        end;
    end;
end

