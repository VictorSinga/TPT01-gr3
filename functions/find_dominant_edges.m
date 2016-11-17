% input: binary image with detected vertical edges
% output: parameters of vertical lines, points
%         [p_x; p_y; q_x; q_y] for a line defined by points |pq|
%         [p_x; p_x] for points
function [edges, points] = find_dominant_edges(E, debug)
    if(nargin < 2)
        debug = 0;
    end
    
    if(debug)
        E_original = E;
    end
    
    edges = [];
    points = [];
    directions = [-1, 0, 1];
    min_length = 15;
    
    for line = 1:(size(E, 1) - min_length)
        indices = find(E(line,:));
        
        for idx = indices
            counter = 0;
            E(line, idx) = 0;
            % slope: 0 - undecided, -1 - left, 1 - right
            queue = [line; idx; 0]; % row, column, slope
            q = [];
            current_points = [];
            
            while(~isempty(queue))
                counter = counter + 1;
                q = queue(:, 1);
                queue = queue(:, 2:end);
                
                for d = directions
                    if(d ~= 0 && q(3) ~= 0 && q(3) ~= d)
                        continue;
                    end
                    if(q(2)+d <= 0 || q(2)+d >= size(E,2))
                        continue;
                    end
                    if(q(1)+1 >= size(E,1))
                        continue;
                    end
                    
                    slope = d;
                    if(q(3) ~= 0)
                        slope = q(3);
                    end
                    
                    if(E(q(1)+1, q(2)+d) == 1)
                        current_points = [current_points, [q(2)+d; q(1)+1]];
                        queue = [queue, [q(1)+1; q(2)+d; slope]];
                        E(q(1)+1, q(2)+d) = 0;
                    end
                end
            end
            
            if(counter >= min_length)
                edges = [edges, [line; idx; q(1); q(2)]];
                points = [points, current_points];
            end
            
        end
        
    end
    
    if(debug)
        figure;
        imshow(E_original);
        hold on;
        for e = 1:size(edges, 2)
            plot([edges(2,e), edges(4,e)], [edges(1,e), edges(3,e)], 'color', 'red', 'LineWidth', 3);
        end
    end

end