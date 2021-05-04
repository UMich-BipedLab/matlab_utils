function [fields, indices_from_fns, picked_indices] = findStructureFields(structure_t, string_to_find, search_type)
	if ~exist('search_type','var')
		search_type = 'contain';
	end
	
	fns = fieldnames(structure_t);
	
	switch lower(search_type)
		case 'contain'
			indices_from_fns = contains(fns, string_to_find);
		case 'start with'
			indices_from_fns = startsWith(fns, string_to_find);
		case 'end with'
			indices_from_fns = endsWith(fns, string_to_find);
		case 'exact'
			indices_from_fns = strcmp(fns, string_to_find);
        otherwise
            error("unknown type: %s", search_type)
	end
	picked_indices = find(indices_from_fns);
	fields = [];
	for i = 1:length(picked_indices)
%                 app.(fns{picked_indices(i)})
		fields = [fields, structure_t.(fns{picked_indices(i)})];
	end
end
