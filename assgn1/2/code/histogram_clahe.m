function new_img = histogram_clahe(raw_img,w,th)
[M,N]= size(raw_img);
new_img = zeros(M,N);

for i = 1:M
    for j = 1:N
        new_img(i,j) = histogram_threshhold(raw_img,i,j,w,th);
    end
end
