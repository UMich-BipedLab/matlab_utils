% A = struct('f1', 1, 'f2', 2, 'f3', 3);
% B = struct('f1', 4, 'f2', 5, 'f7', []);
% copyStructure_(A, B)
% copyStructure_(A)
function to_B = copyStructure(from_A, to_B)
    if ~exist('to_B', 'var')
        to_B = struct();
    end
    for fn = fieldnames(from_A)'
       to_B.(fn{1}) = from_A.(fn{1});
    end
end