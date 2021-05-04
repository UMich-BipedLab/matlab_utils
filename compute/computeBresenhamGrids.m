% w_start_p = [1,1];
% w_end_p = [10,-5];
% world_to_map_resolution = 3;
% m_start_p = goToMap(w_start_p, world_to_map_resolution);
% m_end_p = goToMap(w_end_p, world_to_map_resolution);
% [m_x, m_y] = t_computeBresenhamGrids(m_start_p, m_end_p);
% x = goToWorld(m_x, world_to_map_resolution);
% y = goToWorld(m_y, world_to_map_resolution);
% figure(1)
% cla(1)
% % plot([w_start_p(1), w_end_p(1)], [w_start_p(2), w_end_p(2)])
% hold on
% grid on
% plot(x,y,'or');


function [x, y] = computeBresenhamGrids(p1, p2)
%Matlab optmized version of Bresenham line algorithm. No loops.
%Format:
%               [x y]=bham(p1, p2)
%
%Input:
%               (x1,y1): Start position
%               (x2,y2): End position
%
%Output:
%               x y: the line coordinates from (x1,y1) to (x2,y2)
%
%Usage example:
%               [x y]=bham(1,1, 10,-5);
%               plot(x,y,'or');
x1 = p1(1);
y1 = p1(2);
x2 = p2(1);
y2 = p2(2);
x1=round(x1); x2=round(x2);
y1=round(y1); y2=round(y2);
dx=abs(x2-x1);
dy=abs(y2-y1);
steep=abs(dy)>abs(dx);
if steep t=dx;dx=dy;dy=t; end
%The main algorithm goes here.
if dy==0 
    q=zeros(dx+1,1);
else
    q=[0;diff(mod([floor(dx/2):-dy:-dy*dx+floor(dx/2)]',dx))>=0];
end
%and ends here.
if steep
    if y1<=y2 y=[y1:y2]'; else y=[y1:-1:y2]'; end
    if x1<=x2 x=x1+cumsum(q);else x=x1-cumsum(q); end
else
    if x1<=x2 x=[x1:x2]'; else x=[x1:-1:x2]'; end
    if y1<=y2 y=y1+cumsum(q);else y=y1-cumsum(q); end
end
end