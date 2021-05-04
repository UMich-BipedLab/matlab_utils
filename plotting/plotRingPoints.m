function plotRingPoints(figure_handle, opts, test_ring, LiDAR_ring_points, LiDAR_opts)
    [~, figure_handle] = checkFigureHandle(figure_handle, 1);
    
    if opts.simulate_lidar
        scatter3(figure_handle, LiDAR_ring_points(test_ring).points.x, ...
                                LiDAR_ring_points(test_ring).points.y, ...
                                LiDAR_ring_points(test_ring).points.z, '.')
%         plotOriginalAxisWithText(figure_handle, "LiDAR", LiDAR_opts.pose.H, 4, '-k')
    else
%         plotOriginalAxisWithText(figure_handle, "LiDAR", eye(4), 4, '-k')
    end
end