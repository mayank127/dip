I_orig = linear_contrast_stretching( double(imread('einstein.bmp')));

if size(I_orig,3)==3
    I_gray = rgb2gray(I_orig);
else
    I_gray = I_orig;
end

% [Tx,Ty] = etf(I_gray, 5, 3);
% visualize_etf(Ty, Tx);

rho = 0.99;
sig_m = 3.0;
sig_c = 1.0;
tau = 2.0;
[E, He, Hg] = f_dog(I_gray, Ty, Tx, rho, sig_m, sig_c, tau, 3);