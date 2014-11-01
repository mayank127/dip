function [RMSD, ratio] = circular_filter(R)
    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

    I = load('boat.mat');
    I = I.imageOrig;

%     figure, imagesc(I);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;

    M = 512;
    N = 512;
    Y = fftshift(fft2(I, M, N));
    
    valI = sum(sum(abs(Y).^2));
    abs(Y(256,256))
    R2 = R^2;
    n = 2;
    B = zeros(M,N);
    for i=1:M
        for j=1:N
            D = (i-M/2)^2+(j-N/2)^2;
            if D <= R2
                B(i,j) = 1;
            else
                B(i,j) = 0;
            end
            
        end
    end


%     figure, imagesc(B);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;


    Y = B.*Y;
    valF = sum(sum(abs(Y).^2));
    ratio = valF/valI;
    I2 = ifft2(Y);
    I2 = abs(I2);
%     figure, imagesc(I2);colormap(myColorScale);daspect ([1 1 1]); axis tight;colorbar;
    RMSD = sqrt(sum(sum((I2-I).^2))/(512*512));
