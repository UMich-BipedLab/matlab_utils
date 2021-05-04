function plotIntersectionPointsOnRingPlane(figure_handle, opts, plane_intersect, line_interval)
    if ~exist('line_interval', 'var') || isempty(line_interval)
        line_interval = [-20, 20];
    end
    [~, figure_handle] = checkFigureHandle(figure_handle, 1);
    for i = 1:length(plane_intersect)
        if ~isempty(plane_intersect(i).point)
            scatter3(figure_handle, plane_intersect(i).point(1), plane_intersect(i).point(2), plane_intersect(i).point(3), 100, 'm^', 'fill')
            plotALine(figure_handle, plane_intersect(i).intersection(1).L, plane_intersect(i).intersection(1).P, line_interval(1), line_interval(2))
            plotALine(figure_handle, plane_intersect(i).intersection(2).L, plane_intersect(i).intersection(2).P, line_interval(1), line_interval(2))
        end
    end
end