function figure_handle = cleanCurrentPlot(fig, show)
    [~, figure_handle] = checkFigureHandle(fig, 1, 1);
    if show
        viewCurrentPlot(figure_handle)
    end
end