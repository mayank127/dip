function outImage = imageSharpening (inputImage,scale,sigma)


h = fspecial('gaussian',15,sigma);

outImage = linear_contrast_stretching(inputImage);
outImage = imfilter(outImage,h,'same','conv');


outImage  = 1 - outImage ;
outImage = scale*outImage;


outImage = outImage+inputImage;

outImage = linear_contrast_stretching(outImage);