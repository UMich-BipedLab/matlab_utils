function connected_points = connectPoints(points_mat)
    % m x n, n is number of points
    points_mat = makeWideMatrix(points_mat);
    [dim, num_points] = size(points_mat);
    num_output_points = nchoosek(num_points, 2);
    K = nchoosek(linspace(1, num_points, num_points), 2);
    connected_points = [];
    for i = 1:num_output_points
        connected_points = [connected_points, points_mat(:, K(i, 1)), points_mat(:, K(i, 2))];
    end
end