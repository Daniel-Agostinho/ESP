function run_trials(config, trials)
    
    window = config.window;
    fixCross= config.fixCross;
    rectangle = config.rectangle;
    sendtrigger(config, 1);
    
    
    for i=1:length(trials)
        trial = trials{i};
        % Cruz de fixação antes de aparecer o estímulo   
        Screen('DrawLines', window, fixCross.allCoords, fixCross.lineWidthPix, [1 0 0], [config.xCenter config.yCenter]);
        Screen('Flip', window);  
        sendtrigger(config, 5);
        WaitSecs(config.readyTime - 0.01); %se for muito preciso, tenho que subtrair ao readytime o tempo que está em ms no trigger  
        
        if trial.condition == 1     
            Screen('DrawTexture',window,trial.Texture,[],rectangle.textureRect,0);
            DrawFormattedText(window,trial.text,rectangle.center(1)-config.centCharxF,rectangle.center(2)-config.centChary,config.labelColor);
            Screen('Flip',window);
            sendtrigger(config, trial.trigger);
            WaitSecs(config.firstElementTime - 0.01);     
        
        elseif trial.condition == 2     
            DrawFormattedText(window,trial.text,rectangle.center(1)-config.centCharxF,rectangle.center(2)-config.centChary,config.labelColor);
            Screen('Flip',window);
            WaitSecs(config.firstElementTime);
            Screen('DrawTexture',window,trial.Texture,[],rectangle.textureRect,0);
            DrawFormattedText(window,trial.text,rectangle.center(1)-config.centCharxF,rectangle.center(2)-config.centChary,config.labelColor);
            Screen('Flip',window);
            sendtrigger(config, trial.trigger);
            WaitSecs(config.secondElementTime - 0.01); 
            
        else
            Screen('DrawTexture',window,trial.Texture,[],rectangle.textureRect,0);
            Screen('Flip',window);
            WaitSecs(config.firstElementTime);
            Screen('DrawTexture',window,trial.Texture,[],rectangle.textureRect,0);
            DrawFormattedText(window,trial.text,rectangle.center(1)-config.centCharxF,rectangle.center(2)-config.centChary,config.labelColor);
            Screen('Flip',window);
            sendtrigger(config, trial.trigger);
            WaitSecs(config.secondElementTime - 0.01);
                  
        end
        
        % Response  
        Screen('FillRect',window,[0 0 0]);
        DrawFormattedText(window, config.textfeedbackTime , config.centfeedback(1), config.centfeedback(2), config.labelColor);
        Screen('Flip',window);
        parfeval(@responselogging, 0, config, trial.trigger, trial.type); 
        WaitSecs(config.feedbackTime);

    end
    
    sendtrigger(config, 2);
end