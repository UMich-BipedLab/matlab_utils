% More detail, check test_line_quantization.m
% clc
% addpath(genpath("/home/brucebot/workspace/matlab_utils"));
% addpath("/home/brucebot/workspace/lc-calibration/L1_relaxation")
% loadLibraries(2);
% 
% vertices = load("/home/brucebot/workspace/lc-calibration/L1_relaxation/original_shape.mat");
% rotatated_ideal = [300 0 0];
% vertices.original_shape = moveByRPYXYZ(vertices.original_shape, rotatated_ideal, [0 0 0]);
% lidar_vertices = vertices.original_shape(1:3, :);
% [object_list, ~] = createOptimalShape([0 0 0], [0.7, 0, 0.2], lidar_vertices);
% % [sorted_vertices, ~, ~] = sortVertices([], X_h);
% 
% cam = loadCameraModel();
% [pixel_frame, objects]= loadPixelFrame(cam.setting.image_size);
% lidar_target.corners = object_list.object_vertices_mat_h;
% camera_corners = projectionMap(lidar_target(1).corners, cam.projection);
% 
% quantization = 0.1;
% corners = t_quantify2DShape(camera_corners, quantization);
% camera_corners
% corners
function [quitified_corners, RMSE, quantified_t] = quantify2DShape(corners, quantization)
    num_points = size(corners, 2);
    ordered_list = listConsecutiveOrder(1, num_points);
    quantified_t = struct();
    for i = 1:num_points
        p1 = corners(:, ordered_list(1, i));
        p2 = corners(:, ordered_list(2, i));

        [q_pixel_x, q_pixel_y] = ...
                           quantizeTwoPixels(p1, p2, quantization);
        [x, y, modelInliers, inlierPts] = ransacLineWithVerticality([q_pixel_x; q_pixel_y], 0.5, 0.8, 1.2);

        quantified_t(i).perfect_corner1 = p1;
        quantified_t(i).perfect_corner2 = p2;
        quantified_t(i).q_pixel_x = q_pixel_x;
        quantified_t(i).q_pixel_y = q_pixel_y;
        quantified_t(i).begin_point = x;
        quantified_t(i).end_point = y;
        quantified_t(i).modelInliers = modelInliers;
        quantified_t(i).inlierPts = inlierPts;
    end


    for i = 1:num_points
        cur_line1 = ordered_list(1, i);
        cur_line2 = ordered_list(2, i);

        % from l1-l2, l2-l3, l3-l4, l4-l1 
        % so the corners order is top, right, bottom, left if use i as the index
        % whereas the order should be left, top, right, bottom
        % thus, we use cur_line as index so the order of the corner is correct
        quantified_t(cur_line2).quitified_corners = [intersection(quantified_t(cur_line1).modelInliers, quantified_t(cur_line2).modelInliers); 1];
        quantified_t(cur_line2).quitification_error = norm(quantified_t(cur_line2).quitified_corners - quantified_t(cur_line2).perfect_corner1);
    end
    quitified_corners = [quantified_t(:).quitified_corners];
    RMSE = computeRMSE(quitified_corners, [quantified_t(:).perfect_corner1]);
end


% cur_axes = axes_h(1);
% scatter3(cur_axes, [ 0 0], edge_t(1).points(1, :), edge_t(1).points(2, :), 'fill', 'ro');
% viewCurrentPlot(cur_axes, "Line equation", [-90, 0]);
% % plotALine(figure_handle, direction, point, start, end_)
% dir = [0, edge_t(1).coeff(2), -edge_t(1).coeff(1)];
% dir = dir./norm(dir);
% dist = norm(edge_t(1).points(:, 1)-edge_t(1).points(:, 2));
% plotALine(cur_axes, dir, [0, edge_t(1).points(:, 1)'] , 0, dist)