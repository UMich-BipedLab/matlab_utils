function output_text = appendTextfromStrucure(previous_text, append_text, next_line)
    if isstring(append_text) || ischar(append_text) || isnumeric(append_text)
        if isnumeric(append_text)
            append_text = num2str(append_text, 4);
        end
        if next_line
            previous_text = previous_text + newline + num2str(append_text);
        else
            previous_text = previous_text + num2str(append_text);
        end
    elseif isstruct(append_text)
        fns = fieldnames(append_text);
        for i = 1:length(fns)
            %%% previous
%             previous_text = printStructure(previous_text, fns{i});
            previous_text = printStructure(previous_text, fns{i}) + ": ";
            if isnumeric([append_text.(fns{i})])
                txt = num2str([append_text.(fns{i})]);
            else
                txt = append_text.(fns{i});
            end
            previous_text = printStructure(previous_text, txt, 0);
        end
    end
    output_text = previous_text;
end