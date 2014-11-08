
function [edges, He, Hg] = f_dog(I_gray, Tx, Ty, rho, sig_m, sig_c, tau, iter)
    function val = dog(t, sig_c, sig_s, rho)
        val = normpdf(t, 0, sig_c) - rho * normpdf(t, 0, sig_s);
    end
    function val = my_floor(v,lim)
        val = floor(v);
        if val<1
            val=1;
        elseif val>lim
            val=lim;
        end 
    end

    
    for it=1:iter
        [M,N] = size(I_gray);
        
        edges = zeros(M,N);
        sig_s = 1.6*sig_c;
        beta = ceil(3*sig_s);
        alpha = ceil(3*sig_m);
        Hg = zeros(M,N);
        X = zeros(M,N);
        Xn = zeros(M,N);
        Y = zeros(M,N);
        Yn = zeros(M,N);
        
        DoG = dog(0:beta, sig_c,sig_s, rho);
        for a=0:beta
            for i=1:M
                for j=1:N
                    if a==0
                        X(i,j) = i;
                        Xn(i,j) = i;
                        Y(i,j) = j;
                        Yn(i,j) = j;
                        Hg(i,j) = Hg(i,j) + DoG(a+1) * I_gray(X(i,j), Y(i,j));
                        in = i;
                        jn = j;
                        inn = i;
                        jnn = j;
                    else
                        X(i,j) = X(i,j) - Ty(in,jn);
                        Y(i,j) = Y(i,j) + Tx(in,jn);
                        
                        in = my_floor(X(i,j),M);
                        jn = my_floor(Y(i,j),N);


                        Xn(i,j) = Xn(i,j) + Ty(inn,jnn);
                        Yn(i,j) = Yn(i,j) - Tx(inn,jnn);
                        
                        inn = my_floor(Xn(i,j),M);
                        jnn = my_floor(Yn(i,j),N);

                        Hg(i,j) = Hg(i,j) + DoG(a+1) * (I_gray(in,jn) + I_gray(inn,jnn));
                    end
                end
            end
        end

        He = zeros(M,N);
        
        G = normpdf(0:alpha, 0,sig_m);
        for a=0:alpha
            for i=1:M
                for j=1:N
                    if a==0
                        X(i,j) = i;
                        Xn(i,j) = i;
                        Y(i,j) = j;
                        Yn(i,j) = j;
                        He(i,j) = He(i,j) + G(a+1) * Hg(X(i,j), Y(i,j));
                        in = i;
                        jn = j;
                        inn = i;
                        jnn = j;
                    else
                        X(i,j) = X(i,j) + Tx(in,jn);
                        Y(i,j) = Y(i,j) + Ty(in,jn);
                        
                        in = my_floor(X(i,j),M);
                        jn = my_floor(Y(i,j),N);


                        Xn(i,j) = Xn(i,j) - Tx(inn,jnn);
                        Yn(i,j) = Yn(i,j) - Ty(inn,jnn);
                        
                        inn = my_floor(Xn(i,j),M);
                        jnn = my_floor(Yn(i,j),N);

                        He(i,j) = He(i,j) + G(a+1) * (Hg(in,jn) + Hg(inn,jnn));
                    end
                end
            end
        end
%         figure, imshow(Hg,[]);
%         figure, imshow(He,[]);

        MAX = max(1 + tanh(He(:)))
        for i=1:M
            for j=1:N
                if(He(i,j)<0 && 1 + tanh(He(i,j))<tau)
                    edges(i,j) = 0;
                else
                    edges(i,j) = 1;
                end
            end
        end
        I_gray = I_gray .* edges;
    end
end