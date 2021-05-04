function std_noise = estimatePlanarNoise(points_mat)
    [g_U, ~, ~] = svd(points_mat(1:3, :) - mean(points_mat(1:3, :), 2));
    std_noise = std(g_U\points_mat(1:3, :), 0, 2);
end
