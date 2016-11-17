%Sample code
close all;
clear all;


img=imread('images/test1.png');

ima = img;
colormap(gray(256));
ima = binarize(ima);
ima = inverse_bin(ima);
se1 = makeSE('square',1);
%ima = ero(buildStructuralElementForDim(3),ima);
%ima = closing(ima,se1);
% ima = ero(buildStructuralElementForDim(3),ima);
 %ima = dil(buildStructuralElementForDim(2),ima);
% ima = ero(buildStructuralElementForDim(3),ima);
ima = back_inverse_bin(ima);
image(ima);

