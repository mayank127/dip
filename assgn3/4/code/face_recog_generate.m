function data = face_recog_generate(K, dataset)
    N = 35;
    S = 5;
    X = zeros(N*S, 92*112);
    for i=1:N
        for j=1:S
            file = [dataset, '/att_faces/s' ,int2str(i), '/',int2str(j) , '.pgm'];
            A = imread(file);
            X((i-1)*S+j, :) = (A(:)');
        end
    end
    X = X';
    x_mean = mean(X,2);
    X = bsxfun(@minus, X, mean(X));
    L = X'*X;

    [W,D] = eig(L);
    V = X*W;
    V = bsxfun(@rdivide, V,(sqrt(sum(V.^2,1))));
    

    
    k = K;
    Vk = V(:, 1:k);
    alpha = Vk'*X;
    count = 0;
    N=40;
    data = zeros(N, 10, 2);
    for i=1:N
        for j=1:10
            file = [dataset,'/att_faces/s' ,int2str(i), '/',int2str(j) , '.pgm'];
            A = double(imread(file));
            A = A(:) - x_mean;
            A = Vk' * A;
            alpha_dist = bsxfun(@minus, alpha, A);
            s = sum(alpha_dist.^2, 1);
            idx = find(s==min(s));
            data(i,j,:) = [min(s),ceil(idx/5)];

        end
    end

    