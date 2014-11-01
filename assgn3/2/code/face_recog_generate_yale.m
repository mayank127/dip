function PER = face_recog_generate_yale(K_array, dataset)
    N = 39;
    S = 2;
    X = zeros(N*S, 192*168);
    for i=1:N
        for j=1:S
            if i ~= 14
                if i <= 9
                    file = [dataset, '/CroppedYale_Subset/0' ,int2str(i), '/',int2str(j) , '.pgm'];
                else
                    file = [dataset, '/CroppedYale_Subset/' ,int2str(i), '/',int2str(j) , '.pgm'];
                end
                A = imread(file);
                X((i-1)*S+j, :) = (A(:)');
            end
        end
    end
    X = X';
    x_mean = mean(X,2);
    X = bsxfun(@minus, X, mean(X));
    L = X'*X;

    [W,D] = eig(L);
    V = X*W;
    V = bsxfun(@rdivide, V,(sqrt(sum(V.^2,1))));
    

    
    PER = zeros(size(K_array));
    p = 1;
    for k=K_array
        Vk = V(:, 1:k);
        alpha = Vk'*X;
        count = 0;
        N=39;
        S=3;
        for i=1:N
            for j=3:5
                if i ~= 14
                    if i <= 9
                        file = [dataset,'/CroppedYale_Subset/0' ,int2str(i), '/',int2str(j) , '.pgm'];
                    else
                        file = [dataset,'/CroppedYale_Subset/' ,int2str(i), '/',int2str(j) , '.pgm'];
                    end

                    A = double(imread(file));
                    A = A(:) - x_mean;
                    A = Vk' * A;
                    alpha_dist = bsxfun(@minus, alpha, A);
                    s = sum(alpha_dist.^2, 1);
                    idx = find(s==min(s));
                    if idx > (i-1)*2 & idx <= i*2
                        count = count + 1;
                    end
                end
            end
        end
        percent = count*100/((N-1)*S); % 14 is not present
        PER(p) = percent;
        p = p+1;
    end
    
