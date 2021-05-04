function [sorted_vertices, sorted_indices, flag] = sortVertices(opts, vertices_mat)
    % flag = 1, volumn
    % flag = 2, area
    % flag = 3, collinear -> sorted_vertices = []
    % flag = 4, no points/oen point-> sorted_vertices = []
    
    sorted_vertices = [];
    [m, n] = size(vertices_mat);
    if ~isfield(opts, 'verbose') || isempty(opts)
        opts.verbose.output_level = 0;
    end
    if ~isfield(opts, 'assign_rank') || isempty(opts)
        opts.assign_rank = 0;
    end
    
    
    if isempty(vertices_mat) || m <= 2 || n <= 2
        flag = 4;
        return
    end
        
    vertices_mat = makeWideMatrix(vertices_mat);
    [flag, vertices_mat] = checkHomogeneousCoord(vertices_mat, 0);
    if flag
        vertices_mat = vertices_mat(1:end-1, :);
    end
    vertices_mat_transosed = vertices_mat';
    
    % check if coplanner
    tmp = bsxfun(@minus, vertices_mat_transosed, mean(vertices_mat_transosed));
    if opts.assign_rank == 0
    %     tol = 1e-3; % 1e-3 (looser), 1e-1(tight), 2 (tigter)
    %     rnk = rank(tmp, tol);
    %     max(size(vertices_mat_transosed))*eps(norm(vertices_mat_transosed));
        rnk = rank(tmp);
    else
        rnk = opts.assign_rank;
    end
    
    if rnk == size(vertices_mat_transosed, 2)
        flag = 1;
        [sorted_indices, ~] = convhull(vertices_mat_transosed);
    elseif rnk == size(vertices_mat_transosed, 2) - 1 % coplannar -> project them
        flag = 2;
        if opts.verbose.output_level == 1
            warning("Points are coplannar, projected sort operation performed")
        end
        [U, S] = svd(tmp, 0);  
        [sorted_indices, ~] = convhull(U*S(:,1:2));
    elseif rnk == 1
        flag = 3;
        if opts.verbose.output_level == 1
            warning("Points are collinear, no sort operation performed")
        end
        return
    elseif rnk == 0
        if opts.verbose.output_level == 1
            warning("Points are overlapping, no sort operation performed")
        end
        return
    end
    sorted_indices = sorted_indices(1:end-1);
    sorted_vertices = vertices_mat(:, sorted_indices);
end
