function [disp, phasor, x] = cochlea_dw(omega)
% Function that gives displacement of the cochlea model given frequency of oscillation 
% cochlea - deep water approx

dt = 0.001;
t = dt:dt:1;  % oscillation time
x = 0:0.0001:3.5; % basilar membrane x, in mm

phasor = exp(1i*omega*t);

m_x = 0.05*ones(1,length(x)); % mass (kg/cm^3)
r_x = 3000*exp(-1.5*x); % damping (dyne*s/cm^3)
k_x = 10^7*exp(-1.5*x); % stiffness (dyne/cm^3)
disp0 = 10000;  

z_x_omega = 1i*omega*m_x + r_x + k_x/(1i*omega);%

Y = 2./z_x_omega;

disp = -1i*dt*disp0*Y.*exp(-omega*dt*cumsum(Y));
end