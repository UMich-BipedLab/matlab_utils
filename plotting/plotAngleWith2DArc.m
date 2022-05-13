% compute angle BAC
%    
%      B
%   v1/
%    /
% A / )
%   \ )
%    \ 
%  v2 \
%      C
%
function plotAngleWith2DArc(axes_h , B, A, C, radius, which_plane, opts)
    if ~exist('opts', 'var') || isempty(opts)
        opts.line_width = 5;
    end
    if ~isfield(opts, 'color')
        opts.color = 'k';
    end
    if ~isfield(opts, 'line_spec')
        opts.line_spec = ':';
    end
    angle = abs(computeAngle(B, A, C));
    v1 = B-A;
    start_from = wrapTo2Pi(atan2(v1(2), v1(1)));
    anchor_point = A;
    arc_angles = start_from : 0.05 :start_from + angle;
    num_points = length(arc_angles);
    
    % Circle Function For Angles In Radians
    circr = @(radius,rad_ang)  [radius*cos(rad_ang);  radius*sin(rad_ang)];
    xy_r = circr(radius, arc_angles);
    
    if which_plane == "XY"
        plot3(axes_h, anchor_point(1) + xy_r(1,:), ...
            anchor_point(2) + xy_r(2,:), zeros(1, num_points), ...
            opts.line_spec, ...
            'LineWidth', opts.line_width, 'Color', opts.color);
    elseif which_plane == "YZ"
        plot3(axes_h, zeros(1, num_points), ...
            anchor_point(1) + xy_r(1,:), anchor_point(2) + xy_r(2,:), ...
            opts.line_spec, ...
            'LineWidth', opts.line_width, 'Color', opts.color);
    elseif which_plane == "XZ"
        plot3(axes_h, anchor_point(1) + xy_r(1,:), ...
            zeros(1, num_points), anchor_point(2) + xy_r(2,:), ...
            opts.line_spec, ...
            'LineWidth', opts.line_width, 'Color', opts.color);
    end
end
