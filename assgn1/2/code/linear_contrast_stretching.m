function new_img = linear_contrast_stretching(raw_img)
min_intensity = min(raw_img(:));
max_intensity = max(raw_img(:));

new_img = ( raw_img - min_intensity )  * 255/ (max_intensity - min_intensity);
