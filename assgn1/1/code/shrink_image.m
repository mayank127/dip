function out_img = shrink_image(d)
raw_img = imread('circles_concentric.png');
out_img = raw_img(1:d:end , 1:d:end);
