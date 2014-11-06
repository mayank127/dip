I1 = double(imread('../images/parrot.png'));
I2 = double(imread('../images/flower.png'));

[I_mod1, I_clust1] = smooth_seg(I1);
[I_mod2, I_clust2] = smooth_seg(I2);
