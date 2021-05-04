% clc
% array = [9 9 9 8 7 7 7 7 7 8 1];
% t_findDuplicatedOnce(array);
% 
function duplicates = findDuplicatedOnce(vec, duplication_number)
    [C, ~, ic] = unique(vec,'first','legacy');
    duplicates = [];
    if ~exist('duplication_number', 'var')
        duplication_number = 2;
    end
    for i = 1:length(C)
        counts = sum(ic==i);
        if counts >= duplication_number
            duplicates = [duplicates, C(i)];
        end
    end
end