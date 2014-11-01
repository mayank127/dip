function new_intensity = histogram_window(raw_img,I,J,w)
freq_array = zeros(256);
[M,N] = size(raw_img);

w_half = floor( w/2 );

min_i = max(I-w_half,1);
max_i = min(I+w_half,M);
min_j = max(J-w_half,1);
max_j = min(J+w_half,N);

num_pix = ( max_i - min_i + 1 ) * ( max_j - min_j + 1);

for i = min_i:max_i
    for j = min_j:max_j
        val = raw_img(i,j);
        freq_array(val+1) = freq_array(val+1) + 1;
    end
end

sum=0;
val = raw_img(I,J);
for k = 1:val+1
    sum = sum + freq_array(k);    
end

new_intensity = sum*255/num_pix;
   