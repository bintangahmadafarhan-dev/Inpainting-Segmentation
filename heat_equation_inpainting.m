
clear all; close all; clc;

Img = imread('new_original.png');
gg  = imread('new_mask.png');


figure(1); imshow(gg); colormap(gray)
figure(4); surf(double(gg)); colormap(gray); shading interp;

Img = double(Img(:,:,1));
maxI = max(max(Img));
Img = Img/maxI;

gg = double(gg);
gg = 1.0-gg/max(max(gg));

lambda = gg;
g=Img ;

[m,n]=size(g);
g=double(g);
g = g./max(max(g));
clims=[0 1];
%Parameters
h1=1;
h2=1;
T=150
dt=0.1;
lambda0=2;

lambda = lambda.*lambda0;
figure(1); imagesc(g, clims);  title('Damaged image ');
figure(2); surf(lambda); colormap(gray)

[row,col] = size(g);
%intialization of u:
u=g;
u1 = u;
% Explicit time stepping scheme for the heat equation
for t=1:T
    for i =1:row
        in = i+1;  is = i-1;         
        if (i == 1) 
            is = i;
        end        
         if (i == row) 
            in = i;
        end
        
        for j=1:col
            je = j+1; jw = j-1;
             if (j == 1) 
               jw = j;
             end
             if (j == col) 
               je = j;
             end
%            fprintf(' i = %4d ; j = %4d ; in = %4d ; is = %4d ; je = %4d ; jw = %4d \n',i,j,in,is,je,jw);  
             u1(i,j) = u(i,j)+dt*(u(in,j)+u(is,j)+u(i,je)+u(i,jw)-4.0*u(i,j)+lambda(i,j)*(g(i,j)-u(i,j)));
        end
    end
    
    u=u1;  

    figure(2);
    imagesc(u, clims), axis equal; axis off; colormap(gray)
    title(['Inpainted image as solution to heat equation after '...
        num2str(t) ' timesteps']);
    pause(0.01)
%     u(20,20)
end