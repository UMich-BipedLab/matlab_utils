scenes = [50 51];
plotScenes_t(scenes)


function plotScenes_t(scenes, opts)
    if ~exist('opts', 'var')
        opts.start_number = 500;
        opts.num_plot = length(scenes);
    end
    
    num_handles = opts.num_plot;
    figure_name = "scene";
    figure_start_number = opts.start_number;
    fig_handles = createFigHandleWithNumber(num_handles, figure_start_number, figure_name);
    for i = 1: length(scenes)
        scene = scenes(i);
        [object_list, color_list] = CreateObstacles(scene);
        plotMultiplePolygonsVertices(fig_handles(i), object_list, color_list)
        plotOriginalAxis(fig_handles(i), eye(4), 1)
        viewCurrentPlot(fig_handles(i), "Scene #" + num2str(scene))
    end
end