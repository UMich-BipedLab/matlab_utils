function [v0, v1, v2, v3, v4] = genRegularTetrahedron(edge_len)

    % regular, upright tetrahedron
    v0 = [0 0 0 1]'; % circumcenter
    v1 = [0 0 edge_len 1]';
    v2 = [edge_len * [-sqrt(2/9), sqrt(2/3) -1/3] 1]';
    v3 = [edge_len * [-sqrt(2/9), -sqrt(2/3) -1/3] 1]';
    v4 = [edge_len * [sqrt(8/9), 0 -1/3] 1]';
end