 u1 = [0 0];
 u2 = [5 5];
 C1 = [2 0; 0 2];
 C2 = [2 1; 1 2];
 
 tot_points = 3000;
 p = zeros(tot_points, 2);
 for i=1:tot_points
     c = rand(1);
     if c<=0.4
         p(i,:) = mvnrnd(u1, C1);
     else
         p(i,:) = mvnrnd(u2, C2);
     end
 end
 
 sig = 2;
 val = zeros(tot_points,1);
 
 mod_p = zeros(tot_points, 2);
 mod_p_tmp = zeros(tot_points, 2);
 count = zeros(tot_points, 1);
 suff_small = 0.001;
 for i=1:tot_points
    diff = 1000;
    new_val = p(i,:);
    while diff > suff_small
        val = exp(-1*sum(bsxfun(@minus, p, new_val).^2, 2)/(2*(sig^2)));
        mod_p_tmp =  bsxfun(@times, p, val);
        new_val = sum(mod_p_tmp)/sum(val);
        diff = sum((mod_p(i,:)-new_val).^2,2);
        mod_p(i,:) = new_val;
        count(i) = count(i) + 1;
    end
 end
 
  scatter(p(:,1),p(:,2), 'b.'); hold on;  scatter(mod_p(:,1),mod_p(:,2),'r+');