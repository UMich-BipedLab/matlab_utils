function index = findVectorFromStructure(structure_t, field, vector)
    pall = cat(1, structure_t(:).(field));
    index = find(ismember(pall, vector, 'rows'));
end