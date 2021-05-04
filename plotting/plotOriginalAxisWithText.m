function plotOriginalAxisWithText(cur_axes, txt, pose_H, length, properteis)
    if ~exist('properteis', 'var')
        properteis = '-b';
    end
    if ~exist('length', 'var') || isempty(length)
        length = 1;
    end
    if ~exist('pose_H', 'var') || isempty(pose_H)
        pose_H = eye(4);
    end
    if ~exist('cur_axes', 'var')
        cur_axes = createFigHandle(1, "");
    end
    if isnumeric(cur_axes) && ~isempty(cur_axes)
        figure(cur_axes)
        cur_axes = get(gcf,'CurrentAxes');
    end
    
    if isempty(cur_axes)
        cur_axes = createFigHandle(1, "");
    end
    
    if ~exist('txt', 'var')
        txt = "";
    end
    hold(cur_axes, "on")
    plotOriginalAxis(cur_axes, pose_H, length, properteis, txt)
end
