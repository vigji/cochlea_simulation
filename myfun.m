function term = myfun(region, state, omega=5000)

x = region.x;

%x = 0.01:0.01:3.5
omega = 5000;


%for omega = 100:500:10000
p = 1
m_x = 0.05*ones(1,length(x)); %mass (kg/cm^3)
r_x = 3000*exp(-1.5*x);%damping (dyne*s/cm^3)
k_x = 10^7*exp(-1.5*x);%stiffness (dyne/cm^3)

z_x_omega = 1i*omega*m_x + r_x + k_x/(1i*omega);%

%term = 2./z_x_omega
%plot(abs(z_x_omega)/abs(z_x_omega(end)))
%hold on
%end

term = i*omega*p./z_x_omega;

