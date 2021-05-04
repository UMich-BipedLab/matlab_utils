function reloadCurrentPlot(axes_h, equal, fontsize, line_width)
% reloadCurrentPlot();
% axes_h = gca; axes_h.FontSize = 30; reloadCurrentPlot(axes_h);
    if ~exist('axes_h', 'var') || isempty(axes_h)
        axes_h = gca; 
        axes_h.FontSize = 30;
    end
    
    [~, axes_h] = checkFigureHandle(axes_h, 1);
    if  ~exist('fontsize', 'var') || isempty(fontsize)
        axes_h.FontSize = 30;
    else
        axes_h.FontSize = fontsize;
    end

    if  ~exist('line_width', 'var') || isempty(line_width)
        set(axes_h, 'LineWidth', 2)
    else
        set(axes_h, 'LineWidth',line_width)
    end
    
    
        
    xlabel(axes_h, get(get(axes_h,'xlabel'),'string'), 'interpreter','latex', 'FontSize', axes_h.FontSize)
    ylabel(axes_h, get(get(axes_h,'ylabel'),'string'), 'interpreter','latex', 'FontSize', axes_h.FontSize)
    zlabel(axes_h, get(get(axes_h,'zlabel'),'string'), 'interpreter','latex', 'FontSize', axes_h.FontSize)
    
    if ~exist('equal', 'var')
        axis(axes_h, 'equal')
    else
        if equal
            axis(axes_h, 'equal')
        else
            axis(axes_h, 'normal')
        end
    end
    grid(axes_h, 'on')
    set(get(axes_h, 'parent'), 'visible','on');% show the current axes
    drawnow
end