function [disp, phasor, x] = cochlea_dw(omega)
% cochlea - deep water approx

t = 0.001:0.001:1;
% omega = 800;
x = 0:0.0001:3.5; %mm

phasor = exp(1i*omega*t);

m_x = 0.05*ones(1,length(x)); %mass (kg/cm^3)
r_x = 3000*exp(-1.5*x);%damping (dyne*s/cm^3)
k_x = 10^7*exp(-1.5*x);%stiffness (dyne/cm^3)

z_x_omega = 1i*omega*m_x + r_x + k_x/(1i*omega);%

1i*800*0.05 + 3000*exp(-1.5*x) + 10^7*exp(-1.5*x)

Y = 2./z_x_omega;
cumsumY = cumsum(Y);

d = 0.001;
disp0 = 10000;
disp = -1i*d*disp0*Y.*exp(-omega*d*cumsum(Y));
end


% for i = 1:100
%     
%     plot(x, real(disp*phasor(i)));
%     hold on
%     plot(x, abs(disp*phasor(i)), '-');
%     plot(x, -abs(disp*phasor(i)), '-');
%     hold off
%     ylim([-0.0035, 0.0035])
%     pause(0.05)
% end


%end

