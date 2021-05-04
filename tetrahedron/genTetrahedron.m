% clc, clear
% clf(20)
% intrinsic_lib = '/home/brucebot/workspace/griztag/src/matlab/matlab/slider/3D_lidar_intrinsic_calibration';
% extrinsic_lib = '/home/brucebot/workspace/griztag/src/matlab/matlab/slider/repo/extrinsic_utils';
% utils = '/home/brucebot/workspace/matlab_utils';
% noise_lib = "./noise";
% scenes_dir = "./scenes";
% 
% addpath(genpath(intrinsic_lib))
% addpath(genpath(extrinsic_lib))
% addpath(genpath(utils))
% addpath(scenes_dir)
% addpath(noise_lib)
% 
% 
% opts.test_ring = 15;
% opts.simulate_lidar = 0;
% opts.process_output = 0;
% opts.numerical_analysis = 1;
% opts.draw_results = 1;
% opts.view_plot = 1;
% 
% opts.tetrahedron.draw = 1;
% opts.tetrahedron.fig_num = 20;
% len = 1;
% rpy = [20, 0, 0];
% xyz = [0 0 0];
% tetrahedron = t_genTetrahedron(opts, len, rpy, xyz);
% 
% 
% 
% 
% 
% % convert to objects
% object_list(1).vertices = [tetrahedron.vertices.v1(1:3), tetrahedron.vertices.v2(1:3), tetrahedron.vertices.v4(1:3)];
% object_list(2).vertices = [tetrahedron.vertices.v1(1:3), tetrahedron.vertices.v2(1:3), tetrahedron.vertices.v3(1:3)];
% object_list(3).vertices = [tetrahedron.vertices.v1(1:3), tetrahedron.vertices.v3(1:3), tetrahedron.vertices.v4(1:3)];
% object_list(4).vertices = [tetrahedron.vertices.v2(1:3), tetrahedron.vertices.v3(1:3), tetrahedron.vertices.v4(1:3)];
% [object_list(1).normal, object_list(1).centroid] = computePlaneWithDirection(object_list(1).vertices, tetrahedron.vertices.v0(1:3));
% [object_list(2).normal, object_list(2).centroid] = computePlaneWithDirection(object_list(2).vertices, tetrahedron.vertices.v0(1:3));
% [object_list(3).normal, object_list(3).centroid] = computePlaneWithDirection(object_list(3).vertices, tetrahedron.vertices.v0(1:3));
% [object_list(4).normal, object_list(4).centroid] = computePlaneWithDirection(object_list(4).vertices, tetrahedron.vertices.v0(1:3));
% 
% 
% % Assume the ground plane as the ring plane
% LiDAR_opts.color_list = getColors(4);
% LiDAR_opts.pose.centriod = [0 0 0];
% LiDAR_opts.properties.beam = 32;
% LiDAR_ring_points(opts.test_ring).points = rand(2, 10);
% LiDAR_ring_points(opts.test_ring).points = [LiDAR_ring_points(opts.test_ring).points; zeros(1, size(LiDAR_ring_points(opts.test_ring).points, 2))];
% [object_list, ring_t, plane_intersect_targets, target_intersection, plane_intersect, bases, suitable_targets, results] = validateIntrinsicTargetPlacement(opts, object_list, LiDAR_ring_points, LiDAR_opts);
% 
% 
% % normal and centroid
% plotArrow(opts.tetrahedron.fig_num, object_list(1).centroid, object_list(1).normal, 0.5)
% plotArrow(opts.tetrahedron.fig_num, object_list(2).centroid, object_list(2).normal, 0.5)
% plotArrow(opts.tetrahedron.fig_num, object_list(3).centroid, object_list(3).normal, 0.5)
% plotArrow(opts.tetrahedron.fig_num, object_list(4).centroid, object_list(4).normal, 0.5)
% 
% 
% % plot origin and ring plane
% % plotOriginalAxisWithText(20, "Origin", eye(4))
% plotRingPlane(opts.tetrahedron.fig_num, opts, object_list, [], ring_t, len*[-2, 2])
% plotIntersectionPointsOnRingPlane(opts.tetrahedron.fig_num, opts, plane_intersect, [-1, 1])

