function plotHistogram(figure_handle, opts, target, txt)
    hold(figure_handle, 'on')
    histogram(figure_handle, target, 20); 
    title(figure_handle, txt) 
    if opts.view_plot
        set(get(figure_handle, 'parent'), 'visible','on');% show the current axes
    else
%         axis(figure_handle, 'equal')
        view(figure_handle, [0, 90])
    end
end