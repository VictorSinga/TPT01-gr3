%performs the morphology of dilation for an image with selected
%structuralElement
function [img_n] = ero(strElem,img)
     img_n = img;
     [x,y] = size(img);
     [x_s,y_s] = size(strElem);
     for i = 1+int16(x_s/2):x-int16(x_s/2)
        for j = 1+int16(y_s/2):y-int16(y_s/2)
            if(~erosionCheck(strElem,i,j,img))
                img_n(i,j)=0;
            end;
        end;
     end;
end
