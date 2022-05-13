function projected_point = projectPointToPlance(...
    point_on_plane, plane_normal, to_be_projected_point)
    plane_normal = plane_normal ./ norm(plane_normal);
    v = point_on_plane - to_be_projected_point;
    dis_plane_to_point = dot(plane_normal, v);
    projected_point = to_be_projected_point + ...
        dis_plane_to_point * plane_normal;
end