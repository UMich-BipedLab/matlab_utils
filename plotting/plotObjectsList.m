% LiDAR_opts.pose.centriod = [0 0 0];
% figure_handle = 101;
% scene_num = 40;
% [object_list, LiDAR_opts.color_list] = CreateObstacles(scene_num);
% t_plotObjectsList(figure_handle, [], LiDAR_opts, object_list);
% 
% plotOriginalAxisWithText(figure_handle, "Origin", eye(4), 0.5)
% viewCurrentPlot(figure_handle, "Scene #" + num2str(scene_num))

% function t_plotObjectsList(figure_handle, opts, LiDAR_opts, object_list)
function h = plotObjectsList(figure_handle, opts, LiDAR_opts, object_list, obj_num)
    num_objects = length(object_list);
    hg = hggroup(figure_handle);
    if isempty(opts)
        opts.simulate_lidar = 0;
        opts.clean_fig = 0;
        opts.show_arrow = 1;
        opts.arrow_length = 0.5;
        opts.plot_object_list = 1;
        opts.show_text = 1;
    else
        if ~isfield(opts, 'simulate_lidar')
            opts.simulate_lidar = 0;
        end
    
        if ~isfield(opts, 'clean_fig')
            opts.clean_fig = 0;
        end
        
        if ~isfield(opts, 'show_arrow')
            opts.show_arrow = 1;
        end
        
        if ~isfield(opts, 'arrow_length')
            opts.arrow_length = 0.5;
        end
        if ~isfield(opts, 'plot_object_list')
            opts.plot_object_list = 1;
        end
        if ~isfield(opts, 'show_text')
            opts.show_text = 1;
        end
    end
    
    if isempty(LiDAR_opts)
        LiDAR_opts.pose.centriod = [0, 0, 0];
        LiDAR_opts.color_list = getColors(num_objects);
    end
    
    [~, figure_handle] = checkFigureHandle(figure_handle, 1, opts.clean_fig);
    for objects = 1:num_objects
        if opts.simulate_lidar
            scatter3(figure_handle, object_list(objects).points_mat(1, :), ...
                                    object_list(objects).points_mat(2, :), ...
                                    object_list(objects).points_mat(3, :), '.','Parent',hg)
        end
        if ~isfield(object_list, 'consistent_normal')
             object_list = recomputeConsistentNormals(LiDAR_opts.pose.centriod, object_list);
        end
        
        if opts.show_arrow
            arrow_len = opts.arrow_length;
            quiver3(figure_handle, ...
                    object_list(objects).centroid(1), object_list(objects).centroid(2), object_list(objects).centroid(3), ...
                    object_list(objects).consistent_normal(1)*arrow_len, object_list(objects).consistent_normal(2)*arrow_len, object_list(objects).consistent_normal(3)*arrow_len, ...
                    'fill', 'r', 'LineWidth', 3,'Parent',hg)
            scatter3(figure_handle, object_list(objects).centroid(1), object_list(objects).centroid(2), object_list(objects).centroid(3), 'fill', 'ok','Parent',hg)
        end
        if ~exist('obj_num', 'var')
            obj_num = objects;
        elseif isempty(obj_num)
            obj_num = objects;
        end
        
        if opts.show_text
            text(figure_handle, object_list(objects).centroid(1), object_list(objects).centroid(2), object_list(objects).centroid(3), num2str(obj_num),'Parent',hg)
        end
        clear obj_num
    end
    if isfield(object_list, 'object_vertices') && opts.plot_object_list
        if ~isfield(LiDAR_opts, 'color_list')
            LiDAR_opts.color_list = getColors(num_objects);
        end
        plotMultiplePolygonsVertices(figure_handle, object_list, LiDAR_opts.color_list);
    end
    if ~nargout % if nargout == 0
       clearvars % or simply clearvars y
    else
        h = hg;
    end
end