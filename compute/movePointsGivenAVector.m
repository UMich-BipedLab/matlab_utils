function moved_points = movePointsGivenAVector(points, N, d)
    % points should be 3xm
    unit_N = N/norm(N);
    moved_points = [unit_N(1) 0 0; 0 unit_N(2) 0; 0 0 unit_N(3)] * d*ones(3,1) + points;
end