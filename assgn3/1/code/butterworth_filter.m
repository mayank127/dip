function RMSD = butterworth_filter(D0)
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

    I = load('boat.mat');
    I = I.imageOrig;
    maxI = max(I(:));
    minI = min(I(:));
    I2 = randn(size(I))*0.1*(maxI-minI);

    I2 = I + I2;
    figure, imagesc(I);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
    figure, imagesc(I2);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;

    M = 512;
    N = 512;
    Y = fftshift(fft2(I2, M, N));
    D02 = D0^2;
    n = 2;
    B = zeros(M,N);
    for i=1:M
        for j=1:N
            D = (i-M/2)^2+(j-N/2)^2;
            B(i,j) = 1./(1+ (D/D02)^(n));
        end
    end


    figure, imagesc(B);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;


    Y = B.*Y;
    I2 = ifft2(Y);
    I2 = abs(I2);
    figure, imagesc(I2);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
    RMSD = sqrt(sum(sum((I2-I).^2))/(512*512));
