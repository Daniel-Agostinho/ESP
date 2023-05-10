function [texture, text, trigger] = get_trial_info(trial, Textures)

trigger_labels = cat(3,[10 12 ; 14 16], [20 22 ; 24 26], [30 32 ; 34 36]);
% trigger_labels = [60, 70, 80];

if trial.emotion == 2 
    face_idx_step = 6;  

else
    face_idx_step = 0;
end

face_idx = trial.face + face_idx_step;
texture = Textures(face_idx);


if trial.type == 1
    if trial.emotion == 1
        text = 'F';
    else
        text = 'T';
    end
else
    if trial.emotion == 1
        text = 'T';
    else
        text = 'F';
    end
end

trigger = trigger_labels(trial.type, trial.emotion, trial.condition);
% trigger = trigger_labels(trial.condition);


end