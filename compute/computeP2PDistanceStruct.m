function distance_t = computeP2PDistanceStruct(opts, points, plane)
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
        
        distance_t.X = X;
        distance_t.sum_distance = distance;
        distance_t.mean_distance = mean_distance;
        distance_t.std_distance = std_distance;
        distance_t.thickness = abs(max(X) - min(X));
    end
end