img = double(imread('barbara256.png'));
sigma = 20;
noise_img  = img + randn(size(img))*sigma;
[N,M]=size(img);
tot_patches = (M-6)*(N-6);
P = zeros(49,tot_patches);
K=200;
for i=1:N-6
    for j=1:M-6
        imin = max(1, i-15);
        imax = min(N-6, i+15);        
        jmin = max(1, j-15);
        jmax = min(M-6, j+15);
        
        tot_win_patches = (jmax-jmin+1) * (imax - imin+1);
        P_win = zeros(49,tot_win_patches);
        P_win_K = zeros(49,K);
        for iw=imin:imax
            for jw=jmin:jmax
                arr = noise_img(iw:iw+6,jw:jw+6);
                P_win(:,(iw-imin)*(imax-imin+1)+jw-jmin+1) = arr(:);
            end
        end
        
        P_cent = noise_img(i:i+6,j:j+6);
        P_cent = P_cent(:);
        diffs = bsxfun(@minus, P_win, P_cent);
        diffs = sum(diffs.^2);
        [sortedValues,sortIndex] = sort(diffs);
        sortIndex = sortIndex(1:K);
        
        for k=1:K
            P_win_K(:,k) = P_win(:,sortIndex(k));
        end
        
        PPT = P_win_K*P_win_K';
        [V, D] = eig(PPT);
        alpha = V'*P_win_K;
        
        alpha_bar = max(0, (sum(alpha.^2, 2)/tot_patches - sigma^2));
        wiener = alpha_bar./(alpha_bar+sigma^2);
        
        alpha_cent = wiener.*alpha(:,1);
        P_cent = V*alpha_cent;
        
        P(:,(i-1)*(N-6)+j) = P_cent;
        
    end
end


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
%imshow(fin_img/255);
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

imagesc(fin_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;

rmsd_finish = sqrt(sum(sum((fin_img - linear_contrast_stretching(img)).^2)))

