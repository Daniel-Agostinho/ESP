function   sendtrigger (config, value)
   
    parfeval(@logger, 0, config, value);
    
    io64(config.trigger.ioObj,config.trigger.address, value); % send a signal
    WaitSecs(0.01); %10 miliseconds should be perfectly ok
    io64(config.trigger.ioObj,config.trigger.address,0); % stop sending a signal
%     logger(config, value);
end