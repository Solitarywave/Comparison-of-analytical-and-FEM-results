function h=inversePhi(Phi,kD,beta,D)

A=beta^2*exp(beta*D).*Phi/kD;

h=(-lambertw(-1,-exp(-(A+1)))...
   -(A+1))/beta;

end