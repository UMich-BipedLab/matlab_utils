function color_map = genColorMap(color_axis, scaling, type)
    % scatter3(x, y, z, [], cm(ceil(zscaled),:), 'filled')
    % scatter3(x, y, z, [], color_map, 'filled')
    
    if ~exist('type', 'var') || isempty(type)
        type = 2;
    end

    % May Be Necessary To Scale The Colour Vector
    color_axis_min = min(color_axis);
    if color_axis_min<=0
        color_axis = color_axis + abs(color_axis_min) + 0.001;
    end
    color_axis_scaled = color_axis*scaling; 
    
    % Number Of Colors (Scale AsAppropriate)
    cn = ceil(max(color_axis_scaled));   
    
    % Define Colormap
    if type == 1
        color_map = colormap(gray(cn));
    elseif type == 2
        color_map = colormap(jet(cn));
    end
    color_map = color_map(ceil(color_axis_scaled), :);
end