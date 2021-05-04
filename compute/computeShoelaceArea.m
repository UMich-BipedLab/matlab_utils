function area = computeShoelaceArea(opt, x, y)
    if isempty(opt) 
        use_det = 1;
        use_abs = 1;
    else
        if  ~isfield(opt, "use_det")
            use_det = 1;
        else
            use_det = opt.use_det;
        end
        
        if  ~isfield(opt, "use_abs")
            use_abs = 1;
        else
            use_abs = opt.use_abs;
        end
    end
    

    x_col = transpose(x);
    y_col = transpose(y);
    n = length(x);
    xp = [x_col; x_col(1)];
    yp = [y_col; y_col(1)];
    area = 0;
    
    for i = 1:n
        if use_det
            area = area + det([xp(i), xp(i+1); yp(i), yp(i+1)]);
        else
            area = area + xp(i)*yp(i+1) - xp(i+1)*yp(i);
        end
    end
    
    if use_abs
        area = abs(area);
    end
    
    area = 1/2*area;
end