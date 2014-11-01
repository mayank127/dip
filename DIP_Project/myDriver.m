I_orig = linear_contrast_stretching( double(imread('lena_std.tif')));
 
I_gray = rgb2gray(I_orig);

[Tx,Ty] = etf(I_gray, 5, 3);