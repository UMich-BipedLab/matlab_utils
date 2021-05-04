function [axes_h, fig_h] = ...
    getCurrentFigure(cur_num, axes_handles, fig_handles)
    axes_h = axes_handles(cur_num);
    fig_h = fig_handles(cur_num);
end