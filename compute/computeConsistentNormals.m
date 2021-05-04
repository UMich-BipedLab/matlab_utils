function normal = computeConsistentNormals(normal, dir_vec)
    
    if normal' * dir_vec < 0
        normal = -normal;
    end
end