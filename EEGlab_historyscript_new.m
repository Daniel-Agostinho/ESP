%% Script for Preprocessing in EEGlab

%% Run EEGlab

[ALLEEG, EEG, CURRENTSET, ALLCOM] = eeglab; 

%% Participant code

code = 'P06';

%% Load Datasets

% Input and Output directories
inDir = [code, '\', 'eeg'];
outDir = [code, '\', 'eeg'];

% File names of .vhdr files
fileNames = {[ code, 'run1.vhdr'], [ code, 'run2.vhdr'], [ code, 'run3.vhdr'], [ code, 'run4.vhdr'], [ code, 'run5.vhdr'], [ code, 'run6.vhdr'], [ code, 'run7.vhdr'], [ code, 'run8.vhdr']};
all_eeg = [];
for i = 1:size(fileNames, 2)
    EEG = pop_loadbv(inDir, fileNames{i});
    all_eeg = [all_eeg, EEG];
end


% Load datasets 


% Merge datasets
EEG = pop_mergeset(all_eeg, 1:size(fileNames, 2), 0);
% EEG.setname=[code, 'allruns'];
EEG = pop_saveset(EEG, 'filename', [code, 'allruns'], 'filepath', outDir);

%% Edit Channel Locations

EEG = pop_chanedit(EEG, 'changefield', {3 'labels' 'EOGv1'});
EEG = pop_chanedit(EEG, 'changefield', {4 'labels' 'ref2'});
EEG = pop_chanedit(EEG, 'changefield', {33 'labels' 'EOGv2'});
EEG = pop_chanedit(EEG, 'changefield', {59 'labels' 'EOGh1'});
EEG = pop_chanedit(EEG, 'changefield', {62 'labels' 'EOGh2'});
EEG = pop_saveset( EEG, 'savemode', 'resave');

%% Downsampling the data to 500Hz

EEG = pop_resample( EEG, 500);
EEG.setname= [ code, 'allruns_resampled'];

%% Filter the data

% High-pass filter to 0.1 Hz
EEG = pop_eegfiltnew(EEG, 'locutoff',0.1);

% Low-pass filter to 1 Hz
EEG = pop_eegfiltnew(EEG, 'hicutoff',100);

% Notch filter between 47.5 Hz and 52.5 Hz
EEG = pop_eegfiltnew(EEG, 'locutoff',47.5,'hicutoff',52.5,'revfilt',1);

% Save dataset
EEG.setname= [ code, 'allruns_resampled_fil'];
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil.set'],'filepath', outDir);
%% Interpolate bad channels by visual inspection

% Open dataset and choose bad channels x y z
pop_eegplot( EEG, 1, 1, 1);
EEG = pop_interp(EEG, [28  34], 'spherical');
EEG.setname= [ code, 'allruns_resampled_fil_int'];

%% Reference the data 

% Average reference
EEG = pop_reref( EEG, [],'exclude',[3 4 33 59 62 64] );

% Ear lobes
    % Set reference channels to earlobes
    % ref_channels = {'Fp1', 'ref2'};
EEG    
    % Find the indices of the reference channels
    % ref_indices = [];
    % for i = 1:length(ref_channels)
    %     ref_indices(i) = find(strcmp({EEG.chanlocs.labels}, ref_channels{i}));
    % end
    % 
    % % Compute the mean of the reference channels
    % EEG = ref_data = mean(EEG.data(ref_indices, :), 1);
    %
    % % Subtract the reference channels from the data
    % for i = 1:EEG.nbchan
    %     EEG.data(i, :) = EEG.data(i, :) - ref_data;
    % end 

EEG.setname= [ code, 'allruns_resampled_fil_int_avref'];
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref.set'],'filepath', outDir);

%% Extract epochs to remove pre and post run noise

EEG = pop_epoch( EEG, {  'S  5'  }, [-1  4], 'newname', [ code, 'allruns_resampled_fil_int_avref_ epochs'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-500 0] ,[]);

%% Remove noisy data through eye inspection

pop_eegplot(EEG, 1, 0, 1);
EEG.setname= [ code, 'allruns_resampled_fil_int_avref_preICA.set'];
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_preICA.set'],'filepath', outDir);

%% Run ICA

% Run ICA
EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'interrupt','on', 'chanind', ''); % Aqui não sei dizer ao matlab que quero remover alguns canais da decomposição do ICA, parece-me no input chanind mas não sei onde o por

% Visualize components
pop_selectcomps(EEG, [1:end] );
pop_eegplot( EEG, 0, 1, 1);

% Remove bad components x y
EEG = pop_subcomp( EEG, [x y], 0);
EEG = eeg_checkset( EEG );
pop_eegplot( EEG, 0, 1, 1);

% Visualize remaining components
pop_selectcomps(EEG, [1:end] );
pop_eegplot( EEG, 0, 1, 1);

% Remove unnecessary channels
EEG = pop_select( EEG, 'rmchannel',{'EOGv1','ref2','EOGv2','EOGh1','EOGh2','batatas'});
EEG.setname= [ code, 'allruns_resampled_fil_int_avref_ICA_clean.set'];
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_ICA_clean.set'],'filepath', outDir);

%% Extract new epochs based on conditions
% Preciso que o matlab crie estes datasets a partir do P03allruns_resampled_fil_int_avref_ICA_clean.set

% Condition 1: Face + Label Congruent
EEG = pop_epoch( EEG, {  'S  10' 'S 12'  }, [-2  1], 'newname', [ code, 'allruns_resampled_fil_int_avref__ICA_clean_C1_cong'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-500 0] ,[]);
EEG = pop_saveset( EEG, 'filename',[ code,'allruns_resampled_fil_int_avref_ICA_clean_C1_cong.set'],'filepath',outDir);

% Condition 1: Face + Label Incongruent
EEG = pop_epoch( EEG, {  'S  14' 'S 16'  }, [-2  1], 'newname', [ code,'allruns_resampled_fil_int_avref__ICA_clean_C1_incong'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-500 0] ,[]);
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_ICA_clean_C1_incong.set'],'filepath', outDir);

% Condition 2: Label --> Face + Label Congruent
EEG = pop_epoch( EEG, {  'S  20' 'S 22'  }, [-2  1], 'newname', [ code, 'allruns_resampled_fil_int_avref__ICA_clean_C2_cong'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-1500 -1000] ,[]);
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_ICA_clean_C2_cong.set'],'filepath', outDir);

% Condition 2: Label --> Face + Label Incongruent
EEG = pop_epoch( EEG, {  'S  22' 'S 24'  }, [-2  1], 'newname', [ code, 'allruns_resampled_fil_int_avref__ICA_clean_C2_incong'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-1500 -1000] ,[]);
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_ICA_clean_C2_incong.set'],'filepath', outDir);

% Condition 3: Face --> Face + Label Congruent
EEG = pop_epoch( EEG, {  'S  30' 'S 32'  }, [-2  1], 'newname', [ code, 'allruns_resampled_fil_int_avref__ICA_clean_C3_cong'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-1500 -1000] ,[]);
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_ICA_clean_C3_cong.set'],'filepath', outDir);

% Condition 3: Face --> Face + Label Congruent
EEG = pop_epoch( EEG, {  'S  34' 'S 36'  }, [-2  1], 'newname', [ code, 'allruns_resampled_fil_int_avref__ICA_clean_C3_incong'], 'epochinfo', 'yes');
EEG = pop_rmbase( EEG, [-1500 -1000] ,[]);
EEG = pop_saveset( EEG, 'filename',[ code, 'allruns_resampled_fil_int_avref_ICA_clean_C3_incong.set'],'filepath', outDir);

