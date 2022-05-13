function RMSE = computeRMSE(points1, point2)
    [m1, n1] = size(points1);
    [m2, n2] = size(point2);
    assert(n1 == n2, ...
        "num of points mismatch: p1-%i, p2-%i", n1, n2)
    assert(m1 == 2 || m1 == 3, "dimension wrong: rows-%i", m1)
    assert(m2 == 2 || m2 == 3, "dimension wrong: rows-%i", m2)
    RMSE = sqrt(norm(points1 - point2, 'fro').^2/n1);
end