function plotTargetWithRingPlane2D(figure_handle, opts, object_list, LiDAR_opts, ring_t, target_intersection, plane_intersect)
    hold(figure_handle, 'on')
    num_objects = length(object_list);
    for objects = 1:num_objects
        if opts.simulate_lidar
            scatter3(figure_handle, object_list(objects).points_mat(1, :), ...
                                    object_list(objects).points_mat(2, :), ...
                                    object_list(objects).points_mat(3, :), '.')
        end
        hold(figure_handle, 'on')
        quiver3(figure_handle, object_list(objects).centroid(1), object_list(objects).centroid(2), object_list(objects).centroid(3), object_list(objects).consistent_normal(1),  object_list(objects).consistent_normal(2), object_list(objects).consistent_normal(3), 'fill', 'LineWidth', 3)
        text(figure_handle, object_list(objects).centroid(1), object_list(objects).centroid(2), object_list(objects).centroid(3), num2str(objects))
    end
    if opts.simulate_lidar
        plotOriginalAxisWithText(figure_handle, "LiDAR", LiDAR_opts.pose.H, 4, '-k')
    else
         plotOriginalAxisWithText(figure_handle, "LiDAR", eye(4), 4, '-k')
    end
    plotMultiplePolygonsVertices(figure_handle, object_list, LiDAR_opts.color_list)
    plotArrow(figure_handle, ring_t.ring_centroid, ring_t.ring_normal, 5)

    disp("-- Drawing intersection points of targets with the ring plane")
    for i = 1:length(plane_intersect)
        scatter3(figure_handle, plane_intersect(i).point(1), plane_intersect(i).point(2), plane_intersect(i).point(3), 'ko', 'fill')
    end


    disp("-- Drawing the ring plane")
    plotRingPlane(figure_handle, opts, object_list, plane_intersect, ring_t)
    
    title_txt = "Targets with ring plane (#"+ num2str(opts.test_ring) + ") in 2D";
    opts.view_angle = [0,90];
    checkFigureViewOptions(figure_handle, opts, title_txt);
end