function plotAPlane(axes_h, a, b, c, d, start_t, end_t, interval, alpha)
    % ax + by + cz + d = 0
    % z = (-a/c) x + (-b/c) y - d/c
    if ~exist('alpha', 'var') || isempty(alpha)
        alpha = 0.5;
    end
    [x, y] = meshgrid(start_t:interval:end_t);  
    Zv = @(x,y) -d/c - (a/c) * x - (b/c) * y;
    h = mesh(axes_h, x, y, Zv(x,y));
    set(h,'FaceAlpha', alpha);
    set(h,'EdgeAlpha', alpha);
end