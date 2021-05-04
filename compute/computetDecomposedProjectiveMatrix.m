function projective_matrix = computetDecomposedProjectiveMatrix(s, theta, tx, ty, shear_k, scale_x, elation_v1, elation_v2)

    sim = [s*cos(theta) -s*sin(theta) tx;
           s*sin(theta)  s*cos(theta) ty;
           0 0 1];
%     
%     shear = eye(3);
%     shear(1, 2) = shear_k;
%     
%     scaling = eye(3);
%     scaling(1, 1) = scale_x;
%     scaling(2, 2) = 1/scale_x;
%     
%     elation = eye(3);
%     elation(3, 1) = elation_v1;
%     elation(3, 2) = elation_v2;   
       
       
    shear = [1 shear_k 0;
             0 1 0;
             0 0 1];

    scaling = [scale_x 0 0;
              0 1/scale_x 0;
              0 0 1];
    elation = [1 0 0;
               0 1 0;
               elation_v1 elation_v2 1];
           
           
%     elation = eye(3);
%     scaling = eye(3);
%     shear = eye(3);
%     sim = eye(3);
    projective_matrix = sim*shear*scaling*elation;
end