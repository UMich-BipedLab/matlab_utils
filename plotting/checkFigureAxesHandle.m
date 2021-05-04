function [fig_flag, axes_flag] = checkFigureAxesHandle(t_fig_handle)
    fig_flag = false;
    axes_flag = false;
    if isnumeric(t_fig_handle)
        if ishandle(t_fig_handle)
            fig_flag = true;
        end
    else 
        if strcmp(get(t_fig_handle, 'type'), 'axes') 
            axes_flag = true;
        elseif strcmp(get(t_fig_handle, 'type'), 'figure')
            fig_flag = true;
        end
    end
end