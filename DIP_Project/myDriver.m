I_orig = linear_contrast_stretching( double(imread('einstein.bmp')));
[M,N,C] = size(I_orig);
if size(I_orig,3)==3
    I_gray = rgb2gray(I_orig);
else
    I_gray = I_orig;
end


[Tx,Ty] = etf(I_gray, 5, 3);
visualize_etf(Ty, Tx);

rho = 0.99;
sig_m = 3.0;
sig_c = 1.0;
tau = 1.0;
[E, He, Hg] = f_dog(I_gray, Ty, Tx, rho, sig_m, sig_c, tau, 3);

sig_e = 2;
sig_g = 0.5;
r_e = 10;
r_g = 10;
Img = fbl(I_orig,  Ty, Tx, sig_e, r_e, sig_g, r_g, 2);

quantize = 10;
if size(I_orig,3)==3
    colorTransform = makecform('srgb2lab');
    Img_quant = applycform(Img, colorTransform);
    
    Img_quant(:,:,1) = my_quantize(Img_quant(:,:,1), quantize);
    
    colorTransform = makecform('lab2srgb');
    Img_quant = applycform(Img_quant, colorTransform);
    
else
    Img_quant = my_quantize(Img, quantize);
end