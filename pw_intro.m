% Introduction to matlab

close all;
clear all;


%To load an image

ima=imread('lena.tif');
imacoul=imread('zebras.jpg');

%To get information on matlab function, use the 'help' command

help size

%To get the size of an image and store it in variables 
%[number of rows,number of columns]:

[y,x]=size(ima);

%To get the value of a specific pixel 

ima(18,16)

% If you write:si on ecrit
ima(18,16);
% the value is not displayed

%To plot a specific row:

plot(ima(129,:));

%To plot a specific column 
plot(ima(:,134));

%To have two different graphics, you can use the 'figure()' function:

plot(ima(129,:));
figure();
plot(ima(:,134));

%To display an image
image(ima);

%To obtain a gray image with 256 levels, you need to specify the colormap:
colormap(gray(256));

%To be sure to exploit the full dynamic of the image:
plotim(double(ima));

%To get the minimum value of an image
min(min(ima))
%or
min(ima(:))

%To get the MAXIMUM value of an image

max(max(ima))
%or
max(ima(:))


%and the MEAN value
mean(mean(ima))
%or
mean(ima(:))

%To display an image as an image or as a mesh:
ima=imread('pyramide.tif');
plotim(double(ima));
figure;
mesh(double(ima));

%Histogram visualization

figure(2);
hist(double(ima(:)),256);

%Fourier domain

modfft=(abs(fftshift(fft2(ima))));
plotim(modfft);

phifft=angle(fftshift(fft2(ima)));
plotim(phifft);

%Subsampling

[nlines,ncolumns]=size(ima);
imasub=ima(1:2:nlines,1:2:ncolumns);

%Linear filtering

h=[ 1 1 1 1 1 ] ;
hh= h'* h / 25 ;
plotim(log(abs(fftshift(fft2(hh,512,512))))) ;
fil=conv2(double(ima),hh,'same');
plotim(fil);
