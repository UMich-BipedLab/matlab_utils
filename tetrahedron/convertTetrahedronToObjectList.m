function object_list = convertTetrahedronToObjectList(tetrahedron_vertices)
    object_list(1).vertices = [tetrahedron_vertices.v1(1:3), tetrahedron_vertices.v2(1:3), tetrahedron_vertices.v4(1:3)]; % 124
    object_list(2).vertices = [tetrahedron_vertices.v1(1:3), tetrahedron_vertices.v2(1:3), tetrahedron_vertices.v3(1:3)]; % 123
    object_list(3).vertices = [tetrahedron_vertices.v1(1:3), tetrahedron_vertices.v3(1:3), tetrahedron_vertices.v4(1:3)]; % 134 
    object_list(4).vertices = [tetrahedron_vertices.v2(1:3), tetrahedron_vertices.v3(1:3), tetrahedron_vertices.v4(1:3)]; % 234
    [object_list(1).normal, object_list(1).centroid] = computePlaneWithDirection(object_list(1).vertices, tetrahedron_vertices.v0(1:3));
    [object_list(2).normal, object_list(2).centroid] = computePlaneWithDirection(object_list(2).vertices, tetrahedron_vertices.v0(1:3));
    [object_list(3).normal, object_list(3).centroid] = computePlaneWithDirection(object_list(3).vertices, tetrahedron_vertices.v0(1:3));
    [object_list(4).normal, object_list(4).centroid] = computePlaneWithDirection(object_list(4).vertices, tetrahedron_vertices.v0(1:3));

    object_list(1).vertices_t = convertXYZmatrixToXYZstruct(object_list(1).vertices);
    object_list(2).vertices_t = convertXYZmatrixToXYZstruct(object_list(2).vertices);
    object_list(3).vertices_t = convertXYZmatrixToXYZstruct(object_list(3).vertices);
    object_list(4).vertices_t = convertXYZmatrixToXYZstruct(object_list(4).vertices);

    % Connected points (for drawing only)
    object_list(1).connected_vertices = connectPoints(object_list(1).vertices);
    object_list(2).connected_vertices = connectPoints(object_list(2).vertices);
    object_list(3).connected_vertices = connectPoints(object_list(3).vertices);
    object_list(4).connected_vertices = connectPoints(object_list(4).vertices);
end