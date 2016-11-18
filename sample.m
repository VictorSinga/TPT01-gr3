%Sample code
close all;
clear all;


img=imread('images/page1_BW.jpg');

ima = img;
colormap(gray(256));
figure();
image(transpose(ima));
% figure(2);
% ima = binarize(ima);
% [x,y] = size(ima);
% disp(y);
% disp(x);
% ima = inverse_bin(ima);
% ima = ero(buildStructuralElementForDim(1),ima);
% ima = dil(buildStructuralElementForDim(7),ima);
% ima = ero(buildStructuralElementForDim(7),ima);
% lines = findLineBounds(ima,0.001,10);
% lines = cutZeros(lines);
% lines = extendBorders(lines,5);
% ima = back_inverse_bin(ima);
% image(ima);
% images = getByLines(img,lines);
% colormap(gray(256));
% disp(size(images));
% [x,y] = size(images);
% 
% for i = 1 : y
%     try
%     s = sprintf('images/line %i.png', i);
%     imwrite(images{i},s);
%     catch
%     end;
% end
% 
% l = im2bw(imread('images/line 1.png'),0.9);
% disp(wordcountinlines(l));
