function trials = create_trials(config)

%{  
    nrTrials: integer number of total trials
    
    numberConditions: integer labeling the type of condition (1, 2 or 3)
    1: face + label
    2: label --> face
    3: face --> label
    
    numberTypes: integer stimulus type (1 or 2)
    1: Congruente
    2: Incongruente
    
    numberEmotions: integer type of emotion (1 or 2)
    1: Happy
    2: Sad
    
    numberFaces: integer number of total facs in Img folder
    
    newCent: Needed to center the face of the image with the center of the
    screeen


%}


numberConditions = config.trial_info.numberConditions;
numberTypes = config.trial_info.numberTypes;
numberEmotions = config.trial_info.numberEmotions;
numberFaces = config.trial_info.numberFaces;
NrTrials = config.trial_info.NrTrials;
Textures = config.trial_info.Textures;

% Randomizar Condições
conditionVectBase = repmat(1:numberConditions, 1, NrTrials/numberConditions);
shufflerCondition= Shuffle(1:NrTrials);
condition = conditionVectBase(:, shufflerCondition);

% Randomizar Congruente(1)/Incongruente(2)
typeVectBase = repmat(1:numberTypes, 1, NrTrials/numberTypes);
shufflerType= Shuffle(1:NrTrials);
trials_type = typeVectBase(:, shufflerCondition);

% Randomizar emoção (1)-> feliz   (2)-> triste
emotionVectBase = repmat(1:numberEmotions, 1, NrTrials/numberEmotions);
shufflerEmotion= Shuffle(1:NrTrials);
emotion = emotionVectBase(:, shufflerEmotion);

% Randomizar face
faceVectBase = repmat(1:numberFaces, 1, NrTrials/numberFaces);
shufflerFace= Shuffle(1:NrTrials);
face = faceVectBase(:,shufflerFace);


for i=1:NrTrials
    trial.condition = condition(i);
    trial.face = face(i);
    trial.emotion = emotion(i);
    trial.type = trials_type(i);
    [trial.Texture, trial.text, trial.trigger] = get_trial_info(trial, Textures);   
    trials{i} = trial;
    clear trial
end


end

