%% Main ESP Maria_Coelho

clear all; close all; clc;

pool = parpool();

if ~exist("logs", 'dir')
       mkdir("logs")
end

% Output file setup
clc;
fprintf('\n\n\n\nWelcome to the new strup! Enjoy and have fun....\n')
fprintf('Participant setup\n')
p_id = input("Participant ID: ", "s");
run_id = input("Run ID: ", "s");

ESP_Maria(p_id, run_id)
running = 1;

while running
    new_run = start_new_run();
    
    if new_run
        fprintf('Old run: %s\n', run_id)
        run_id = input("Run ID: ", "s");
        ESP(p_id, run_id)
    else
        running = 0;
    end
       
end

delete(pool);
clear all; clc;

