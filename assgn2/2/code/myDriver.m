myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

spi_gaus = 0.54;
in_gaus = 1.8;

[errorImage, outImage, sp_gaus] = bilateralFiltering(spi_gaus, in_gaus);
imagesc(errorImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
imagesc(sp_gaus);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage2A.mat outImage;

[errorImage, outImage, sp_gaus] = bilateralFiltering(spi_gaus*0.9, in_gaus);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage2A-1.mat outImage;


[errorImage, outImage, sp_gaus] = bilateralFiltering(spi_gaus*1.1, in_gaus);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage2A-2.mat outImage;

[errorImage, outImage, sp_gaus] = bilateralFiltering(spi_gaus, in_gaus*0.9);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage2A-3.mat outImage;

[errorImage, outImage, sp_gaus] = bilateralFiltering(spi_gaus, in_gaus*1.1);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage2A-4.mat outImage;
