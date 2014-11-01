myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];


sig_win = 1;
patch_sig = 2;

tic;

[origImage, errorImage, outImage, patch_gaus] = patchBasedFiltering(sig_win, patch_sig);
imagesc(origImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
imagesc(errorImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
imagesc(patch_gaus);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage3A.mat outImage;

toc;

tic;

[origImage, errorImage, outImage, patch_gaus] = patchBasedFiltering(sig_win*0.9, patch_sig);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage3B.mat outImage;

toc;

tic;

[origImage, errorImage, outImage, patch_gaus] = patchBasedFiltering(sig_win*1.1, patch_sig);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage3C.mat outImage;

toc;