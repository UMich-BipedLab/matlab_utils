% assignLegend(axes_handles(cur_axes), [h2, h3, h_traj], ['$\hat{\psi}$', "goal position", legend_s(1:a)], 15, 5, 30)
function assignLegend(axes_h, handles, labels, marker_size, line_width, font_size)
    if ~exist('font_size', 'var') || isempty(font_size)
        font_size = 30;
    end
    [hleg, hobj, hout, mout] = legend(axes_h, handles, labels,'Interpreter','latex');
    set(findobj(hobj,'-property','MarkerSize'),'MarkerSize',marker_size);
    set(findobj(hobj,'-property','LineWidth'),'LineWidth',line_width);
    hleg.FontSize = font_size;
end