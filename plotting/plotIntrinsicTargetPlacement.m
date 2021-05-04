function plotIntrinsicTargetPlacement(opts, fig_handles, LiDAR_ring_points, LiDAR_opts, object_list, ring_t, plane_intersect_targets, target_intersection, plane_intersect, bases)
    %% Plotting
    disp("- Plotting...")
    
    % Full scene
    disp("-- Drawing full LiDAR environment...")
    figure_handle = fig_handles(1);
    plotFullLiDAEnvironment(figure_handle, opts, object_list, LiDAR_ring_points, LiDAR_opts)
    
    % Zoom in
    disp("-- Drawing Targets with one ring...")
    figure_handle = fig_handles(2);
    plotTargetWithLiDARRingPoints(figure_handle, opts, object_list, LiDAR_ring_points, LiDAR_opts, ring_t)
    
    % Show full results (including points on the ring plane and intersection points of targets)
    disp("-- Drawing Tags with the ring plane...")
    figure_handle = fig_handles(3);
    plotTargetWithRingPlane(figure_handle, opts, object_list, LiDAR_opts, ring_t, plane_intersect_targets, target_intersection, plane_intersect)
    
    figure_handle = fig_handles(4);
    plotHistogram(figure_handle, opts, [plane_intersect_targets(:).cond], "condition numbers of targets themselves");


    figure_handle = fig_handles(5);
    plotHistogram(figure_handle, opts, [bases(:).cond], "condition numbers of p_i_j");

    % Show only 2D results
    figure_handle = fig_handles(6);
    plotTargetWithRingPlane2D(figure_handle, opts, object_list, LiDAR_opts, ring_t, target_intersection, plane_intersect)
    
    disp("- Plotted")
end