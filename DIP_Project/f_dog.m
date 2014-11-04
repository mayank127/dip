
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
    function val = my_ceil(v,lim)
        val = ceil(v);
        if val<1
            val=1;
        elseif val>lim
            val=lim;
        end 
    end
    function val = my_interp(A, x, y)
        x1 = my_floor(x,size(A,1));
        x2 = my_ceil(x,size(A,1));
        y1 = my_floor(y,size(A,2));
        y2 = my_ceil(y,size(A,2));
        
        
        val1 = A(x1,y1);
        val2 = A(x2,y2);
        val = (val1*((x-x1)^2+(y-y1)^2) + val2*((x-x2)^2+(y-2)^2)) /((x-x1)^2+(y-y1)^2+(x-x2)^2+(y-2)^2);
        if isnan(val)
            val = 0;
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
        for a=0:beta
            for i=1:M
                for j=1:N
                    if a==0
                        X(i,j) = i;
                        Xn(i,j) = i;
                        Y(i,j) = j;
                        Yn(i,j) = j;
                        Hg(i,j) = Hg(i,j) + dog(0, sig_c, sig_s, rho) * I_gray(X(i,j), Y(i,j));
                    else

                        in = my_interp(Tx, X(i,j),Y(i,j));
                        jn = my_interp(Ty, X(i,j),Y(i,j));

                        X(i,j) = X(i,j) - jn;
                        Y(i,j) = Y(i,j) + in;

                        in = my_interp(Tx, Xn(i,j),Yn(i,j));
                        jn = my_interp(Ty, Xn(i,j),Yn(i,j));    

                        Xn(i,j) = Xn(i,j) + jn;
                        Yn(i,j) = Yn(i,j) - in;

    %                     [i,j,X(i,j),Y(i,j),Xn(i,j),Yn(i,j)]
                        Hg(i,j) = Hg(i,j) + dog(a, sig_c, sig_s, rho) * (my_interp(I_gray, X(i,j),Y(i,j)) + my_interp(I_gray, Xn(i,j),Yn(i,j)));
                    end
                end
            end
        end

        He = zeros(M,N);
        for a=0:alpha
            for i=1:M
                for j=1:N
                    if a==0
                        X(i,j) = i;
                        Xn(i,j) = i;
                        Y(i,j) = j;
                        Yn(i,j) = j;
                        He(i,j) = He(i,j) + normpdf(0, 0, sig_m) * Hg(X(i,j), Y(i,j));
                    else
                        in = my_interp(Tx, X(i,j),Y(i,j));
                        jn = my_interp(Ty, X(i,j),Y(i,j));

                        X(i,j) = X(i,j) + in;
                        Y(i,j) = Y(i,j) + jn;

                        in = my_interp(Tx, Xn(i,j),Yn(i,j));
                        jn = my_interp(Ty, Xn(i,j),Yn(i,j));    

                        Xn(i,j) = Xn(i,j) - in;
                        Yn(i,j) = Yn(i,j) - jn;

                        He(i,j) = He(i,j) + normpdf(a,0,sig_m) * (my_interp(Hg, X(i,j),Y(i,j)) + my_interp(Hg, Xn(i,j),Yn(i,j)));
                    end
                end
            end
        end
        figure, imshow(Hg,[]);
        figure, imshow(He,[]);

        for i=1:M
            for j=1:N
                if(He(i,j)<0 && 1 + tanh(He(i,j))<tau)
                    edges(i,j) = 0;
                else
                    edges(i,j) = 1;
                end
            end
        end
        I_gray = I_gray + edges;
    end
end