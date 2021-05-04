function [plane, weight_mat, centroid, opts] = ...
    computeWeightedPlane(opts, points)
    [n, m] = size(points);
    if ~(n == 3 || n== 4)
        error("points should be 4xn or 3xn. Current is [%i, %i]", n, m);
    end
    
    [weight_mat, centroid] = constuctWeightsBasedOnCentroid(points);
    Xs = points(1, :)';
    Ys = points(2, :)';
    Zs = points(3, :)';
    Ones = ones(m, 1);
    A = [Zs, Ys, Ones];
    Y = Xs;
    
    % X [a, b, d]; 
    % plane equation: x = by + az + d
    % -> x - by - az - d = 0
    X = (A' * weight_mat * A) \ A' * weight_mat * Y;
    plane.a = 1;
    plane.b = -X(2);
    plane.c = -X(1);
    plane.d = -X(3);
    plane.normals = [plane.a, plane.b, plane.c];
    plane.unit_normals = plane.normals ./ norm(plane.normals);
    plane.centroid = [0, 0, -plane.d/plane.c];
end