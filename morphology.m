%MorphologyBuilder
function []  = morphology()

end


%performs the morphology of erosion for an image with selected
%structuralElement
function [img] = erosion(strElem,img)
     [x,y] = size(img);
     for i = 1:x
        for j = 1:y
            if(~erosionCheck(strElem,i,j,img))
                img(i,j)=0;
            end;
        end;
     end;
end

%morphology erosion algorithm
function [isContained] = erosionCheck(strElem,pos_x,pos_y,img)
    [x_s,y_s] = size(strElem);
    [x_i,y_i] = size(img);
    
    isContained = true;
    if ((pos_x <= x_s/2)||(pos_x >= x_i-x_s/2)||(pos_y <= y_s/2)||(pos_y >= y_i-y_s/2))
        isContained = false;
    else
        for i = 1:x_s
            for j = 0:y_s
                if img(x-x_s/2-1+i,y-y_s/2-1+j)~=strElem(i,j)
                    isContained = false;
                end;
            end;
        end;
    end;
end
        

%make dummy binarization if not white then black
function [img] = binarize(img_in)
    img = img_in;
    [x,y] = size(img);
    for i = 1:x
        for j = 1:y
            if img(x,y)<255
                img(x,y)=0;
            end;
        end;
    end;
end


%todo: expand with other dimensions
%creates the structural Element for the morphology
function [structuralElement] = buildStructuralElementForDim(dimension)

    if dimension == 7
    structuralElement = [0 0 0 1 0 0 0
                         0 1 1 1 1 1 0
                         0 1 1 1 1 1 0
                         1 1 1 1 1 1 1
                         0 1 1 1 1 1 0
                         0 1 1 1 1 1 0
                         0 0 0 1 0 0 0];
    end;      
end