function object_list = recomputeConsistentNormals(origin_centriod, object_list)
    num_objects = length(object_list);
    for objects = 1:num_objects
        dir_vec = origin_centriod - object_list(objects).centroid;
        if ~isfield(object_list, 'normal')
           [object_list(objects).normal, ~] = computePlane(object_list.points_mat);
        end
        object_list(objects).consistent_normal = computeConsistentNormals(object_list(objects).normal, dir_vec);
    end
end