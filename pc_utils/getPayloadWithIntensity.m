function accumulated_payload = getPayloadWithIntensity(point_cloud, pc_iter, num_scan)
    accumulated_payload = [];
    for i = 0:num_scan-1
        points = point_cloud(pc_iter+i, :, 1:5);
        points = (reshape(points, size(points, 2),[]))';
        points = removeZeros(points); % XYZIR1
        accumulated_payload = [accumulated_payload points];
    end
end