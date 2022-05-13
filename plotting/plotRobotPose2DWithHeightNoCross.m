% plots an arrow with a cross at the arrowend
% pose = [x, y, z, theta], theta in rad
% fig = createFigureOptions(1, 100, "RobotPose", 1, 1, 12);
% [axes_handles, fig_handles] = createFigHandleWithOptions(fig);
% t_plotRobotPose2DWithHeight(axes_handles, [2,-3, 3, deg2rad(45)], 'r', 2);
% showCurrentPlot(axes_handles, "arrow", [1,90])

function h = plotRobotPose2DWithHeightNoCross(axes_h, pose, arrowColor, arrowLength)
    pose = makeColumn(pose);
    % points on the arrow
    R = [cos(pose(4)), -sin(pose(4)); sin(pose(4)), cos(pose(4))];
    arrowHead = [0.7, 1, 0.7;0.15, 0, -0.15;] * arrowLength;
    arrowHead(:,1) = pose(1:2,1) + R*arrowHead(:,1);
    arrowHead(:,2) = pose(1:2,1) + R*arrowHead(:,2);
    arrowHead(:,3) = pose(1:2,1) + R*arrowHead(:,3);
    arrowHead = [arrowHead; pose(3), pose(3), pose(3)];
    
    arrowBody = [pose(1), arrowHead(1,2); 
                 pose(2), arrowHead(2,2);
                 pose(3), pose(3)];
    
    


    % plot line
    h1 = plot3(axes_h, arrowHead(1,:), arrowHead(2,:), arrowHead(3,:),...
        'Color',arrowColor,'LineWidth',2); 
    h2 = plot3(axes_h, arrowBody(1,:),arrowBody(2,:), arrowBody(3,:), ...
        'Color',arrowColor,'LineWidth',2); ;
    h = [h1, h2];
end
