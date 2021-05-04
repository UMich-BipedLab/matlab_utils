function flag = checkColinear(points)
    % points should be 2xm (2d) 3xm (2d-homo, 3d), 4xm (3d-homo)
    
    flag = 0; % non-colinear
    % check colinear
    tmp = bsxfun(@minus, points(1:2, :)', mean(points(1:2, :)'));
    tol = 1e-5; % 1e-3 (looser), 1e-1(tight), 2 (tigter)
%     max(size(points(1:2, :)))*eps(norm(points(1:2, :)));
    rnk = rank(tmp', tol);
    if rnk < 2
        flag = 1;
    end
end