function plotFullLiDAEnvironment(figure_handle, opts, object_list, LiDAR_ring_points, LiDAR_opts)
    if opts.simulate_lidar
        for beam_num = 1:LiDAR_opts.properties.beam
            scatter3(figure_handle, LiDAR_ring_points(beam_num).points.x, ...
                                    LiDAR_ring_points(beam_num).points.y, ...
                                    LiDAR_ring_points(beam_num).points.z, '.')
            hold(figure_handle, 'on')
        %     text(fig_handles(3), max(LiDAR_ring_points(beam_num).points.x), ...
        %                          max(LiDAR_ring_points(beam_num).points.y), ...
        %                          max(LiDAR_ring_points(beam_num).points.z), num2str(beam_num))
        end
        plotOriginalAxisWithText(figure_handle, "LiDAR", LiDAR_opts.pose.H, 4, '-k')
    else
        plotOriginalAxisWithText(figure_handle, "LiDAR", eye(4), 4, '-k')
    end
    plotMultiplePolygonsVertices(figure_handle, object_list, LiDAR_opts.color_list)
    checkFigureViewOptions(figure_handle, opts, "Full LiDAR Environement");
end