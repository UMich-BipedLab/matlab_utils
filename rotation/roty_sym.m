function rotmat = roty_sym(beta)
    rotmat = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];
end