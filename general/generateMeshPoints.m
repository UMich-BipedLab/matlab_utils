function [xy_points, num_x, num_y] = generateMeshPoints(x_min, x_max, y_min, y_max, ...
    resolution)
%     num_x = abs(x_max - x_min) / resolution;
%     num_y = abs(y_max - y_min) / resolution;
%     num_points  = num_x * num_y;
%     xy_points = zeros(2, num_points);
    xy_points = [];
    x = x_min;
    num_x = 0;
    while x < x_max
        y = y_min;
        num_y = 0;
        while y < y_max
            points = [x; y];
            xy_points = [xy_points, points];
            y = y + resolution;
            num_y = num_y + 1;
        end
        x = x + resolution;
        num_x = num_x + 1;
    end
end