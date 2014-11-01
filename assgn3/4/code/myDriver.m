K = 175;
data = face_recog_generate(K, '../../dataset');

threshold = sum(sum(data(36:40,1:5,1)))/25 * 0.95;
counts = zeros(40,1);



for i=1:40
    counts(i) = size(find(data(i,:,1)>threshold),2);
end

false_negatives = sum(counts(1:35))
false_poitives = 50 - sum(counts(36:40))