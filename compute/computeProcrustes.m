function [fitting_error, points_from_A_to_B, H_from_A_to_B] = computeProcrustes(from_A, to_B, opts)
    % compute H from A to B and then use H to transform A to B
    % from: 3 x n
    % to: 3 x n
    rows_a = size(from_A, 1);
    rows_b = size(to_B, 1);
    assert(rows_a == 3 || rows_a == 2, "Wrong input size of from_A: %i", rows_a);
    assert(rows_b == 3 || rows_b == 2, "Wrong input size of to_B: %i", rows_b);
    
    if ~exist('opts', 'var') || isempty(opts)
        opts.scaling = false;
        opts.reflection = false;
    end
    
    [fitting_error, points_from_A_to_B, H_from_A_to_B] = ...
        procrustes(to_B', from_A', ...
        'scaling', opts.scaling, 'reflection', opts.reflection);
    
    
    H_from_A_to_B = constructHByRotationTranslation(...
        H_from_A_to_B.T', H_from_A_to_B.c(1, :)');
    points_from_A_to_B = points_from_A_to_B';
end