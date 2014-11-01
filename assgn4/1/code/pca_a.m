img = double(imread('barbara256.png'));
sigma = 20;
noise_img  = img + randn(size(img))*sigma;
[N,M]=size(img);
tot_patches = (M-6)*(N-6);
P = zeros(49,tot_patches);

for i=1:N-6
    for j=1:M-6
        arr = noise_img(i:i+6,j:j+6);
        P(:,(i-1)*(N-6)+j) = arr(:);
    end
end

PPT = P*P';
[V, D] = eig(PPT);
alpha = V'*P;

alpha_bar = max(0, (sum(alpha.^2, 2)/tot_patches - sigma^2));

wiener = alpha_bar./(alpha_bar+sigma^2);
alpha = bsxfun(@times, wiener, alpha);
P = V*alpha;

fin_img = zeros(size(img));
count_img = zeros(size(img));


for i=1:N-6
    for j=1:M-6
        arr = reshape(P(:,(i-1)*(N-6)+j), 7,7);
        fin_img(i:i+6,j:j+6) = fin_img(i:i+6,j:j+6) + arr;
        count_img(i:i+6,j:j+6) = count_img(i:i+6,j:j+6) + 1;
    end
end

fin_img = fin_img./count_img;
fin_img = linear_contrast_stretching(fin_img);
%imshow(fin_img);

myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

imagesc(fin_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;

rmsd_finish = sqrt(sum(sum((fin_img - linear_contrast_stretching(img)).^2)))




 