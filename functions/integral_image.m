function iimg = integral_image(img)
    iimg = img;
    
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            if(i > 1)
                iimg(i,j) = iimg(i,j) + iimg(i-1,j);
            end
            if(j > 1)
                iimg(i,j) = iimg(i,j) + iimg(i,j-1);
            end
            if(i > 1 && j > 1)
                iimg(i,j) = iimg(i,j) - iimg(i-1,j-1);
            end
        end
    end
    
end