function changeBackgroundColor(fig_h, opts)
    if ~exist('opts', 'var') || isempty(opts)
        opts.hide_axis = 0;
        opts.hide_xaxis = 0;
        opts.hide_yaxis = 0;
        opts.hide_zaxis = 0;
        opts.background_color = 'w';
    end
    popCurrentFigure(fig_h);
    
    if opts.hide_axis
        set(gca,'visible','off')
    end
    if opts.hide_xaxis
        set(gca,'XColor', 'none')
    end
    if opts.hide_yaxis
        set(gca, 'YColor', 'none')
    end
    if opts.hide_zaxis
        set(gca, 'ZColor', 'none')
    end
    set(gcf, 'color', opts.background_color);
end
