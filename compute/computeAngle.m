% compute angle BAC
%      B
%     /
%    /
% A /
%   \
%    \ 
%     \
%      C
%
function angle_rad = computeAngle(B, A, C)
    v1 = B - A;
    v2 = C - A;
    angle_rad = acos( dot(v1, v2)/(norm(v1)*norm(v2)) );
end