num_pages = 6;

final_figure = figure;

for i = 1:6
    img = imread(sprintf('page%d.jpg', i));
    img = double(rgb2gray(img));

    figure(final_figure);
    if(num_pages == 1)
        subplot(1, 2, 1);
    else
        subplot(num_pages,2, 2*i -1);
    end
    plotim(img);

    page = page_perspective_correction(img, false);
    figure(final_figure);
    if(num_pages == 1)
        subplot(1, 2, 2);
    else
        subplot(num_pages,2, 2*i);
    end
    plotim(page);

    imwrite(page/255, sprintf('page%d_fixed.jpg', i));

end