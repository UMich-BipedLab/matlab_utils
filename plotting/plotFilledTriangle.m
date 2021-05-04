function plotFilledTriangle(axes_h, pose, size, color, alpha)
% pose = [x,y, theta_rad]

% scale
vertices = [-0.3 -0.3 0.7; -0.5 0.5 0]*size;

% rotate
rotm = rotz(rad2deg(pose(3)));
vertices = rotm(1:2, 1:2) * vertices;

% translate
vertices(1,:) = vertices(1,:) + pose(1);
vertices(2,:) = vertices(2,:) + pose(2);

% plot using patch
patch(axes_h, vertices(1,:), vertices(2,:), color, ...
    'FaceAlpha', alpha, 'EdgeColor', 'none');

end