function tetrahedron = genTetrahedron(opts, len, rpy, xyz)

    if ~isfield(opts, 'tetrahedron')
        opts.tetrahedron.analysis = 0;
        opts.tetrahedron.draw = 0;
        opts.tetrahedron.fig_num = 20;
    else
        if ~isfield(opts.tetrahedron, 'analysis')
            opts.tetrahedron.analysis = 0;
        end
        if ~isfield(opts.tetrahedron, 'draw')
            opts.tetrahedron.draw = 0;
        end
        if ~isfield(opts.tetrahedron, 'fig_num')
             opts.tetrahedron.fig_num = 20;
        end
    end
    

    % regular, upright tetrahedron
    [v0, v1, v2, v3, v4] = genRegularTetrahedron(len);

    % pose
    [v0, v1, v2, v3, v4] = moveTetrahedron(v0, v1, v2, v3, v4, rpy, xyz);

    vertices = [v1, v2, v3, v4];
    all_points=  [v0, vertices];

    % radious
    num_vertices = size(vertices, 2);
    connected_vertices_circumcenter = [];
    circumradius(num_vertices) = struct();
    for i = 1:num_vertices
        circumradius(i).origin_vertex_num = [0, i];
        circumradius(i).origin_vertex = [vertices(1:3, i), v0(1:3)];
        circumradius(i).vector = [vertices(1:3, i)- v0(1:3)];
        circumradius(i).vector_len = norm(vertices(1:3, i) - v0(1:3));
        connected_vertices_circumcenter = [connected_vertices_circumcenter, vertices(1:3, i), v0(1:3)];
    end

    % Sphere
    [X,Y,Z] = sphere(50);
    radious = circumradius(1).vector_len;
    origin = v0(1:3);
    X2 = X * radious + origin(1);
    Y2 = Y * radious + origin(2);
    Z2 = Z * radious + origin(3);

    if opts.tetrahedron.analysis

        % edges length

        num_edge = nchoosek(num_vertices, 2);
        A = nchoosek(linspace(1, num_vertices, num_vertices), 2);
        tetrahedron_edge(num_edge) = struct();
        connected_edge = [];
        for i = 1:num_edge
            point1 = vertices(1:3, A(i, 1));
            point2 = vertices(1:3, A(i, 2));
            tetrahedron_edge(i).edge_length = norm(point1 - point2);
            tetrahedron_edge(i).vertices_num = [A(i, 1), A(i, 2)];
            tetrahedron_edge(i).vertices= [point1, point2];
            connected_edge = [connected_edge, point1, point2];
        end
        volumn_from_edge = sqrt(2)/12 * (tetrahedron_edge(i).edge_length)^3;
        fprintf("Volumn computed from edge length: %f\n", volumn_from_edge)


        % tetrahedron volumn
        num_vector = length(circumradius);
        num_volumn_pieces = nchoosek(num_vertices, 3);
        B = nchoosek(linspace(1, num_vector, num_vector), 3);
        tetrahedron_volumn = zeros(1, num_volumn_pieces);
        for i = 1:num_volumn_pieces
            vec1 = circumradius(B(i, 1)).vector;
            vec2 = circumradius(B(i, 2)).vector;
            vec3 = circumradius(B(i, 3)).vector;
            tetrahedron_volumn(i) = 1/6 * abs(dot(cross(vec1, vec2), vec3));
        end
        volumn_from_vectors = sum(tetrahedron_volumn);
        fprintf("Volumn computed from vectors: %f\n", volumn_from_vectors)
    end

    % [ring_t.ring_normal, ring_t.ring_centroid] = computePlaneWithDirection(LiDAR_ring_points(opts.test_ring).points, v0(1:3));


    % tetrahedron properties
    tetrahedron.vertices.v0 = v0(1:3);
    tetrahedron.vertices.v1 = v1(1:3);
    tetrahedron.vertices.v2 = v2(1:3);
    tetrahedron.vertices.v3 = v3(1:3);
    tetrahedron.vertices.v4 = v4(1:3);
    tetrahedron.vertices_mat = vertices((1:3), :);
    tetrahedron.connected_vertices = connectPoints([tetrahedron.vertices_mat]);
    tetrahedron.circumcenter = v0(1:3);
    tetrahedron.connected_vertices_circumcenter = connected_vertices_circumcenter;
    tetrahedron.vectors = [circumradius(:).vector];
    tetrahedron.sphere.X = X2;
    tetrahedron.sphere.Y = Y2;
    tetrahedron.sphere.Z = Z2;


    %% Numerical results
    if opts.tetrahedron.analysis
        struct2table(tetrahedron_edge)
        struct2table(circumradius)
        
    end

    %% Drawing
    if opts.tetrahedron.draw
        [~, figure_handle] = checkFigureHandle(opts.tetrahedron.fig_num, 1);
        hold(figure_handle, 'on')
        axis(figure_handle, 'equal')

        % Origin
        scatter3(figure_handle, tetrahedron.circumcenter(1, :), tetrahedron.circumcenter(2,:), tetrahedron.circumcenter(3,:), 100, "fill", '^k')

        % Vertices
        scatter3(figure_handle, tetrahedron.vertices_mat(1, :), tetrahedron.vertices_mat(2,:), tetrahedron.vertices_mat(3,:), "fill", 'or')

        % Edges
        plot3(figure_handle, tetrahedron.connected_vertices(1, :), tetrahedron.connected_vertices(2,:), tetrahedron.connected_vertices(3,:), 'm', 'LineWidth', 5)

        % Vectors
        plot3(figure_handle, tetrahedron.connected_vertices_circumcenter(1, :), tetrahedron.connected_vertices_circumcenter(2,:), tetrahedron.connected_vertices_circumcenter(3,:), 'g', 'LineWidth', 5)

        % Sphere
        surf(figure_handle, tetrahedron.sphere.X , tetrahedron.sphere.Y , tetrahedron.sphere.Z , 'FaceAlpha', 0.5)


        % show vertices number
        text(figure_handle, tetrahedron.circumcenter(1), tetrahedron.circumcenter(2), tetrahedron.circumcenter(3), "O", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle');
        text(figure_handle, tetrahedron.vertices_mat(1, 1), tetrahedron.vertices_mat(2, 1), tetrahedron.vertices_mat(3, 1), "1", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle' );
        text(figure_handle, tetrahedron.vertices_mat(1, 2), tetrahedron.vertices_mat(2, 2), tetrahedron.vertices_mat(3, 2), "2", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle');
        text(figure_handle, tetrahedron.vertices_mat(1, 3), tetrahedron.vertices_mat(2, 3), tetrahedron.vertices_mat(3, 3), "3", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle' );
        text(figure_handle, tetrahedron.vertices_mat(1, 4), tetrahedron.vertices_mat(2, 4), tetrahedron.vertices_mat(3, 4), "4", 'FontSize',18, 'FontWeight','bold', 'HorizontalAlignment','left', 'VerticalAlignment','middle');


        view(figure_handle, 0, 20)
%         current_axis = gca(figure(opts.tetrahedron.fig_num));
        set(figure_handle,'visible','off','XColor', 'none','YColor','none','xtick',[], 'Color', 'None')
    end
end