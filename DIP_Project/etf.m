function [Tx, Ty] = etf(I_gray, mu, T_iter)

    [M,N] = size(I_gray);
    sobel_h = fspecial('sobel');
    Gy = imfilter(I_gray, sobel_h, 'conv');
    Gx = imfilter(I_gray, sobel_h', 'conv');
    Gmag = sqrt(Gy.^2 + Gx.^2);
    Gx = Gx./Gmag;
    Gy = Gy./Gmag;
    Gx(isnan(Gx))=0;
    Gy(isnan(Gy))=0;
    Gmag = Gmag/sqrt(sum(sum(Gmag.^2)));
    Tx = -Gy;
    Ty = Gx;
    
    

    % mu = 2; % User Defined - parameter
    % T_iter = 3;

    W = 2*mu+1;
    Ws = zeros(W,W); % center mu+1, mu+1
    Wm = zeros(W,W);
    Wd = zeros(W,W);
    patchX = zeros(W,W);
    patchY = zeros(W,W);
    Wspatch = zeros(W,W);
    for i=1:W
        for j=1:W
            rad = (mu+1-i)^2+(mu+1-j)^2;
            if(rad<=mu^2)
                Ws(i,j) = 1;
            end
        end
    end

    for t=1:T_iter
        for i=1:M
            for j=1:N
                imin = max(1, i-mu);
                imax = min(N, i+mu);
                jmin = max(1, j-mu);
                jmax = min(M, j+mu);

                imin2 = mu+1-(i-imin);
                jmin2 = mu+1-(j-jmin);
                imax2 = mu+1+(imax-i);
                jmax2 = mu+1+(jmax-j);


                patchX = Tx(imin:imax, jmin:jmax);
                patchY = Ty(imin:imax, jmin:jmax);

                Wspatch = Ws(imin2:imax2, jmin2:jmax2);
                Wm = abs(Gmag(imin:imax, jmin:jmax) - Gmag(i,j) + 1)/2;
                Wd = patchX*Tx(i,j) + patchY*Ty(i,j);

                patchX = patchX.*Wspatch.*Wm.*Wd;
                patchY = patchY.*Wspatch.*Wm.*Wd;

                % reusing Gx,Gy
                Gx(i,j) = sum(patchX(:));
                Gy(i,j) = sum(patchY(:));
                k = sqrt(Gx(i,j)^2 + Gy(i,j)^2);
                
                Gx(i,j) = Gx(i,j)/k;
                Gy(i,j) = Gy(i,j)/k;

            end
        end
        Gx(isnan(Gx))=0;
        Gy(isnan(Gy))=0;
        Tx = Gx;
        Ty = Gy;
    end