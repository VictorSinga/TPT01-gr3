%get the array of the lines of text from the binarized prepared image
%
% image is the matrix of pixels obtained by imread()
% lines is the array of lines one by one (array of matrix of pixels)
% 
function [lines] = lines_recognition(image)
    %get the dimension of the matrix
    [rows,columns] = size(image);
end


%check if the row of the matrix contains black pixels and it is, if it seems
%that it is the pixels of letters
%noizeProba is the suggested noize rate < 1
function [isRowContainsSymbols] = isRowContainsSymbols(row, noizeProba)
    l = size(row);
    rate = 0;
    for i = 1:l
        rate = rate+1;
    end
    if rate < l*noizeProba
        isRowContainsSymbols = false;
    else
        isRowContainsSymbols = true;
    end
end



