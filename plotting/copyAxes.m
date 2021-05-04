function copy_to_ax2 = copyAxes(copy_from_ax1, copy_to_ax2)
    % axes_h2(2) = copyAxes(cur_axes, axes_h2(2));
    % Get handles for all children from ax1
    ax1Chil = copy_from_ax1.Children; 
    % Copy all ax1 objects to axis 2
    copyobj(ax1Chil, copy_to_ax2);
end