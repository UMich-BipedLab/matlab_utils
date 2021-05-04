function plotTargetWithLiDARRingPoints(figure_handle, opts, object_list, LiDAR_ring_points, LiDAR_opts, ring_t)
    [~, figure_handle] = checkFigureHandle(figure_handle, 1);
    hold(figure_handle, 'on')
    plotObjectsList(figure_handle, opts, LiDAR_opts, object_list)   
    
    % Draw ring points
    plotRingPoints(figure_handle, opts, LiDAR_ring_points, LiDAR_opts)
    
    if exist('ring_t', 'var') || ~isempty(ring_t)
        plotArrow(figure_handle, ring_t.ring_centroid, ring_t.ring_normal, 5)
    end
    
    title_txt = "Targets with one ring (#"+ num2str(opts.test_ring) + ")";
    checkFigureViewOptions(figure_handle, opts, title_txt);
end