function figure_handle = cleanCurrentPlot(fig, show)
    if ~exist('show', 'var') || isempty(show)
        show = 0;
    end
    [~, figure_handle] = checkFigureHandle(fig, 1, 1);
    if show
        viewCurrentPlot(figure_handle)
    end
end
