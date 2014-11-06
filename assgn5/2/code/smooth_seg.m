function [I_mod, I_clust] = smooth_seg(I)

    [M N C] = size(I);
    [X Y] = meshgrid(1:M, 1:N);

     feature_vector = cat(3, X',Y',I(:,:,1),I(:,:,2),I(:,:,3));
     feature_vector_m = feature_vector;

     window_s = 23;
     window_s2 = 11;
     window = zeros(window_s, window_s, 5);
     window_reshape = zeros(window_s*window_s, 5);
     new_val = zeros(5,1);
     val1 = zeros(window_s*window_s, 1);
     val2 = zeros(window_s*window_s, 1);

     sp_sig = 12;
     in_sig = 20;

     small = 0.01;

     for i=1:M
         for j=1:N
            diff = 1000;
            new_val = reshape(feature_vector(i,j,:),1,5);
            while diff > small
                xt = round(new_val(1));
                yt = round(new_val(2));

                imin = max(1, xt-window_s2);
                jmin = max(1, yt-window_s2);
                imax = min(M, xt+window_s2);
                jmax = min(N, yt+window_s2);

                window = feature_vector(imin:imax, jmin:jmax,:);
                [m,n,c] = size(window);
                window_reshape = reshape(window, m*n, c);

                val1 = exp(-1*sum(bsxfun(@minus, window_reshape(:,1:2), new_val(1:2)).^2, 2)/(2*(sp_sig^2)));
                val2 = exp(-1*sum(bsxfun(@minus, window_reshape(:,3:5), new_val(3:5)).^2, 2)/(2*(in_sig^2)));
                val1 = val1.*val2;
                window_reshape = bsxfun(@times, window_reshape, val1);
                new_val = sum(window_reshape)/sum(val1);
                diff = sum((reshape(feature_vector_m(i,j,:),1,5)-new_val).^2,2);
                feature_vector_m(i,j,:) = new_val;

            end


         end
     end
     I_mod = cat(3, feature_vector_m(:,:,3),feature_vector_m(:,:,4),feature_vector_m(:,:,5));

     feature_vector = reshape(cat(3, X',Y',I_mod(:,:,1),I_mod(:,:,2),I_mod(:,:,3)), M*N, 5);

     K = 100;
     cluster_center = zeros(K, 5);
     cluster_mod = zeros(K,5);
     cluster_tmp = zeros(K,1);
     count = zeros(K,1);
     for k=1:K
         cluster_center(k,:) = feature_vector(round(rand(1)*(M*N-1))+1, :);
     end

     diff = 1000;
     small = 1;
     while diff > small
         count = zeros(K,1);
         cluster_mod = zeros(K,5);
         for i=1:M*N
             cluster_tmp = sum(bsxfun(@minus, cluster_center, feature_vector(i,:)).^2,2);
             [m,j] = min(cluster_tmp);
             cluster_mod(j,:) = cluster_mod(j,:) + feature_vector(i,:);
             count(j) = count(j)+1;
         end
         cluster_mod = bsxfun(@rdivide, cluster_mod, count);
         diff = sum(sum((cluster_mod-cluster_center).^2));
         cluster_center = cluster_mod;
     end

     I_clust = zeros(size(I));
     for i=1:M*N
         cluster_tmp = sum(bsxfun(@minus, cluster_center, feature_vector(i,:)).^2,2);
         [m,j] = min(cluster_tmp);
         feature_vector(i,3:5) = cluster_center(j,3:5);
         I_clust(feature_vector(i,1), feature_vector(i,2), :) = feature_vector(i,3:5);
     end

    myNumOfColors = 200;
    myColorScale = [ [0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]',[0:1/(myNumOfColors-1):1]'];

    figure, imagesc(linear_contrast_stretching(I));colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
    figure, imagesc(linear_contrast_stretching(I_mod));colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
    figure, imagesc(linear_contrast_stretching(I_clust));colormap(myColorScale);daspect ([1 1 1]); axis tight;colormap jet;colorbar;
end