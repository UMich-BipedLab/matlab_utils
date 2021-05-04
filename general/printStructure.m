%% Current support 1 substructure with numbers, text, vectors (NOT matrices)
% for example:
% test.txt1 = 1;
% test.txt2 = "hey";
% test.txt3 = [1 2 3 4 5];
% [NOT working] test.txt4 = [1 2; 3 4];
% [NOT working] test.txt5.txt = 1;

% printStructure("", test, 0)

function output_text = printStructure(previous_text, append_text, next_line)
    if ~exist('next_line', 'var')
        next_line = 1;
    end
    
    if previous_text == ""
        output_text = appendTextfromStrucure(previous_text, append_text, 0);
    else
        output_text = appendTextfromStrucure(previous_text, append_text, next_line);
    end
end