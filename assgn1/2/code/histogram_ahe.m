function new_img =  histogram_ahe(raw_img,w)
[M,N]= size(raw_img);
new_img = zeros(M,N);

for i = 1:M
    for j = 1:N
        new_img(i,j) = histogram_window(raw_img,i,j,w);
    end
end
