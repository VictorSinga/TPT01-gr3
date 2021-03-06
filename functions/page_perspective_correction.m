% corrects the perspective deformation of a page
% input: grayscale image of a page
% output: grayscale image of a page with corrected perspective
function page = page_perspective_correction(img, debug)
    %% preprocessing
    if(nargin < 2)
        debug = 0;
    end

    % subsample for better performance
    subsample_rate = 4;
    img_subsampled = img(1:subsample_rate:end, 1:subsample_rate:end);
    
    %% non-linear filtering - local maximum
    fun = @(x) max(x(:));
    img_subsampled = nlfilter(img_subsampled, [5, 5], fun);
    
    %% crop the image to remove uninteresting background
    mask = zeros(size(img_subsampled));
    mask(round(size(img_subsampled,1) * 0.1):round(size(img_subsampled,1) * 0.9), ...
        round(size(img_subsampled,2) * 0.1):round(size(img_subsampled,2) * 0.9)) = 1;
    C = activecontour(img_subsampled, mask);
    
    [row, col] = find(C);
    offsetRow = round(size(img_subsampled,1) * 0.05);
    offsetCol = round(size(img_subsampled,2) * 0.05);
    
    img_subsampled(1:(min(row)+offsetRow),:) = [];
    img_subsampled((max(row)-offsetRow):end,:) = [];
    img_subsampled(:, 1:(min(col)+offsetCol)) = [];
    img_subsampled(:, (max(col)-offsetCol):end) = [];
    
    img(1:((min(row)+offsetRow)*subsample_rate),:) = [];
    img(((max(row)-offsetRow)*subsample_rate):end,:) = [];
    img(:, 1:((min(col)+offsetCol)*subsample_rate)) = [];
    img(:, ((max(col)-offsetCol)*subsample_rate):end) = [];
    
    %% find dominant edges
    edges = edge(img_subsampled, 'Sobel');
    [vertical_edges, vertical_points] = find_dominant_edges(edges);
    [horizontal_edges, horizontal_points] = find_dominant_edges(edges');
    horizontal_edges = horizontal_edges([2, 1, 4, 3], :);
    horizontal_points = horizontal_points([2, 1], :);
    
    % show dominant edges if in debug mode
    if(debug)
        figure;
        imshow(edges);
        hold on;
        
        for e = 1:size(vertical_edges, 2)
            plot([vertical_edges(2,e), vertical_edges(4,e)], ...
                [vertical_edges(1,e), vertical_edges(3,e)], ...
                'color', 'green', 'LineWidth', 3);
        end
        
        for e = 1:size(horizontal_edges, 2)
            plot([horizontal_edges(2,e), horizontal_edges(4,e)], ...
                [horizontal_edges(1,e), horizontal_edges(3,e)], ...
                'color', 'blue', 'LineWidth', 3);
        end
    end
    
    %% find sides of the sheet
    % use RANSAC to get line parameters, then remove inliers and repeat to
    % get the other dominant line
    points = [horizontal_points, vertical_points];
    [l1, l1_in] = approximate_line(points, size(img_subsampled)'/2);
    points(:, l1_in) = [];
    [l2, l2_in] = approximate_line(points, size(img_subsampled)'/2);
    points(:, l2_in) = [];
    [l3, l3_in] = approximate_line(points, size(img_subsampled)'/2);
    points(:, l3_in) = [];
    [l4, l4_in] = approximate_line(points, size(img_subsampled)'/2);
    points(:, l4_in) = [];
    
    %[h1, h1_in] = approximate_line(horizontal_points);
    %horizontal_points(:, h1_in) = [];
    %[h2, h2_in] = approximate_line(horizontal_points);
    
    %[v1, v1_in] = approximate_line(vertical_points);
    %vertical_points(:, v1_in) = [];
    %[v2, v2_in] = approximate_line(vertical_points);
    
    if(debug)
        plot([l1(1), l1(3)], [l1(2), l1(4)], 'color', 'yellow', 'LineWidth', 3);
        plot([l2(1), l2(3)], [l2(2), l2(4)], 'color', 'yellow', 'LineWidth', 3);
        plot([l3(1), l3(3)], [l3(2), l3(4)], 'color', 'yellow', 'LineWidth', 3);
        plot([l4(1), l4(3)], [l4(2), l4(4)], 'color', 'yellow', 'LineWidth', 3);
        %plot([h1(1), h1(3)], [h1(2), h1(4)], 'color', 'yellow', 'LineWidth', 3);
        %plot([h2(1), h2(3)], [h2(2), h2(4)], 'color', 'yellow', 'LineWidth', 3);
        %plot([v1(1), v1(3)], [v1(2), v1(4)], 'color', 'yellow', 'LineWidth', 3);
        %plot([v2(1), v2(3)], [v2(2), v2(4)], 'color', 'yellow', 'LineWidth', 3);
    end
    
    %% find corners - intersections of page sides
    line_l1 = cross(e2p(l1(1:2)), e2p(l1(3:4)));
    line_l2 = cross(e2p(l2(1:2)), e2p(l2(3:4)));
    line_l3 = cross(e2p(l3(1:2)), e2p(l3(3:4)));
    line_l4 = cross(e2p(l4(1:2)), e2p(l4(3:4)));
    
    lines = [line_l1, line_l2, line_l3, line_l4];
    
    %line_h1 = cross(e2p(h1(1:2)), e2p(h1(3:4)));
    %line_h2 = cross(e2p(h2(1:2)), e2p(h2(3:4)));
    %line_v1 = cross(e2p(v1(1:2)), e2p(v1(3:4)));
    %line_v2 = cross(e2p(v2(1:2)), e2p(v2(3:4)));
    
    corners = [];
    for i = 1:3
        for j = (i+1):4
            corners = [corners, p2e(cross(lines(:,i), lines(:,j)))];
        end
    end
    
    dist = corners - repmat(size(img_subsampled)' / 2, [1, 6]);
    dist = sum(dist .^ 2);
    [~, idx] = max(dist);
    dist(idx) = [];
    corners(:,idx) = [];
    [~, idx] = max(dist);
    corners(:,idx) = [];
    
    corners = corners * subsample_rate;
    
    %corner1 = p2e(cross(line_h1, line_v1));
    %corner2 = p2e(cross(line_h2, line_v1));
    %corner3 = p2e(cross(line_h1, line_v2));
    %corner4 = p2e(cross(line_h2, line_v2));
    
    %corners = [corner1, corner2, corner3, corner4] * subsample_rate;
    
    if(debug)
        for i = 1:4
            plot(corners(1, i), corners(2, i), 'rx', 'MarkerSize', 10, 'LineWidth', 4);
        end
    end
    
    %% find correct dimensions of a page
    % standard page has aspect ration sqrt(2)
    
    max_width_candidates = [];
    max_height_candidates = [];
    
    for i = 1:3
        for j = (i+1):4
            max_width_candidates = [max_width_candidates, abs(corners(1,i) - corners(1,j))];
            max_height_candidates = [max_height_candidates, abs(corners(2,i) - corners(2,j))];
        end
    end
    
    max_width = max(max_width_candidates);
    max_height = max(max_height_candidates);
    
    % "rotate" the page depending on whether it is landscape or portrait
    if(sum((corners(:,1)-corners(:,2)).^2) > sum((corners(:,1)-corners(:,3)).^2)) 
        corners = corners(:, [1, 3, 2, 4]);
    end
    
    if(max_height < sqrt(2) * max_width)
        max_height = sqrt(2) * max_width;
    else
        max_width = max_height / sqrt(2);
    end
    
    max_width = round(max_width);
    max_height = round(max_height);
    
    rect_corners = [0, max_width, 0, max_width; 0, 0, max_height, max_height];
    
    if(debug)
        for i = 1:4
            %plot([corners(1, i), rect_corners(1,1)], [corners(2, i), rect_corners(2,1)], 'color', 'red', 'LineWidth', 2);
        end
    end
    
    %% find homography
    H = get_homography(rect_corners, corners);
    [Xq, Yq] = meshgrid(1:max_width, 1:max_height);
    coords = [Xq(:)'; Yq(:)'];
    projected_points = round(p2e(H*e2p(coords)));
    
    [X, Y] = meshgrid(1:size(img,2), 1:size(img,1));
    page = interp2(X, Y, img, reshape(projected_points(1,:), [max_height, max_width]), reshape(projected_points(2,:), [max_height, max_width]));
    
    %% crop page
    page = page(round(max_height * 0.02):round(max_height * 0.98), round(max_width * 0.02):round(max_width * 0.98));
end