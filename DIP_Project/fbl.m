function [smooth] = fbl(I_orig , Tx, Ty, sig_e, r_e, sig_g, r_g, iter)

    [M, N, C] = size(I_orig)
    smooth = zeros(M,N,C);
    
    function val = my_floor(v,lim)
        val = floor(v);
        if val<1
            val=1;
        elseif val>lim
            val=lim;
        end 
    end

    
    function val = color_gaus(I, i, j, x, y, r)
        V = I(i,j,:) - I(x,y,:);
        val = normpdf(sqrt(sum(V.^2)),0,r);
    end

    for it=1:iter
        beta = ceil(3*sig_g);
        alpha = ceil(3*sig_e);
        
        X = zeros(M,N);
        Xn = zeros(M,N);
        Y = zeros(M,N);
        Yn = zeros(M,N);
        Ce = zeros(M,N,C);
        ve = zeros(M,N);
        for a=0:alpha
            for i=1:M
                for j=1:N
                    if a==0
                        X(i,j) = i;
                        Xn(i,j) = i;
                        Y(i,j) = j;
                        Yn(i,j) = j;
                        val = normpdf(0, 0, sig_e) * color_gaus(I_orig, i, j, X(i,j), Y(i,j), r_e);
                        ve(i,j) = ve(i,j) + val;
                        
                        Ce(i,j,:) = Ce(i,j,:) + val*I_orig(X(i,j),Y(i,j),:);
                        
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
                        
                        val = normpdf(a, 0, sig_e) * color_gaus(I_orig, i, j, in, jn, r_e);
                        valn = normpdf(a, 0, sig_e) * color_gaus(I_orig, i, j, inn, jnn, r_e);
                        ve(i,j) = ve(i,j) + val + valn;
                        
                        
                        Ce(i,j,:) = Ce(i,j,:) + val * I_orig(in,jn,:);
                        Ce(i,j,:) = Ce(i,j,:) + valn * I_orig(inn,jnn,:);
                        
                    end
                end
                i
            end
        end
        for c=1:C
            Ce(:,:,c) = Ce(:,:,c)./ve;
        end
        Cg = zeros(M,N,C);
        ve = zeros(M,N);
        for a=0:beta
            for i=1:M
                for j=1:N
                    if a==0
                        X(i,j) = i;
                        Xn(i,j) = i;
                        Y(i,j) = j;
                        Yn(i,j) = j;
                        val = normpdf(0, 0, sig_g) * color_gaus(Ce, i, j, X(i,j), Y(i,j), r_g);
                        ve(i,j) = ve(i,j) + val;
                        Cg(i,j,:) = Cg(i,j,:) + val*Ce(X(i,j),Y(i,j),:);
                        
                        in = i;
                        jn = j;
                        inn = i;
                        jnn = j;
                    else
                        X(i,j) = X(i,j) + Ty(in,jn);
                        Y(i,j) = Y(i,j) - Tx(in,jn);
                        
                        in = my_floor(X(i,j),M);
                        jn = my_floor(Y(i,j),N);


                        Xn(i,j) = Xn(i,j) - Ty(inn,jnn);
                        Yn(i,j) = Yn(i,j) + Tx(inn,jnn);
                        
                        inn = my_floor(Xn(i,j),M);
                        jnn = my_floor(Yn(i,j),N);
                        
                        val = normpdf(a, 0, sig_g) * color_gaus(Ce, i, j, in, jn, r_g);
                        valn = normpdf(a, 0, sig_g) * color_gaus(Ce, i, j, inn, jnn, r_g);
                        ve(i,j) = ve(i,j) + val + valn;
                        
                        Cg(i,j,:) = Cg(i,j,:) + val * Ce(in,jn,:);
                        Cg(i,j,:) = Cg(i,j,:) + valn * Ce(inn,jnn,:);
                        
                    end
                end
                i
            end
        end
        for c=1:C
            Cg(:,:,c) = Cg(:,:,c)./ve;
        end
        I_orig = Cg;
    end
    smooth = I_orig;
    
end