function plotAPlaneWithNormalNPoint(axes_h, normal, point, start_t, end_t, interval, alpha)
    % n1 * x + n2 * y + n3 * z + d = 0
    % -> d = -normal(1) * point(1) - normal(2) * point(2) - normal(3) * point(3)
    if ~exist('alpha', 'var') || isempty(alpha)
        alpha = 0.5;
    end
    d = -normal(1) * point(1) - normal(2) * point(2) - normal(3) * point(3);
    plotAPlane(axes_h, normal(1), normal(2), normal(3), ...
        d, start_t, end_t, interval, alpha)
end