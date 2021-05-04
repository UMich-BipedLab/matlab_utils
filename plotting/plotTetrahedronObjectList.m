function plotTetrahedronObjectList(fig_number, opts, title_txt, object_list, ring_t, plane_intersect)
    fig_handle = gca(figure(fig_number));
    hold(fig_handle, 'on')
    
    % vertices
    scatter3(fig_handle, object_list(1).vertices(1, :), object_list(1).vertices(2, :), object_list(1).vertices(3, :), 'fill', 'ro')
    scatter3(fig_handle, object_list(2).vertices(1, :), object_list(2).vertices(2, :), object_list(2).vertices(3, :), 'fill', 'ro')
    scatter3(fig_handle, object_list(3).vertices(1, :), object_list(3).vertices(2, :), object_list(3).vertices(3, :), 'fill', 'ro')
    scatter3(fig_handle, object_list(4).vertices(1, :), object_list(4).vertices(2, :), object_list(4).vertices(3, :), 'fill', 'ro')
    
    % show vertices number
    text(fig_handle, object_list(1).vertices(1, 1), object_list(1).vertices(2, 1), object_list(1).vertices(3, 1), "1", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle' );
    text(fig_handle, object_list(1).vertices(1, 2), object_list(1).vertices(2, 2), object_list(1).vertices(3, 2), "2", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle');
    text(fig_handle, object_list(1).vertices(1, 3), object_list(1).vertices(2, 3), object_list(1).vertices(3, 3), "4", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle' );
    text(fig_handle, object_list(2).vertices(1, 3), object_list(2).vertices(2, 3), object_list(2).vertices(3, 3), "3", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle');

    
    % edges
    plot3(fig_handle, object_list(1).connected_vertices(1, :), object_list(1).connected_vertices(2, :), object_list(1).connected_vertices(3, :), 'k','LineWidth', 3)
    plot3(fig_handle, object_list(2).connected_vertices(1, :), object_list(2).connected_vertices(2, :), object_list(2).connected_vertices(3, :), 'k','LineWidth', 3)
    plot3(fig_handle, object_list(3).connected_vertices(1, :), object_list(3).connected_vertices(2, :), object_list(3).connected_vertices(3, :), 'k','LineWidth', 3)
    plot3(fig_handle, object_list(4).connected_vertices(1, :), object_list(4).connected_vertices(2, :), object_list(4).connected_vertices(3, :), 'k','LineWidth', 3)
    
    
    % normal and centroid
    plotArrow(fig_number, object_list(1).centroid, object_list(1).normal, 0.5)
    plotArrow(fig_number, object_list(2).centroid, object_list(2).normal, 0.5)
    plotArrow(fig_number, object_list(3).centroid, object_list(3).normal, 0.5)
    plotArrow(fig_number, object_list(4).centroid, object_list(4).normal, 0.5)
    
    % show face(target) number
    text(fig_handle, object_list(1).centroid(1), object_list(1).centroid(2), object_list(1).centroid(3), "1", 'FontSize', 18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle', 'Color', 'r');
    text(fig_handle, object_list(2).centroid(1), object_list(2).centroid(2), object_list(2).centroid(3), "2", 'FontSize', 18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle', 'Color', 'r');
    text(fig_handle, object_list(3).centroid(1), object_list(3).centroid(2), object_list(3).centroid(3), "3", 'FontSize', 18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle', 'Color', 'r');
    text(fig_handle, object_list(4).centroid(1), object_list(4).centroid(2), object_list(4).centroid(3), "4", 'FontSize', 18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle', 'Color', 'r');

    plotOriginalAxisWithText(fig_handle, "Origin", eye(4))
    
    if ~isempty(ring_t)
        if ~isfield(opts, 'len')
            opts.len = 5;
        else
            if isempty(opts.len)
                opts.len = 5;
            end
        end
        plotRingPlane(fig_number, opts, object_list, [], ring_t, opts.len*[-2, 2])
    end
    if ~isempty(plane_intersect)
        plotIntersectionPointsOnRingPlane(fig_number, opts, plane_intersect, opts.len * [-2, 2])
    end
    checkFigureViewOptions(fig_number, opts, title_txt)
end