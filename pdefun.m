function [c,f,s] = pdefun(r,t,u,dudr)
% Parameters    
global k0 D beta Sy N Rb
 % Transmissivity   
T = k0*exp(-beta*D)/beta*(exp(beta*u)-1);
 % PDE coefficient 
c = Sy;
 % Radial flux function   
f = T*dudr;
% Source term 
s=0;
if r<Rb
s = N;
end
end