function plotAPlane(axes_h, a, b, c, d, start_t, end_t, interval, ...
    alpha, type_of_plane)
    % ax + by + cz + d = 0
    % z = (-a/c) x + (-b/c) y - d/c
    % x = (-b/a) y + (-c/a) z - d/a
    if ~exist('alpha', 'var') || isempty(alpha)
        alpha = 0.5;
    end
    if ~exist('type_of_plane', 'var') || isempty(type_of_plane)
        type_of_plane = "mesh";
    end
    if (c == 0)
        % yz plane
        [y, z] = meshgrid(start_t:interval:end_t);  
        Xv = @(y,z) -d/a - (b/a) * y - (c/a) * z;
        if type_of_plane == "mesh"
            h = mesh(axes_h, Xv(y, z), y, z);
        elseif type_of_plane == "surf"
            h = surf(axes_h, Xv(y, z), y, z);
        end
    else
        [x, y] = meshgrid(start_t:interval:end_t);  
        Zv = @(x,y) -d/c - (a/c) * x - (b/c) * y;
        if type_of_plane == "mesh"
            h = mesh(axes_h, x, y, Zv(x,y));
        elseif type_of_plane == "surf"
            h = surf(axes_h, x, y, Zv(x,y));
        end
        
    end
    set(h,'FaceAlpha', alpha);
    set(h,'EdgeAlpha', alpha);
end