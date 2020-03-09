function checkDirectory(path)
    if ~exist(path, 'dir')
       mkdir(path)
    end
end