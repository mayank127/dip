function new_img = histogram1(raw_img)
freq_array = zeros(256);
cum_freq = zeros(256);
[M,N] = size(raw_img);
new_img = zeros(M,N);

for i = 1:M
    for j = 1:N
        val = raw_img(i,j);
        freq_array(val+1) = freq_array(val+1) + 1;
    end
end

sum=0;

for k = 1:256
    sum = sum + freq_array(k);
    cum_freq(k) = sum;
end

for i = 1:M
    for j = 1:N
        val = raw_img(i,j);
        new_img(i,j) = cum_freq(val+1)*255/(M*N);
    end
end


