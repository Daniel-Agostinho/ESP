function ESP_Maria(participant_id, run_id)

%% Run config
run_id = strcat(participant_id, "_", run_id);
config.response_file = strcat("logs\", run_id, "_response.txt");
config.log_file = strcat("logs\", run_id, "_log.txt");

if ~exist(config.response_file, 'file')
    temp_out_file = fopen(config.response_file, "a");
    fprintf(temp_out_file, "%s\t%s\t%s\t%s\t%s\n", "Event", "Response", "Reaction_time", "Correct_answer", "Responsed_correct");
    fclose(temp_out_file);
end

if ~exist(config.log_file, 'file')
    temp_out_file = fopen(config.log_file, "a");
    fprintf(temp_out_file, "%s\t%s\n", "Time", "Event");
    fclose(temp_out_file);
end

% setup +/- igual para todos os paradigmas
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference', 'SuppressAllWarnings', 1);  
scrID = max(Screen('Screens'));
white= WhiteIndex(scrID);
black= BlackIndex(scrID);
grey= white/2;
[window,windowRect]= PsychImaging('OpenWindow',scrID,black);
[screenXpixels, screenYpixels]= Screen('WindowSize', window);
[xCenter, yCenter]= RectCenter(windowRect);
Screen('TextFont', window, 'Ariel');  %tipo de letra
Screen('TextSize', window, 48); %tamanho de letra

config.window = window; 
config.windowRect = windowRect;
config.xCenter = xCenter; %xcentro do rect onde vai aparecer a imagem
config.yCenter = yCenter;  %ycentro do rect onde vai aparecer a imagem


%ligar a porta paralela
config.trigger.ioObj = io64; 
config.trigger.status = io64(config.trigger.ioObj); 
config.trigger.address = hex2dec('E010'); % adress da porta paralela

% Create Trials configs
config.trial_info.numberConditions = 3;
config.trial_info.numberTypes = 2; % congruente ou incongruente
config.trial_info.numberEmotions = 2; % feliz ou triste
config.trial_info.numberFaces = 6; % número de faces em imagem
config.trial_info.NrTrials = 6; % número de trials
directory_path = "Img/";
config.trial_info.Textures = create_img_textures(directory_path, config.window);

%% Variables

config.readyTime = 1; % tempo de cruz de fixação
config.firstElementTime = 1; % tempo de face e label sobrepostos para primeira condição, tempo de face OU label para segunda e terceira condições 
config.secondElementTime = 1; % tempo de face e label sobrepostos para segunda e terceira condições
config.feedbackTime = 1; % tempo com screen em pergunta e tempo para responder
config.textfeedbackTime = 'Congruente? "C" \n\nIncongruente? "I"' ; % texto com pergunta
config.labelColor = [1 1 1]; % cor da label, neste caso branco porque o fundo é preto
config.centChary = -8; % centro y para label (F e T)
config.centCharxF = 12; % centro x para label F
config.centCharxT = 17; % centro x para label T
config.centfeedback = [config.xCenter - 220, config.yCenter - 20];

%% Rectangle

pixelsY= 400; % alterar tamanho retângulo consoante tamanho do ecrã (metade)
pixelsX= 275; % alterar tamanho retângulo consoante tamanho do ecrã (metade)
newCent = -50; % newCent vai subtrair a coordenada do yCenter do retângulo para colocar a cabeça da pessoa centrada com a cruz de fixação

config.rectangle = create_rectangle(newCent, pixelsX, pixelsY, config);

%% Fixation Cross

fixCrossDimPix = 40; % espessura cruz de fixação
config.fixCross = create_fixation_cross(fixCrossDimPix);

%% Run

trials = create_trials(config);
run_trials(config, trials);

sca;
Screen('CloseAll');
log_corrector()
fprintf(" ");
%clc;

end