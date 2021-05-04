function [distance, mean_distance, X]= computeP2PDistance(opts, points, plane)
    if isempty(opts)
        warning_output = 0;
    end
    if isempty(points)
        if warning_output
            warning("No points, returning 0")
        end
        distance = 0; 
    else
        centroid = makeColumn(plane.centroid);
        diff = [points(1:3,:) - centroid(1:3, :)];
        X = abs(makeRow(plane.unit_normals) * diff(1:3, :));
        distance = sum(X);
        mean_distance = mean(X);
    end
end