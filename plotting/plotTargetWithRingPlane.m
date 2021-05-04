function plotTargetWithRingPlane(figure_handle, opts, object_list, LiDAR_opts, ring_t, plane_intersect_targets, target_intersection, plane_intersect)
    [~, figure_handle] = checkFigureHandle(figure_handle, 1);    
    hold(figure_handle, 'on')
    plotObjectsList(figure_handle, opts, LiDAR_opts, object_list)
    plotArrow(figure_handle, ring_t.ring_centroid, ring_t.ring_normal, 5)
    
    disp("-- Drawing target intersection points")
    intersection_points_3D = [plane_intersect_targets(:).point];
    scatter3(figure_handle, intersection_points_3D(1,:), intersection_points_3D(2,:), intersection_points_3D(3,:), 'fill', 'r^')
    
    disp("-- Drawing intersection lines of targets with each other") 
    for i = 1:length(target_intersection)
        plotALine(figure_handle, target_intersection(i).L, target_intersection(i).P, -5, 5)
    end

    disp("-- Drawing intersection points of targets with the ring plane")
    plotIntersectionPointsOnRingPlane(figure_handle, opts, plane_intersect)

    disp("-- Drawing the ring plane")
    plotRingPlane(figure_handle, opts, object_list, plane_intersect, ring_t)
    
    title_txt = "Targets with ring plane (#"+ num2str(opts.test_ring) + ")";
    checkFigureViewOptions(figure_handle, opts, title_txt);
end