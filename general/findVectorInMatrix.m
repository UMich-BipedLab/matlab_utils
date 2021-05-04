function [index, times] = findVectorInMatrix(opts, vec, mat)
    if ~exist('opts', 'var') || isempty(opts)
        make_wide = 1;
    elseif isstruct(opts)
        if ~isfield(opts, 'make_wide')
            make_wide = 1;
        else
            make_wide = opts.make_wide;
        end
    elseif isnumeric(opts)
        make_wide = opts;
    end
    
    if make_wide
        mat = makeWideMatrix(mat);
    end
    
    if length(vec) == 2
        I = mat(1,:)==vec(1) & mat(2, :)==vec(2);
    elseif length(vec) == 3
        I = mat(1,:)==vec(1) & mat(2, :)==vec(2) & mat(3, :)==vec(3);
    elseif length(vec) == 4
        I = mat(1,:)==vec(1) & mat(2, :)==vec(2) & mat(3, :)==vec(3) & mat(4, :)==vec(4);
    elseif length(vec) == 5
        I = mat(1,:)==vec(1) & mat(2, :)==vec(2) & mat(3, :)==vec(3) & mat(4, :)==vec(4) & mat(5, :)==vec(5);
    else
        error("No support vector length: %i", length(vec))
    end
    times = sum(I);
    index = find(I);
end