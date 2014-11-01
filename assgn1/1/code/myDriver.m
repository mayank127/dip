myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

new_img = shrink_image(2);

imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImageA.mat new_img;

new_img = shrink_image(3);
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImageB.mat new_img;

new_img = bilinear_zoom();
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImageC.mat new_img;

new_img = nearest_nbr_zoom();
imagesc(new_img);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
save ../images/myImageD.mat new_img;