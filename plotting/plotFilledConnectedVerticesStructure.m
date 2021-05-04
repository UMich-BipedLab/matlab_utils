function plotFilledConnectedVerticesStructure(t_fig_handle, vertices, filled_preperties, frame_properties)
    if ~exist('filled_preperties','var')
        filled_preperties.color = 'k';
        filled_preperties.alpha = 0.5;
    else
        if ~isfield(filled_preperties, 'color')
            filled_preperties.color = 'k';
        end
        
        if ~isfield(filled_preperties, 'coloalphar')
            filled_preperties.alpha = 0.5;
        end        
    end
    
    if ~exist('frame_properties','var')
        frame_properties = 'k';
    end
    [~, figure_handle] = checkFigureHandle(t_fig_handle, 1);
    plotConnectedVerticesStructure(figure_handle, vertices, frame_properties)
    patch(figure_handle, vertices.x, vertices.y, vertices.z, filled_preperties.color, 'FaceAlpha', filled_preperties.alpha)
end