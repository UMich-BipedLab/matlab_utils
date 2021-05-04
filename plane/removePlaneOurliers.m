function [inliers, outliers, normal, centroid] = removePlaneOurliers(points_mat, min_noise_threshold, opts)
    if ~exist('opts', 'var')
        plotting = 0;
    elseif isnumeric(opts)
        plotting = opts;
    elseif isstruct(opts)
        if ~isfield(opts, 'plotting')
            plotting = 0;
        else
            plotting = opts.plotting;
        end
    end

    org_std_noise = estimatePlanarNoise(points_mat);
    std_noise = max(org_std_noise(3), min_noise_threshold/3);
    ptCloud = pointCloud(points_mat(1:3,:)');
    [~, inlierIndices,outlierIndices] = pcfitplane(ptCloud, 3*std_noise);
    inliers = points_mat(:, inlierIndices);
    outliers = points_mat(:, outlierIndices);
    [normal, centroid] = computePlane(inliers);
    
    if plotting
        [outlier_axes, ~] = createFigHandleWithNumber(2, 30, "Outliers removal", [], 0);
        cur_axes = outlier_axes(1);
%         popCurrentFigure(outlier_fig(1));
%         plot(model)
        h1 = scatter3(cur_axes, inliers(1,:), inliers(2,:), inliers(3,:), 'r.');
        h2 = scatter3(cur_axes, outliers(1,:), outliers(2,:), outliers(3,:), 'b.');
        legend(cur_axes, [h1 ,h2], "inliers", "outliers")
        viewCurrentPlot(cur_axes, "Inliers and Outliers")
    end
    
end