% putText(axes_h, 2, -0.4, 0.1, "$\mathcal{TP}$", 'm', 30)
% putText(axes_h, 2, -0.4, 0.1, "$\mathcal{TP}$", 'm')
function putText(axes_h, x, y, z, txt, color, alignment, font_size)
    if ~exist('font_size', 'var') || isempty(font_size)
        font_size = axes_h.FontSize;
    end
    if ~exist('alignment', 'var') || isempty(alignment)
        alignment = 'left'; % 'left', 'right', 'center'
    end
    text(axes_h, x, y, z, ...
        txt, ...
        'Interpreter', 'latex', ...
        'FontSize', font_size, 'Color', color, ...
        'HorizontalAlignment', alignment)
end