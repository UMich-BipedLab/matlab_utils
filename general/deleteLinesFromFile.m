function deleteLinesFromFile(path_to_file, file_name, first_line_to_delete, num_lines_to_delete)

path_to_file = convertStringsToChars(path_to_file);
infile = convertStringsToChars(file_name);
[pathstr, file, ~] = fileparts(infile);
outfile = fullfile(pathstr, [file '.tmp']);
backup_file = fullfile(pathstr, [file '_original.bak']);


if strcmp(infile, outfile)
    error('I refuse to edit a backup file! Nothing has been changed.');
end

backfolder = path_to_file + "/backup/";   %a temporary file in TMP directory
checkDirectory(backfolder);

infile = path_to_file + "/" + file_name;
fin = fopen(infile, 'r');
if fin < 0; error('Input file does not exist'); end


outfile = path_to_file + "/" + outfile;
fout = fopen(outfile, 'w');
if fout < 0
    fclose(fin);
    error('Could not open temporary output file');
end

%read lines before the one to be deleted and write them to output
for K = 1 : first_line_to_delete - 1;
    inline = fgets(fin);
    if ~ischar(inline); break; end;  %end of file?
    fwrite(fout, inline);
end

for K = 1 : num_lines_to_delete
    if ~ischar(inline); break; end   %in case EOF
    inline = fgets(fin);   %and do nothing with it
end

%copy all remaining input lines to output file
while ischar(inline)
    inline = fgets(fin);
    if ischar(inline)   %not if we hit EOF
        fwrite(fout, inline);
    end
end

fclose(fin);
fclose(fout);

%M'Kay, we did the copying and have a file with the desired
%result. Now put it in the proper place

back_full_name = backfolder + backup_file;
original_name= backfolder + file_name;
status = copyfile(infile, original_name);
if ~status
    error('Could not copy file to original_name, file left untouched');
end



status = movefile(infile, back_full_name);


if ~status
    if strcmp(infile, outfile)
        fprintf(2, 'Good thing your programmer is paranoid about people overriding\nsanity checks, because something went wrong and you nearly lost your file!\n');
    else
        status = movefile(outfile, infile);
    end
    error('Could not rename file to .bak, file left untouched');
else
    status = movefile(outfile, infile);
    if ~status
        error( ['Could not rename temp file to original name, original moved to ', outfile]);
    end
end
end