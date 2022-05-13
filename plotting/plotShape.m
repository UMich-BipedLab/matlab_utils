% plotShape(axes_h, [objest_list.vertices], 'k', 'k');
function hg = plotShape(axes_h, points, marker_color, line_color, plot_opts, sort_vertices)
    if ~exist('plot_opts', 'var') || isempty(plot_opts)
        plot_opts.line_width = 3;
        plot_opts.marker_size = 50; 
    end
    
    if ~exist('sort_vertices', 'var') || isempty(sort_vertices)
        sort_vertices = 0;
    end
    if sort_vertices
        opts.verbose.output_level = 1;
        [points, ~, ~] = ...
            sortVertices(opts, points);
    end
    
%     if ~isfield(opts, 'line_color')
%         opts.line_color = 'r';
%     end
%     if ~isfield(opts, 'vertex_color')
%         opts.vertex_color = 'k';
%     end
        
    hg = hggroup(axes_h);
    scatter3(axes_h, ...
        points(1, :), ...
        points(2, :), ...
        points(3, :), plot_opts.marker_size, ...
        'fill', 'o', 'MarkerFaceColor', marker_color, ...
        'Parent', hg);


    plot3(axes_h, ...
        [points(1, :), points(1, 1)], ...
        [points(2, :), points(2, 1)], ...
        [points(3, :), points(3, 1)], ...
        'Color', line_color, 'LineWidth', plot_opts.line_width, ...
        'Parent', hg);
end