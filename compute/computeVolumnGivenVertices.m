% clc
% C =[
%   -11.6944   91.5437         0
%    -8.7534   -6.7399         0
%    -7.8894   74.8960         0
%    -6.0163   12.2963         0.1
%    -1.2145   45.6912         0
%          0         0         0]';
% C([2 3], :) = C([3 2], :);   
% [area_volumn, flag] = t_computeVolumnGivenVertices([], C)    

function [area_volumn, flag, sorted_vertices, sorted_indices] = computeVolumnGivenVertices(opts, vertices_mat)
    % flag = 1, volumn
    % flag = 2, area
    % flag = 3, collinear -> area is zero
    % flag = 4, no points, area is zero
    [m, n] = size(vertices_mat);
    if ~isfield(opts, 'debug') || isempty(opts)
        opts.debug = 0;
    end
    if isempty(vertices_mat) || m <= 2 || n <= 2
        flag = 4;
        area_volumn = 0;
        return
    end
    
    sorted_vertices = [];
    sorted_indices = [];
    vertices_mat = makeWideMatrix(vertices_mat);
    [flag, vertices_mat] = checkHomogeneousCoord(vertices_mat, 0);
    if flag
        vertices_mat = vertices_mat(1:end-1, :);
    end
    vertices_mat = vertices_mat';
    
    % check if coplanner
    tmp = bsxfun(@minus, vertices_mat, mean(vertices_mat));
    tol = 2; % 1e-3 (looser), 1e-1(tight), 2 (tigter)
    max(size(vertices_mat))*eps(norm(vertices_mat));
    rnk = rank(tmp);
    
    if rnk == size(vertices_mat, 2)
        flag = 1;
        [sorted_indices, area_volumn] = convhull(vertices_mat);
        
    elseif rnk == size(vertices_mat, 2) - 1 % coplannar -> project them
        flag = 2;
        if opts.debug
            warning("Points are coplannar, output as area of convhull")
        end
        [U, S] = svd(tmp, 0);  
        [sorted_indices, area_volumn] = convhull(U*S(:,1:2));
    elseif rnk == 1
        flag = 3;
        if opts.debug
            warning("Points are collinear, area is zeros")
        end
        area_volumn = 0;
    elseif rnk == 0
        if opts.debug
            warning("Points are overlapping, area is zeros")
        end
        area_volumn = 0;
    end

    sorted_indices = sorted_indices(1:end-1);
    sorted_vertices = vertices_mat(sorted_indices, :)';
end