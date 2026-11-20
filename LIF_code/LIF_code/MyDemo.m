% This Matlab file demomstrates a level set algorithm based on Kaihua Zhang et al's paper:
%    "Active contours driven by local image fitting energy" published by pattern recognition (2009)
% Author: Kaihua Zhang, all rights reserved
% E-mail: zhkhua@mail.ustc.edu.cn 
% http://www4.comp.polyu.edu.hk/~cslzhang/
%  Notes:
%   1. Some parameters may need to be modified for different types of images. Please contact the author if any problem regarding the choice of parameters.
%   2. Intial contour should be set properly.

% Date: 3/11/2009

clear all;close all;clc;
%Img = imread('ct_scan.bmp');

Img = imread('1.bmp');
Img = double(Img(:,:,1));
sigma =10;% the key parameter which needs to be tuned properly.
sigma_phi = .5;% the variance of regularized Gaussian kernel
% K = fspecial('gaussian',2*round(2*sigma)+1,sigma);
% K_phi = fspecial('gaussian',5,sigma_phi);

K = mygauss2D(2*round(2*sigma)+1,sigma);
K_phi = mygauss2D(5,sigma_phi);

[nrow,ncol] = size(Img);

% phi = ones(nrow,ncol);
% r   = 25;
% phi(r:nrow-r,r:ncol-r) = -1;
ic = nrow/2;jc = ncol/2; r = 25;
phi= sdf2circle(nrow,ncol,ic,jc,r);
 
figure;  imagesc(Img,[0 255]);colormap(gray);hold on;
contour(phi,[0 0],'b');

timestep = .005;
epsilon = 1;

for n = 1:400  
    
      [phi,f1,f2,Hphi]= myLIF_2D(Img,phi,timestep,epsilon,K);
      %phi = conv2(phi,K_phi,'same');
      phi = myconv2(phi,K_phi);
      if mod(n,10) == 0
       pause(0.0001);
      imagesc(Img,[0 255]);colormap(gray); axis equal;
      hold on;contour(phi,[0 0],'b');
      iterNum=[num2str(n), ' iterations'];        
      title(iterNum);        
      hold off;
      fprintf(' iterations = %4d\n ',n);
      end
end

figure;
mesh(phi);