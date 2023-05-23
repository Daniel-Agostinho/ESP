function EventfileT = delay_corrector (filename)

EventfileT = readtable(filename);
EventfileT.latency(2:end) = EventfileT.latency(2:end) -500;
writetable(EventfileT, 'eventfile_delaycorrected.csv')
end




