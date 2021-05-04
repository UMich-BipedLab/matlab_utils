function rotmat = rotx_sym(alpha)
    rotmat = [1 0 0;0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
end