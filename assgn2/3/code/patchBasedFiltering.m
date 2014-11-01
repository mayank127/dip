function  [origImage, errorImage, outImage, patch_gaus ]= patchBasedFiltering(sig_win, patch_sig)
I = load('barbara.mat');
I = I.imageOrig;
blur = fspecial('gaussian', 5, 0.66);
I = imfilter(I, blur, 'same', 'conv');
I = I(1:2:end, 1:2:end);
I = linear_contrast_stretching(I);

origImage = I;

I2 = randn(size(I))*0.05;
I2 = I2 + I;
errorImage = I2;

[w,h] = size(I2);


patch_size = 9;
patch_size_h = 4;
win_size = 25;
win_size_h = 12;

patch_gaus = fspecial('gaussian',patch_size,patch_sig);
out_image = zeros(w,h);

for i = 1:1:w
    i_min = max(1,i-win_size_h);
    i_max = min(w,i+win_size_h);
    os_min = max(1,i-patch_size_h);
    os_max = min(w,i+patch_size_h);
    i1_min = patch_size_h + 1 - (i - os_min);
    i1_max = patch_size_h + 1 + (os_max - i);
    
    for j = 1:1:h
        
        j_min = max(1,j-win_size_h);
        j_max = min(h,j+win_size_h);
        win_arr = I2(i_min:i_max,j_min:j_max);
        
        
        ot_min = max(1,j-patch_size_h);
        ot_max = min(h,j+patch_size_h);
        orig_patch_arr = I2(os_min:os_max,ot_min:ot_max);
        
        
        j1_min = patch_size_h + 1 - (j - ot_min);
        j1_max = patch_size_h + 1 + (ot_max - j);
        
        crop_gaus = patch_gaus(i1_min:i1_max,j1_min:j1_max);
        
        weight_arr = zeros(size(win_arr));
        
        for s = i_min:1:i_max
            s_min = max(1,s-i1_min);
            s_max = min(w,s+i1_max);
            for t = j_min:1:j_max
                
                t_min = max(1,t-j1_min);
                t_max = min(h,t+j1_max);
                
                patch_arr = I2(s_min:s_max,t_min:t_max);
                
                if isequal(size(patch_arr),size(orig_patch_arr))
                    weight_arr(s-i_min+1,t-j_min+1) = sum(sum(((patch_arr - orig_patch_arr).*crop_gaus).^2));                                     
                end
            end                        
        end             
        
        weight_arr = normpdf(weight_arr,0,sig_win);
        sum_wt = sum(weight_arr(:));
        out_image(i,j) = sum(sum(weight_arr.*win_arr)) / sum_wt;        
    end    
end

out_image = linear_contrast_stretching(out_image);
outImage = out_image;
sqr_diff = (out_image-I).^2;
rmsd = sqrt(sum(sqr_diff(:))/(w*h))


