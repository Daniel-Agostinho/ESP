function  Textures = create_img_textures(directory_path, window)

happy_women_1 = imread(strcat(directory_path, "#1_happy_women.jpg"));
sad_women_1 = imread(strcat(directory_path, "#1_sad_women.jpg"));
happy_women_2 = imread(strcat(directory_path, "#2_happy_women.jpg"));
sad_women_2 = imread(strcat(directory_path, "#2_sad_women.jpg"));
happy_women_3 = imread(strcat(directory_path, "#3_happy_women.jpg"));
sad_women_3 = imread(strcat(directory_path, "#3_sad_women.jpg"));
happy_men_4 = imread(strcat(directory_path, "#4_happy_men.jpg"));
sad_men_4 = imread(strcat(directory_path, "#4_sad_men.jpg"));
happy_men_7 = imread(strcat(directory_path, "#7_happy_men.jpg"));
sad_men_7 = imread(strcat(directory_path, "#7_sad_men.jpg"));
happy_men_8 = imread(strcat(directory_path, "#8_happy_men.jpg"));
sad_men_8 = imread(strcat(directory_path, "#8_sad_men.jpg"));


Textures= [];
% Happy
Textures(1)= Screen('MakeTexture',window,happy_women_1);
Textures(2)= Screen('MakeTexture',window,happy_women_2);
Textures(3)= Screen('MakeTexture',window,happy_women_3);
Textures(4)= Screen('MakeTexture',window,happy_men_4);
Textures(5)= Screen('MakeTexture',window,happy_men_7);
Textures(6)= Screen('MakeTexture',window,happy_men_8);
% Sad
Textures(7)= Screen('MakeTexture',window,sad_women_1);
Textures(8)= Screen('MakeTexture',window,sad_women_2);
Textures(9)= Screen('MakeTexture',window,sad_women_3);
Textures(10)= Screen('MakeTexture',window,sad_men_4);
Textures(11)= Screen('MakeTexture',window,sad_men_7);
Textures(12)= Screen('MakeTexture',window,sad_men_8);

end