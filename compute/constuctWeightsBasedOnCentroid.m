function [weight_mat, centroid] = ...
    constuctWeightsBasedOnCentroid(points, centroid, dist_threshould)
    [n, m] = size(points);
    if ~(n == 3 || n== 4)
        error("points should be 4xn or 3xn. Current is [%i, %i]", n, m);
    end
    if ~exist('centroid', 'var') || isempty(centroid)
        centroid = mean(points, 2);
    end
    if ~exist('dist_threshould', 'var') || isempty(dist_threshould)
        dist_threshould = 1e0;
    end 
    
    weight_v = zeros(1, m);
    for i = 1:m
         dist = norm(points(:, i) - centroid);
         if dist > dist_threshould
             weight_v(i) = 0;
         else
             weight_v(i) = 1/dist;
         end
    end
    weight_mat = diag(weight_v);
end