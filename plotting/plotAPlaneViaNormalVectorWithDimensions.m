% plotAPlaneWithNormalNPoint(axes_h, [0,0,1], [0,0,0], -1, 1, 0.1, 1)
% dimensions: minx, maxx, miny, maxy for xy plane
% dimensions: miny, maxy, minz, maxz for yz plane
function plotAPlaneViaNormalVectorWithDimensions(axes_h, normal, point, dimensions, interval, alpha)
    % n1 * x + n2 * y + n3 * z + d = 0
    % -> d = -normal(1) * point(1) - normal(2) * point(2) - normal(3) * point(3)
    if ~exist('alpha', 'var') || isempty(alpha)
        alpha = 0.5;
    end
    d = -normal(1) * point(1) - normal(2) * point(2) - normal(3) * point(3);
    
    
    if normal(3) == 0
        % yz plane
        dimensions = [point(2) + dimensions(1), point(2) + dimensions(2), ...
                      point(3) + dimensions(3), point(3) + dimensions(4)];
    else
        % xy plane
        dimensions = [point(1) + dimensions(1), point(1) + dimensions(2), ...
                      point(2) + dimensions(3), point(2) + dimensions(4)];
    end
    plotAPlaneWithDimensions(axes_h, normal(1), normal(2), normal(3), d, ...
        dimensions, interval,alpha)
end