function rotmat = rotz_sym(gamma)
    rotmat = [cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
end
