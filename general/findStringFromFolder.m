function found_in_files = findStringFromFolder(path_to_folder, string_to_find, print_process, exclude_file)
    exclude_itself = 1;
    if ~exist('print_process', 'var')
        print_process = 1;
    end
    if ~exist('exclude_file', 'var')
        exclude_itself = 0;
    end
    directory = path_to_folder;      % Full path of the directory to be searched in
    % filesAndFolders = dir(directory);     % Returns all the files and folders in the directory
    filesAndFolders = dir(fullfile(directory, '**/*.m'));     % Returns all the files and folders in the directory
    filesInDir = filesAndFolders(~([filesAndFolders.isdir]));  % Returns only the files in the directory
    stringToBeFound = string_to_find;
    numOfFiles = length(filesInDir);
    i=1;
    if_found = false;
    found_in_files = [];
    while(i<=numOfFiles)
        filename = filesInDir(i).name;                              % Store the name of the file
        full_path = filesInDir(i).folder;
        full_path_name = filesInDir(i).folder + "/" + filename;
        fid = fopen(full_path_name);
        while(~feof(fid))                                           % Execute till EOF has been reached
            contentOfFile = fgetl(fid);                             % Read the file line-by-line and store the content
            found = strfind(contentOfFile,stringToBeFound);         % Search for the stringToBeFound in contentOfFile
            if ~exclude_itself
                is_itself = 0;
            else
                is_itself = filename == string(exclude_file);
            end
            if ~isempty(found) && ~is_itself
                if print_process
                    foundString = strcat('Found in file------', filename);
                    disp(foundString);
                end

                full_path = filesInDir(i).folder;
                full_path_name = filesInDir(i).folder + "/" + filename;
                found_in_files = [found_in_files; string(full_path_name)];
                if_found = true;
            end
        end
        fclose(fid);                                                % Close the file
        i = i+1;
    end
    if ~if_found
        disp("Nothing found")
    end
end