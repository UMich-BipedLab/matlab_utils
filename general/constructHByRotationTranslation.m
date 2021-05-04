function H = constructHByRotationTranslation(rotm, translation)
%CREATESE3 Creates a 4x4 from a 3x3 rotation matrix and 3x1 translation
%vector
assert(all(size(rotm)==[3,3]), "Dimension of rotation matrix is wrong")
assert(length(translation)==3, "Dimension of translation vector is wrong")
H = [rotm makeColumn(translation); 
     zeros(1,3) 1];
end

