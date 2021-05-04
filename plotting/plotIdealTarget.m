function plotIdealTarget(opts, axes_fig, target_size, type)
    if type == "square"
        % [x; y; z; 1]
        vertices = [0 -target_size/2 -target_size/2 1;
                    0 -target_size/2  target_size/2 1;
                    0  target_size/2  target_size/2 1;
                    0  target_size/2 -target_size/2 1]';
    else
        % [x; y; z; 1]
        vertices = target_size;
    end
    plotConnectedVerticesStructure(axes_fig, convertXYZmatrixToXYZstruct(vertices));
    scatter3(axes_fig, vertices(1, :), vertices(2, :), vertices(3, :), 'fill', 'ro')
end