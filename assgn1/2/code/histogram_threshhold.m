function new_intensity = histogram_threshhold(raw_img,I,J,w,th)
freq_array = zeros(256);
[M,N] = size(raw_img);

w_half = floor( w/2 );

min_i = max(I-w_half,1);
max_i = min(I+w_half,M);
min_j = max(J-w_half,1);
max_j = min(J+w_half,N);

num_pix = ( max_i - min_i + 1 ) * ( max_j - min_j + 1);

extra_pix = 0;
for i = min_i:max_i
    for j = min_j:max_j
        val = raw_img(i,j);
        if val<th*num_pix     
            freq_array(val+1) = freq_array(val+1) + 1;      
        else
            extra_pix = extra_pix + 1;
        end
        
    end
end

sum=0;
val = raw_img(I,J);
for k = 1:val+1
    sum = sum + freq_array(k) + extra_pix/256;
end

new_intensity = sum*255/num_pix;
   