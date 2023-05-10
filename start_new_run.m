function new_run = start_new_run()

%clc;

flag = 1;

while flag
    resp = input("New run? [y/n]: ", "s");
    
    if strcmp(resp, "y")
        flag = 0;
        new_run = 1;
        
    elseif strcmp(resp, "n")
        flag = 0;
        new_run = 0;
        
    else
        fprintf("Please press [y/n]\n");
    end
    
end


end