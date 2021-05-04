% t_computeFartestDistance(X_train_proj)
function [fartest_distance, distance_t] = computeFartestDistance(points)
    num_pionts = size(points, 2);
    N = nchoosek(num_pionts, 2);
    list = nchoosek(linspace(1, num_pionts, num_pionts), 2);
    distance_t(N) = struct();
    for i = 1:N
        distance_t(i).points = [points(:, list(i, 1)), points(:, list(i, 2))];
        distance_t(i).distance = norm(points(:, list(i, 1))-points(:, list(i, 2)));
    end
    fartest_distance = max(distance_t(i).distance);
end