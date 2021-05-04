% opts.verbose.output_level = 2;
% opts.verbose.selective = 0;
% t_displayMessages(opts, "testing",1 , 1);

function displayMessages(opts, input_txt, severity, type)
    % lower number stands for higher severity 
    % higher output_level outputs more message
    % selective: display only taht level of message
    % types: 1) error, 2) warning 3) display
    
    if ~isSubfield(opts, 'verbose.output_level') 
        opts.verbose.output_level = 5;
    end
    
    if ~isSubfield(opts, 'verbose.selective')
        opts.verbose.selective = 0;
    end

    if ~exist('types', 'var')
        type = 3;
    end
    
    if ~exist('severity', 'var')
        severity = 3;
    end
    
    pre_txt = '-'; % has to be char
    pre_txt = string(repmat(pre_txt, [1, severity])) + " ";
    txt = pre_txt + input_txt;
    
    if ~opts.verbose.selective && (severity <= opts.verbose.output_level)
        if type == 1
            error(txt)
        elseif type==2
            warning(txt)
        elseif type==3
            disp(txt)
        end
    elseif opts.verbose.selective && (severity == opts.verbose.output_level)
        if type == 1
            error(txt)
        elseif type==2
            warning(txt)
        elseif type==3
            disp(txt)
        end
    end
end
