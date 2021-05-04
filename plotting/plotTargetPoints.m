function plotTargetPoints(opts, axes_h, points, use_intensity)
    % points = [X;Y;Z;I;R;1]
    if ~exist('use_intensity', 'var') || isempty(use_intensity)
        use_intensity = 0; % not using intensity
    else
        if ~isnumeric(use_intensity)
            if use_intensity == "use_intensity" 
                use_intensity = 1;
            else
                use_intensity = 0;
            end
        end
    end
    points_XYZ = points(1:3, :);
    
    if size(points, 1) > 3 && use_intensity% use intensity to plot 
        intensity = points(4, :) ./ 255;
        colormap(gray)
        scatter3(axes_h, points_XYZ(1, :), points_XYZ(2, :), points_XYZ(3, :), [], intensity, '.')
    else
        scatter3(axes_h, points_XYZ(1, :), points_XYZ(2, :), points_XYZ(3, :), 'b.')
    end
end