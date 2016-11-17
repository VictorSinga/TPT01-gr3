%morphology dilation algorithm
function [isHit] = dilationCheck(strElem,pos_x,pos_y,img)
    [x_s,y_s] = size(strElem);
    
    isHit = false;
    for i = 1:x_s
        for j = 1:y_s
            if strElem(i,j)==1&&img(pos_x-int16(x_s/2)-1+i,pos_y-int16(y_s/2)-1+j)==strElem(i,j)
                isHit = true;
            end;
        end;
    end;
end

