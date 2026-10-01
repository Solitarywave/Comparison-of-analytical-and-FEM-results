clear
clc
global k0 D beta Sy N h0 Rb

k0 = 10; %hydraulic conductivity at z=D
D = 50;
beta = 0.05; %decay exponent m^-1
Sy = 0.35;
N = 0.1; %recharge rate m/d
h0=40;   %initial head m
Rb=50; %radius of recharge basin m
Ro = 500; % outer radius, m
tEnd= 10; %time to plot numerical head profile

%% Spatial and temporal grids
r = linspace(0,Ro,201);
t = linspace(0,tEnd,101);
%% PDE solution
m = 1; % cylindrical/axisymmetric geometry
sol = pdepe(m,@pdefun,@icfun,@bcfun,r,t);
h = sol(:,:,1);

%% ============================================================% Plot head profiles% =============================================================
figure
hold on

nplot=101;
for i = 1:length(nplot)
    plot(r(1:10:end),h(nplot(i),1:10:end),'s')
end
xlabel('r (m)')
ylabel('h (m)')
grid on
box on
