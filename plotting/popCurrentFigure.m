function popCurrentFigure(fig_h)
    if isnumeric(fig_h)
        figure(fig_h)
    else
        figure(fig_h.Number)
    end
end