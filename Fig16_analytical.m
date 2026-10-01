clear all; clc; 

%% Parameters


R = 50; %radius of recharge basin
beta = 0.05;
Depth = 50;
N   = 0.1;      % recharge rate [m/second]
L   = 500;       % strip width [m]
kD = 10;         % hydraulic conductivity [m/second]
Sy   = 0.35;       % specific yield [-]
h0  = 40;        % initial saturated thickness [m]
tt=[10 50 100 200 300 1000]; %times to plot head profiles
M=80; %Number of series terms retained




%% Background head and potential

Phi_0 = kD*exp(-beta*Depth)/beta^2 * ...
       (exp(beta*h0)-beta*h0-1);

r = linspace(0,L,300);

tol=1e-8;

maxIter=50;


h_old0=h0; 
h_old=h0;
Phi_old=Phi_0;



alpha = besselzero(0,M,1);
for jj=1:size(tt,2)
t=tt(jj);


for iter=1:maxIter

depi=0.5*(mean(h_old0)+mean(h_old));
Tmean=kD*exp(-beta*Depth)/beta .*(exp(beta*depi)-1);
D=Tmean/Sy;

Phi =0;
for n = 1:M

    an = alpha(n);
    lambda = an/L;

    coef = 2*N*R*L ...
        *besselj(1,an*R/L) ...
        /(an^3*besselj(1,an)^2);

    Phi = Phi + coef ...
        *(1-exp(-D*lambda^2*t)) ...
        *besselj(0,lambda*r);

end

    %% total Girinskii potential

     Phi_new = Phi+Phi_0;
 
%     %% inverse transformation
 
     h_new=inversePhi(Phi_new,kD,beta,Depth);

%
    zz=(Phi_new-Phi_old)/Phi_new;
    err=max(abs(zz));
    fprintf('iteration %d error %.3e\n',iter,err)
 
      if err<tol
          DD(jj)=D; 
          break
      end
 
     h_old=h_new;
     Phi_old=Phi_new;
 
 end

% figure

h_total=inversePhi(Phi_new,kD,beta,Depth);

hold on;
 plot(r,h_total);grid on;
xlabel('r [m]')
ylabel('h(r,t) [m]')


end
