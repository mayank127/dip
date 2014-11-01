function done = face_recon(K_array, recons, dataset)
    N = 35;
    S = 5;
    X = zeros(N*S, 92*112);
    R = recons*S;
    for i=1:N
        for j=1:S
            file = [dataset, '/att_faces/s' ,int2str(i), '/',int2str(j) , '.pgm'];
            A = imread(file);
            X((i-1)*S+j, :) = (A(:)');
        end
    end
    X = X';
    Xr = X(:, R:R);
    x_mean = mean(X,2);
    X = bsxfun(@minus, X, mean(X));
    L = X'*X;

    [W,D] = eig(L);
    V = X*W;
    V = bsxfun(@rdivide, V,(sqrt(sum(V.^2,1))));
    
    count = 1;
    for k=K_array
        Vk = V(:, 1:k);
        alpha_r = Vk'*Xr;
        Xn = Vk*alpha_r + x_mean;
        Xn = vec2mat(Xn, 112);
        subplot(4,3,count), imshow(Xn', []), title(int2str(k));
        count = count + 1;
    end
    Xn = vec2mat(Xr, 112);
    subplot(4,3,count+1), imshow(Xn', []), title('Original');
    
    
    figure;
    for i=1:25
        E = V(:, i);
        Vn = vec2mat(E, 112);
        subplot(5,5,i), imshow(Vn', []), title(int2str(i));
    end
    figure;
    for i=1:25
        E = V(:, i);
        Vn = vec2mat(E, 112);
        Vn = log(1 + abs(fftshift(fft2(Vn'))));
        
        subplot(5,5,i), imshow(Vn, []), title(int2str(i));
    end
    
    done = true;
