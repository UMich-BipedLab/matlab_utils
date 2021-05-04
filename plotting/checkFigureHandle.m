function [flag_handle, figure_axes] = checkFigureHandle(t_fig_handle, create_fig, clear_fig)
    flag_handle = false;
    figure_axes = [];
    
    if ~exist('clear_fig', 'var')
        clear_fig = 0;
    end

    if ~isempty(t_fig_handle) 
        if isnumeric(t_fig_handle)
            if ishandle(t_fig_handle)
                flag_handle = true;
                figure_axes = gca(figure(t_fig_handle));
            end
        else 
            if strcmp(get(t_fig_handle, 'type'), 'axes') 
                flag_handle = true;
                figure_axes = t_fig_handle;
            elseif strcmp(get(t_fig_handle, 'type'), 'figure')
                flag_handle = true;
                figure_axes = gca(t_fig_handle);
            end
        end
    end


    if ~flag_handle && create_fig
        flag_handle = true;
        figure_axes = createFigHandleWithNumber(1, t_fig_handle, "NEW-Test", 0, 0);
%         figure_handle = createFigHandle(1, "Test");
    end
        
    if clear_fig
        cla(figure_axes)
    end
    hold(figure_axes, 'on')
    axis(figure_axes, 'equal')
end
