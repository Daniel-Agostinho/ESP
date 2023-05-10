function log_corrector()

files_loc = dir(['logs\*_log.txt']);

for i=1:size(files_loc, 1)
file_loc = [files_loc(i).folder,'\', files_loc(i).name];

m = readmatrix(file_loc);

m(:, 1) = m(:, 1) - m (1, 1);
header = {'Time' 'Event'};

final_data = [header; num2cell(m)];

writecell(final_data, file_loc,'Delimiter','tab')
end


end