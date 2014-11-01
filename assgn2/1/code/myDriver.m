myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

img = load('lionCrop.mat');
I1 = img.imageOrig;
img = load('superMoonCrop.mat');
I2 = img.imageOrig;


outImage = imageSharpening(I1,.4,20);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage1A.mat outImage;

outImage = imageSharpening(I2,.2,10);
imagesc(outImage);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
outImage = single(outImage);
save ../images/myImage1B.mat outImage;
