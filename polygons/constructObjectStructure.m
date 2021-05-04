function object_t = constructObjectStructure(target_size, object_mat_h, rpy, xyz)
    moved_obj_mat_h = moveByRPYXYZ(object_mat_h, rpy, xyz);
    object_t.object_vertices_mat = moved_obj_mat_h(1:3, :);
    object_t.object_vertices_mat_h = moved_obj_mat_h;
    object_t.object_vertices = convertXYZmatrixToXYZstruct(moved_obj_mat_h);
    object_t.target_size = target_size;
    object_t.rpy = rpy;
    object_t.xyz = xyz;
    object_t.H = constructHByRPYXYZ(rpy, xyz);
    object_t.H_inv = inv(object_t.H);
    [object_t.normal, object_t.centroid] = computePlane(moved_obj_mat_h);
    object_t.connected_lines = point3DToLineForDrawing(moved_obj_mat_h(1:3, :), 2);
end