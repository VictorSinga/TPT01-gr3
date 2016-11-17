img = imread(sprintf('page%d_fixed.jpg', 4));
img = double((img));

neighbourhood = floor(size(img)/16);
sensitivity = 0.95;
iimg = integral_image(img);

T = zeros(size(img));

for i = 1:size(img,1)
    rowMin = max([1, i-neighbourhood(1)]);
    rowMax = min([size(img,1), i+neighbourhood(1)]);
    
    for j = 1:size(img,2)
        colMin = max([1, j-neighbourhood(2)]);
        colMax = min([size(img,2), j+neighbourhood(2)]);
        
        T(i,j) = (iimg(rowMax,colMax) + iimg(rowMin, colMin) - ...
            iimg(rowMax,colMin) - iimg(rowMin,colMax)) /...
            ((rowMax-rowMin) * (colMax - colMin));
    end
end


binary_img = reshape(img(:) > T(:)*sensitivity, size(img));

figure;
plotim(binary_img);