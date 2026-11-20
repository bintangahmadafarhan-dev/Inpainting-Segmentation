function [C]=myconv2(A,B)
  %
  %  C = myconv2(A, B) performs the 2-D convolution of matrices A and B.
  %  Returns the central part of the convolution of the same size as A.
  %  If [ma,na] = size(A), and[mb,nb] = size(B), then  size(C)= size(A)
  %  B must be a square matrice, i.e mb=nb (odd number), kernelR is the
  %  radius of B, kernelR = (mb-1)/2;
  %
  
    [ma,na] = size(A);
    [mb,nb] = size(B);
    if (mb ~= nb) 
        disp(' Matrice B is not square, break !');
        return; end;
    C=zeros(ma,na);
    kernelR = (mb-1)/2;
    for j = 1:ma
        for  i = 1:na      
            sum = 0;
            for k = -kernelR:kernelR
                jk=j+k;
                 if (jk > 0) && (jk <= ma)                 
                    for l = -kernelR:kernelR
                      il = i + l;
                        if (il > 0) && (il <= na)                
                          sum = sum + A(jk,il) * B(kernelR+k+1,kernelR+l+1);             
                          C(j,i) = sum;
                        end; % end of if (il > 0) && (il < N)  
                    end; % end of l
                 end;   % end of if (jk > 0) && (jk < N)         
             end;    % end of k
             end;    % end of i
             end;    % end of j
 
             