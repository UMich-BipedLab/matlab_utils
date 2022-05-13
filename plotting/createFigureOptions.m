function fig = createFigureOptions(...
    num_handles, start_number, name, clear_fig, show_fig, font_size, ...
    save_fig, dock_fig)
    if ~exist('clear_fig', 'var') || isempty(clear_fig)
        clear_fig = 1;
    end
    if ~exist('show_fig', 'var') || isempty(show_fig)
        show_fig = 0;
    end
    if ~exist('font_size', 'var') || isempty(font_size)
        font_size = 30;
    end

    if ~exist('dock_fig', 'var') || isempty(dock_fig)
        dock_fig = 1;
    end
    
    if ~exist('save_fig', 'var') || isempty(save_fig)
        save_fig = 0;
    end

    fig.num = num_handles;
    fig.start_num = start_number;
    fig.window_name = name;
    fig.clear_fig = clear_fig;
    fig.show_fig = show_fig;
    fig.font_size = font_size;
    fig.dock_fig = dock_fig;
    fig.save_fig = save_fig;

end