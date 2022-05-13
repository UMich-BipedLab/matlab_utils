function plotAPlaneWithDimensions(axes_h, a, b, c, d, dimensions, interval, ...
    alpha, type_of_plane, color)
    % ax + by + cz + d = 0
    % z = (-a/c) x + (-b/c) y - d/c
    % x = (-b/a) y + (-c/a) z - d/a
    % dimensions: minx, maxx, miny, maxy for xy plane
    % dimensions: miny, maxy, minz, maxz for yz plane
    if ~exist('alpha', 'var') || isempty(alpha)
        alpha = 0.5;
    end
    if ~exist('type_of_plane', 'var') || isempty(type_of_plane)
        type_of_plane = "mesh";
    end
    if ~exist('color', 'var') || isempty(color)
        color = "r";
    end
    [xy_points, num_x, num_y] = generateMeshPoints(dimensions(1), dimensions(2), ...
        dimensions(3), dimensions(4), interval);

    if (c == 0)
        % yz plane
        ys = xy_points(1, :);
        zs = xy_points(2, :);
        
        y = reshape(ys, [num_y, num_x]);
        z = reshape(zs, [num_y, num_x]);
        Xv = @(y,z) -d/a - (b/a) * y - (c/a) * z;
        if type_of_plane == "mesh"
            h = mesh(axes_h, Xv(y, z), y, z);
        elseif type_of_plane == "surf"
            h = surf(axes_h, Xv(y, z), y, z);
        end
    else
        % xy plane
        xs = xy_points(1, :);
        ys = xy_points(2, :);
        x = reshape(xs, [num_y, num_x]);
        y = reshape(ys, [num_y, num_x]);
        
        Zv = @(x,y) -d/c - (a/c) * x - (b/c) * y;
        if type_of_plane == "mesh"
            h = mesh(axes_h, x, y, Zv(x,y));
        elseif type_of_plane == "surf"
            h = surf(axes_h, x, y, Zv(x,y), 'FaceColor', color, ...
                'EdgeColor', color);
        end
    end
    set(h,'FaceAlpha', alpha);
    set(h,'EdgeAlpha', alpha);
end