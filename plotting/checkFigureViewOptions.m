function checkFigureViewOptions(figure_handle, opts, txt)
    [~, figure_handle] = checkFigureHandle(figure_handle, 1);
    if ~isfield(opts, 'view_plot')
        opts.view_plot = 1;
    end
    if isfield(opts, 'view_angle')
        view_angle = opts.view_angle;
    else
         view_angle = [60, -10];
    end
    
    if opts.view_plot
        viewCurrentPlot(figure_handle, txt, view_angle)
    else
        % APP Designer can't work with viewCurrentPlot due to visibility
        view(figure_handle, view_angle)
        axis(figure_handle, 'equal')
        title(figure_handle, txt)
    end
end