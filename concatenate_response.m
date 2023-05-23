function Allresponse = concatenate_response (path)
files = dir(fullfile(path, 'logs', '*_response.txt'));

Allresponse = table;
    for i=1:length(files)
        response_tab = readtable(fullfile(path, 'logs', files(i).name));
       Allresponse = [Allresponse; response_tab];
    end

end
