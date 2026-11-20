function [phi,f1,f2,Hphi] = myLIF_2D(I,phi,timestep,epsilon,K)

phi = NeumannBoundCond(phi);
  
Hphi = Heaviside(phi,epsilon);
DiracPhi = Delta(phi,epsilon);

[f1,f2] = Local_Avr(I,Hphi,K);

%whos I f1 Hphi f2 
phi = phi + timestep*DiracPhi.*((I - f1.*Hphi - f2.*(1 - Hphi)).*(f1 - f2));





function H = Heaviside(phi,epsilon)
H = 0.5*(1+(2/pi)*atan(phi./epsilon));



function Delta_h = Delta(phi,epsilon)
Delta_h = (epsilon/pi)./(epsilon^2+phi.^2);



function [f1,f2] = Local_Avr(I,H,K)

% f1 = conv2(I.*H,K,'same');
% c1 = conv2(H,K,'same');

f1 = myconv2(I.*H,K);
c1 = myconv2(H,K);

f1 = f1./c1;
% f2 = conv2(I.*(1-H),K,'same');
% c2 = conv2(1-H,K,'same');

f2 = myconv2(I.*(1-H),K);
c2 = myconv2(1-H,K);

f2 = f2./c2;
%whos f1 f2 H K I



function g = NeumannBoundCond(f)
% Make a function satisfy Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);