function opts = loadLibraries(computer, opts)
    if ~exist('path', 'var') || isempty(computer)
        computer = 2;
    end
    
    if ~exist('opts', 'var') || isempty(opts)
        opts.calibration_lib = 1;
        opts.tag_placement_lib = 1;
        opts.simulator_lib = 1;
    else
        if ~isfield(opts, 'calibration_lib')
            opts.calibration_lib = 1;
        end
        if ~isfield(opts, 'tag_placement_lib')
            opts.tag_placement_lib = 1;
        end
        if ~isfield(opts, 'simulator_lib')
            opts.simulator_lib = 1;
        end
    end

    switch computer
        case 1
            % Razer 
            opts.path.intrinsic_lib = '/home/brucebot/workspace/griztag/src/matlab/matlab/slider/3D_lidar_intrinsic_calibration';
            opts.path.extrinsic_lib = '/home/brucebot/workspace/griztag/src/matlab/matlab/slider/repo/extrinsic_utils';
            opts.path.utils = '/home/brucebot/workspace/matlab_utils';
            opts.path.tag_placement_lib = './tag_placement';
            opts.path.noise_lib = "./noise";
            opts.path.scenes_dir = "./scenes";
        case 2
            % Razer Studio
            opts.path.root_path = "/home/brucebot/workspace/";
            opts.path.intrinsic_lib = opts.path.root_path + "lc-calibration/LiDAR_intrinsic_calibration";
            opts.path.extrinsic_lib = opts.path.root_path + "lc-calibration/extrinsic_lidar_camera_calibration/extrinsic_utils";
            opts.path.simulator_lib = opts.path.root_path + "lc-calibration/lidar_simulator";
            opts.path.utils = opts.path.root_path + "matlab_utils";
            opts.path.tag_placement_lib = opts.path.simulator_lib + "/tag_placement";
            opts.path.noise_lib = opts.path.simulator_lib + "/noise";
            opts.path.scenes_dir = opts.path.simulator_lib + "/scenes";
        otherwise
            error("unknow path option")
    end
    
    addpath(genpath(opts.path.utils))
    if opts.calibration_lib
        addpath(genpath(opts.path.intrinsic_lib))
        addpath(genpath(opts.path.extrinsic_lib))
    end
    if opts.tag_placement_lib
        addpath(opts.path.tag_placement_lib)
        addpath(opts.path.scenes_dir)
        addpath(opts.path.noise_lib)
    end
    if opts.simulator_lib
        addpath(opts.path.simulator_lib)
    end
    opts.path.current_path = convertCharsToStrings(pwd);
end