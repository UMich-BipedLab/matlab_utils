function schur_complement = computeSchurComplement(M, use_built_in)
    if ~exist('use_built_in', 'var')
        use_built_in = 1;
    end
    A = M(1,1);
    B = M(1, 2:end);
    C = M(2:end, 1);
    D = M(2:end, 2:end);

    schur_complement = D - C*1/A*B;
%     if use_built_in
%         schur_complement = A - B/D*C;
%     else
%         schur_complement = A - B*inverse(D)*C;
%     end
end