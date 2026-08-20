
kD = 10; %hydraulic conductivity at reference level z=D
beta = 0.04; %decay exponent
L = 2000; %domain width
D=50; %aquifer thickness
%stream head specification:
a1 = -0.001;
b1 = 20;
a2 = -0.002;
b2 = 15;

y0 = 0; % specified y-coordinate for plotting head profile, h(x,y0)
xw=L/3; yw=0; %well position

Qw=180; %well discharge
R=0.0005; %recharge rate
%% x coordinates
x = linspace(0,L,500);
hline = tri2grid(p,t,u,x,y0); %evaluating FEM results along y=y0; 

%% Analytical discharge potential (Stream)
PhiS = (kD*exp(-beta*D)/beta^2) .* ( ...
      exp(beta*(a1*y0+b1)).*sin(beta*a1*(L-x))./sin(beta*a1*L) ...
    + exp(beta*(a2*y0+b2)).*sin(beta*a2*x)./sin(beta*a2*L) ...
    - beta*(a1*y0+b1).*(1-x/L) ...
    - beta*(a2*y0+b2).*x/L ...
    - 1 );
%% Analytical discharge potential (Well)
PhiW=Qw ./ pi .* log((cosh(pi ./ L .* (y0 - yw)) - cos(pi ./ L .* (x - xw))) ./ (cosh(pi ./ L .* (y0 - yw)) - cos(pi ./ L .* (x + xw)))) ./ 0.4e1;
%% Analytical discharge potential (Areal recharge)
PhiR=R.*x.*(L-x)./2;

%%total potential
Phi=PhiW+PhiS+PhiR;

%Computing head from potential
A = beta^2 .* Phi.*exp(beta*D) ./ (kD);
Head = -(1 + A + lambertw(-1,-exp(-(1+A)))) ./ beta;

%% Plot head versus x at y=y0
%figure
plot(x,Head,'LineWidth',1) %Analytical head
hold on;
plot(x(1:5:end),hline(1:5:end),'^') %FEM head
legend('Present, \beta=0.04 m^{-1}','FEM, \beta=0.04 m^{-1}')
xlabel('x [m]')
ylabel('h [m]')
grid on
box on