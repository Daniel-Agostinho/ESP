function responselogging(config, event_type, correct_type)

%{
- Participante só pode responder a partir do momento em que tem a questão no
ecrã de forma a não interferir com sinal motor antes da pergunta
- Se não responder no 1 segundo em que a pergunta está no ecrã, avança na
mesma para a cruz de fixação
- Tem 1 segundo para responder, se responder depois disso tem mais 0,5
segundos para a resposta ficar registada
- Só regista respostas em 'c' ou 'i'
- Caso o participante não responda, matlab devolve '-1'
- Vai registar a resposta, o tempo de resposta e o tipo de evento (definido
pelo trigger)
%}

file_name = config.response_file;

init_time = GetSecs;
wait4key = true;

while wait4key
    [keyIsDown, ~, keyCode] = KbCheck;
    current_time = GetSecs;

        if keyIsDown 
        response = KbName(keyCode);    
            if strcmp(response, "s") || strcmp(response, "d")
                if strcmp(response, "s")
                    response = 1;
                else
                    response = 2;
                end          
            answer_time = GetSecs;
            reaction_time = answer_time - init_time; 
            wait4key = false;

            % Debug
            out_file = fopen(file_name, "a");
            fprintf(out_file, "%d\t%d\t%d\t%d\t%d\n", event_type, response, reaction_time, correct_type, response == correct_type);
            fclose(out_file);

            end

        end


    if current_time - init_time >= 2
        wait4key = false;
        out_file = fopen(file_name, "a");
        fprintf(out_file, "%d\t%d\t%d\t%d\t%d\n", event_type, -1, -1, correct_type, 0);
        fclose(out_file);  
    end

              
end

end