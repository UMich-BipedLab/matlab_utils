function plotRingPlane(figure_handle, opts, object_list, plane_intersect, ring_t, t_mesh_size)

    % draw ring plane
    if ~isempty(plane_intersect)
        points = [[plane_intersect(:).point], [object_list(:).centroid]];
    else
        points = [object_list(:).centroid];
    end
    

    %     mesh_size = [-max(max(points(1:2,:))), max(max(points(1:2,:)))];
    offset_max = 0;
    offset_min = 0;
    if exist('t_mesh_size', 'var')
        mesh_size = t_mesh_size;
    else
        mesh_size = [min(min(points(1:2,:))) - offset_min, max(max(points(1:2,:))) + offset_max];
    end

    [P, Q] = meshgrid(mesh_size(1): (mesh_size(2)-mesh_size(1))/20: mesh_size(2)); 
    %     [P, Q] = meshgrid(-20: (mesh_size(2)-mesh_size(1))/20: 20); 
    w = -null(ring_t.ring_normal'); 
    X = ring_t.ring_centroid(1) + w(1,1)*P + w(1,2)*Q; % Compute the corresponding cartesian coordinates
    Y = ring_t.ring_centroid(2) + w(2,1)*P + w(2,2)*Q; %   using the two vectors in w
    Z = ring_t.ring_centroid(3) + w(3,1)*P + w(3,2)*Q;
    
    [~, figure_handle] = checkFigureHandle(figure_handle, 1);
    surf(figure_handle, X, Y, Z, 'FaceAlpha', 0.3);
end