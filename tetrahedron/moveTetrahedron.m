function [v0, v1, v2, v3, v4] = moveTetrahedron(v0, v1, v2, v3, v4, rpy, xyz)
    v0 = moveByRPYXYZ(v0, rpy, xyz);
    v1 = moveByRPYXYZ(v1, rpy, xyz);
    v2 = moveByRPYXYZ(v2, rpy, xyz);
    v3 = moveByRPYXYZ(v3, rpy, xyz);
    v4 = moveByRPYXYZ(v4, rpy, xyz);
end