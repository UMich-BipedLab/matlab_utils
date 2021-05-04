% plots an arrow with a cross at the arrowend
% pose = [x, y, theta], theta in rad

function h = plotRobotPose2D(axes_h, pose, arrowColor, arrowLength)
    pose = makeColumn(pose);
    % points on the arrow
    R = [cos(pose(3)), -sin(pose(3)); sin(pose(3)), cos(pose(3))];
    arrowHead = [0.7, 1, 0.7; 0.15, 0, -0.15] * arrowLength;
    arrowHead(:,1) = pose(1:2,1) + R*arrowHead(:,1);
    arrowHead(:,2) = pose(1:2,1) + R*arrowHead(:,2);
    arrowHead(:,3) = pose(1:2,1) + R*arrowHead(:,3);
    arrowBody = [pose(1), arrowHead(1,2); pose(2), arrowHead(2,2)];
    crossLine_1 = [-0.2, 0.2; 0.2, -0.2]*arrowLength;
    crossLine_1(:,1) = pose(1:2,1) + R*crossLine_1(:,1);
    crossLine_1(:,2) = pose(1:2,1) + R*crossLine_1(:,2);
    crossLine_2 = [0.2, -0.2; 0.2, -0.2]*arrowLength;
    crossLine_2(:,1) = pose(1:2,1) + R*crossLine_2(:,1);
    crossLine_2(:,2) = pose(1:2,1) + R*crossLine_2(:,2);


    % plot line
    h1 = line(axes_h, arrowHead(1,:),arrowHead(2,:), ...
        'Color',arrowColor,'LineWidth',2); 
    h2 = line(axes_h, arrowBody(1,:),arrowBody(2,:), ...
        'Color',arrowColor,'LineWidth',2); 
    h3 = line(axes_h, crossLine_1(1,:),crossLine_1(2,:), ...
        'Color',arrowColor,'LineWidth',2);
    h4 = line(axes_h, crossLine_2(1,:),crossLine_2(2,:), ...
        'Color',arrowColor,'LineWidth',2);
    h = [h1, h2, h3, h4];
end
