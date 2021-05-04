% clc
% opts.opt.rotate_projected = 1;
% opts.opt.param_circle = 3;
% t_genAngleList(opts)

function angle_list = genAngleList(opts, start_ang, end_ang)
    if ~exist('start_ang', 'var')
        start_ang = 0;
    end
    if ~exist('end_ang', 'var')
        end_ang = 360;
    end
    if isstruct(opts)
        if ~opts.opt.rotate_projected
            param_circle = 2;
        else
            param_circle = opts.opt.param_circle + 1;
        end
    elseif isnumeric(opts)
        param_circle = opts + 1;
    end
    angle_list = linspace(start_ang, end_ang, param_circle);
    angle_list = angle_list(1:end-1);
end