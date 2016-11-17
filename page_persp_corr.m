num_pages = 1;

final_figure = figure;

for i = 1
    img = imread(sprintf('page%d.jpg', i));
    img = double(rgb2gray(img));
    %img = img(1:4:end, 1:4:end);

    figure(final_figure);
    %subplot(num_pages,2, 2*i -1);
    subplot(1, 2, 1);
    plotim(img);

    page = page_perspective_correction(img, false);
    figure(final_figure);
    %subplot(num_pages,2,2*i);
    subplot(1, 2, 2);
    plotim(page);

    imwrite(page/255, sprintf('page%d_fixed.jpg', i));

end