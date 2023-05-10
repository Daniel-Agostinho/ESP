function logger(config, trigger)
init_time = GetSecs;

file = config.log_file;

out_file = fopen(file, "a");
fprintf(out_file, "%d\t%d\n", init_time, trigger);
fclose(out_file);

end
