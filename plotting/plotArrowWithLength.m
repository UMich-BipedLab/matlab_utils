function plotArrowWithLength(t_fig_handle, start_point, end_point, arrow_length)
    [~, figure_handle] = checkFigureHandle(t_fig_handle, 1);
    if ~exist('arrow_length', 'var')
        arrow_length = 1;
    end
    end_point = arrow_length * end_point/norm(end_point);
    arrow = [start_point (start_point - end_point)]; % draw arrow
 
    diff = end_point - start_point;
    if length(start_point) == 3
        scatter3(figure_handle, ...
            start_point(1), start_point(2), start_point(3), 'fill')
        quiver3(figure_handle, ...
            start_point(1), start_point(2), start_point(3), ...
            diff(1),  diff(2), diff(3), 'fill', 'LineWidth', 3)
    elseif length(start_point) == 2
        scatter(figure_handle, start_point(1), start_point(2), 'fill')
        quiver(figure_handle, start_point(1), start_point(2), ...
            diff(1),  diff(2), 'fill', 'LineWidth', 3)
    end
%     plot3(figure_handle, arrow(1,:), arrow(2,:), arrow(3,:))
end
