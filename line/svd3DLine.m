function [X_ave, line_dir, R2] = svd3DLine(X)
    % Parametric equation of best fit line: L(t)=X_ave+t*line_dir
    % x = X_ave(1) + line_dir(1)*t
    % y = X_ave(2) + line_dir(2)*t
    % z = X_ave(3) + line_dir(3)*t
    X = makeWideMatrix(X);
    X = X';
    N = size(X, 1);
    % Find line of best fit (in least-squares sense) through X
    % -------------------------------------------------------------------------
    X_ave=mean(X,1);            % mean; line of best fit will pass through this point  
    dX=bsxfun(@minus,X,X_ave);  % residuals
    C=(dX'*dX)/(N-1);           % variance-covariance matrix of X
    [R,D]=svd(C,0);             % singular value decomposition of C; C=R*D*R'
    line_dir = R(:,1)';
    
    % NOTES:
    % 1) Direction of best fit line corresponds to R(:,1)
    % 2) R(:,1) is the direction of maximum variances of dX 
    % 3) D(1,1) is the variance of dX after projection on R(:,1)
    % 4) Parametric equation of best fit line: L(t)=X_ave+t*R(:,1)', where t is a real number
    % 5) Total variance of X = trace(D)
    % Coefficient of determineation; R^2 = (explained variance)/(total variance)
    D=diag(D);
    R2=D(1)/sum(D);
end