%make dummy binarization if not white then black
function [img] = binarize(img_in)
    img = img_in;
    [x,y] = size(img);
    for i = 1:x
        for j = 1:y
            %disp(img(x,y));
            if img(i,j)<255
                img(i,j)=0;
            end;
        end;
    end;
end

