function [errorImage, outImage, sp_gaus]  = bilateralFiltering(sp_sig, in_sig)

I = load('barbara.mat');
I = I.imageOrig;



I = linear_contrast_stretching(I);

I2 = randn(size(I))*0.05;
I2 = I2 + I;
errorImage = I2;
%figure , imshow(I2/100);

[w,h] = size(I2);

win_size = 5;
win_size_h = 2;
sp_gaus = fspecial('gaussian',win_size,sp_sig);

out_image = zeros(w,h);

for i = 1:1:w
    for j = 1:1:h
        i_min = max(1,i-win_size_h);
        j_min = max(1,j-win_size_h);
        i_max = min(w,i+win_size_h);
        j_max = min(h,j+win_size_h);
        win_arr = I2(i_min:i_max,j_min:j_max);
        
        i1_min = win_size_h + 1 - (i - i_min);
        j1_min = win_size_h + 1 - (j - j_min);
        i1_max = win_size_h + 1 + (i_max - i);
        j1_max = win_size_h + 1 + (j_max - j);
        sp_gaus_arr = sp_gaus(i1_min:i1_max,j1_min:j1_max);
        
        
        in_gaus = normpdf(win_arr,0,in_sig);
        mul_gaus = in_gaus .* sp_gaus_arr;
        sum_gaus = sum(mul_gaus(:));
        out_image(i,j) = sum(sum(mul_gaus .* win_arr)) / sum_gaus;
        
    end    
end

out_image = linear_contrast_stretching(out_image);
outImage = out_image;
sqr_diff = (out_image-I).^2;
rmsd = sqrt(sum(sqr_diff(:))/(w*h))



