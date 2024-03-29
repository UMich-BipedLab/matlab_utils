function [distance_t, X,distance, mean_distance, std_distance, X]= computeP2PDistance(opts, points, plane)
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
        if ~isfield(plane, 'unit_normals')
            plane.unit_normals = plane.normal ./ (norm(plane.normal));
        end
        X = abs(makeRow(plane.unit_normals) * diff(1:3, :));
        distance = sum(X);
        mean_distance = mean(X);
        std_distance = std(X);
    end
end