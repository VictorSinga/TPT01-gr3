% use RANSAC to get the parameters of a line that best fit given points
% input: set of points
% output: parameters of a line
%         [p_x; p_y; q_x; q_y] for a line defined by points |pq|
function [line, inliers] = approximate_line(points, center)
    N = size(points, 2);
    threshold = 3;
    support = 0;
    line = [];
        
    for i = 1:100
        sample = randsample(N, 2);
        x = points(:, sample(1));
        y = points(:, sample(2));
        
        dist = (y(2)-x(2))*points(1,:) - (y(1)-x(1))*points(2,:) ...
            + repmat(y(1)*x(2), 1, length(points))...
            - repmat(y(2)*x(1), 1, length(points));
        dist = abs(dist) / sqrt((y(2)-x(2))^2 + (y(1)-x(1))^2);
        supp = length(find(dist < threshold));
        
        if(supp > support)
            support = supp;
            line = [x; y];
            inliers = find(dist < threshold);
        end
    end
end