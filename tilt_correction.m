addpath('images');
addpath('functions');

img = imread('tilt2.jpg');
img = rgb2gray(img);
img = double(img);
img = img(1:4:end, 1:4:end);

E = edge(img, 'Sobel', 'vertical');
edges = find_dominant_edges(E);

slope = (edges(2,:) - edges(4,:)) ./ (edges(1,:) - edges(3,:));