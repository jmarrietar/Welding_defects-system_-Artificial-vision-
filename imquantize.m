function B = imquantize( A, k ) 
%
%
% 
B = A ; 
[m,n,p] = size(A); 
B(k+1:m,:,:) = 0; 
B(:,k+1:n,:) = 0; 
return 