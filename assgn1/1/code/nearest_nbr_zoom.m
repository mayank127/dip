function new_img = nearest_nbr_zoom()
raw_img = double(imread('barbaraSmall.png'));
[m,n] = size(raw_img);
M = 3*m-2;
N = 2*n-1;
new_img = zeros(M,N);

for i = 1:m-1
  for j = 1:n-1
      
      newM = 3*i-2;
      newN = 2*j-1;
      
      Q11 = raw_img(i,j);
      Q12 = raw_img(i,j+1);
      Q21 = raw_img(i+1,j);
      Q22 = raw_img(i+1,j+1);
      
      
      for k = 0:3
        if k < 2
            q11 = Q11;
            q12 = Q12;
        else
            q11 = Q21;
            q12 = Q22;
        end
        
        
        new_img(k+newM, newN) = q11;
        new_img(k+newM, newN+1) = q11;
        new_img(k+newM, newN+2) = q12;
      end 
  end
end