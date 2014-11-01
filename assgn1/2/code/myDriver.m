myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

input_img1 = double(imread('barbara.png'));
input_img2 = double(imread('TEM.png'));
input_img3 = double(imread('canyon.png'));


% Contrast stretching
new_img = linear_contrast_stretching(input_img1);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage1A.mat new_img;

new_img = linear_contrast_stretching(input_img2);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage1B.mat new_img;

new_img = input_img3;
new_img(:,:,1) = linear_contrast_stretching(input_img3(:,:,1))/255;
new_img(:,:,2) = linear_contrast_stretching(input_img3(:,:,2))/255;
new_img(:,:,3) = linear_contrast_stretching(input_img3(:,:,3))/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap Jet;colorbar;
save ../images/myImage1C.mat new_img;



% Histogram Equalization
new_img = histogram1(input_img1);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage2A.mat new_img;

new_img = histogram1(input_img2);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage2B.mat new_img;

new_img = input_img3;
new_img(:,:,1) = histogram1(input_img3(:,:,1))/255;
new_img(:,:,2) = histogram1(input_img3(:,:,2))/255;
new_img(:,:,3) = histogram1(input_img3(:,:,3))/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
save ../images/myImage2C.mat new_img;



% Adaptive histogram Equalization
new_img = histogram_ahe(input_img1,100);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage3A-100.mat new_img;

new_img = histogram_ahe(input_img1,10);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage3A-10.mat new_img;

new_img = histogram_ahe(input_img1,200);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage3A-200.mat new_img;


new_img = histogram_ahe(input_img2,100);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage3B-100.mat new_img;

new_img = histogram_ahe(input_img2,10);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage3B-10.mat new_img;

new_img = histogram_ahe(input_img2,200);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage3B-200.mat new_img;


new_img = input_img3;
new_img(:,:,1) = histogram_ahe(input_img3(:,:,1),100)/255;
new_img(:,:,2) = histogram_ahe(input_img3(:,:,2), 100)/255;
new_img(:,:,3) = histogram_ahe(input_img3(:,:,3), 100)/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
save ../images/myImage3C-100.mat new_img;


new_img = input_img3;
new_img(:,:,1) = histogram_ahe(input_img3(:,:,1),10)/255;
new_img(:,:,2) = histogram_ahe(input_img3(:,:,2), 10)/255;
new_img(:,:,3) = histogram_ahe(input_img3(:,:,3), 10)/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
save ../images/myImage3C-10.mat new_img;

new_img = input_img3;
new_img(:,:,1) = histogram_ahe(input_img3(:,:,1),200)/255;
new_img(:,:,2) = histogram_ahe(input_img3(:,:,2), 200)/255;
new_img(:,:,3) = histogram_ahe(input_img3(:,:,3), 200)/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
save ../images/myImage3C-200.mat new_img;




% Contrast Limited Adaptive Histogram Equalization
new_img = histogram_clahe(input_img1,100,0.02);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage4A-001.mat new_img;

new_img = histogram_clahe(input_img1,100,0.01);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage4A-002.mat new_img;


new_img = histogram_clahe(input_img2,100,0.02);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage4B-002.mat new_img;

new_img = histogram_clahe(input_img2,100,0.01);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImage4B-001.mat new_img;



new_img = input_img3;
new_img(:,:,1) = histogram_clahe(input_img3(:,:,1),100, 0.02)/255;
new_img(:,:,2) = histogram_clahe(input_img3(:,:,2), 100, 0.02)/255;
new_img(:,:,3) = histogram_clahe(input_img3(:,:,3), 100, 0.02)/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
save ../images/myImage4C-002.mat new_img;

new_img = input_img3;
new_img(:,:,1) = histogram_clahe(input_img3(:,:,1),100, 0.01)/255;
new_img(:,:,2) = histogram_clahe(input_img3(:,:,2), 100, 0.01)/255;
new_img(:,:,3) = histogram_clahe(input_img3(:,:,3), 100, 0.01)/255;
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
save ../images/myImage4C-001.mat new_img;