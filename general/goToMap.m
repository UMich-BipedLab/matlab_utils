function point = goToMap(point, world_to_map_resolution)
    % (1, 1) -> map_to_world_resolution*(1, 1)
    point = point.*world_to_map_resolution;
end