function flag = existAndNotEmpty(variable)
    if exist('variable', 'var') && ~isempty(variable)
        flag = true;
    else
        flag = false;
    end
end