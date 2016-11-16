%undo transform to corresponding manner: 0-white  1-black, back to
%255-white 0-black
function [img] = back_inverse_bin(img_in)
    img = img_in;
    [x,y] = size(img);
    for i = 1:x
        for j = 1:y
            if img(i,j)==0
                img(i,j)=255;
            else
                img(i,j)=0;
            end;
        end;
    end;
end

