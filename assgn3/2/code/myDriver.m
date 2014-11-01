K_array = [1 2 3 5 10 20 30 50 75 100 125 150 170];
PER = face_recog_generate(K_array, '../../dataset')

K2_array = [1 2 3 5 10 20 30 50 60 65 75];
PER2 = face_recog_generate_yale(K2_array, '../../dataset')