%Cochlea model

sigma = 1/35;

x = 0:0.0001:1; %mm
y = 0:0.0001:sigma; %mm
[X,Y] = meshgrid(x,y);
omega = 4000;

m_x = 0.05*ones(1,length(x)); %mass (kg/cm^3)
r_x = 3000*exp(-1.5*x);%damping (dyne*s/cm^3)
k_x = 10^7*exp(-1.5*x);%stiffness (dyne/cm^3)

z_x_omega = 1i*omega*m_x + r_x + k_x/(1i*omega);%

n = 0:100;
m = n;
[N, M, X2] = meshgrid(n,m, x);
Z = permute(repmat(z_x_omega', 1, 101,101), [3 2 1]);

[M2, X3] = meshgrid(x, m);
Z2 = repmat(z_x_omega, 101, 1);

alpha_nm = cosh(N(:,:,1)*pi*sigma).*sum( (cos(pi*N.*X2).*cos(pi*M.*X2))./Z, 3) + ...
    (1/4)*pi*N(:,:,1).*(M(:,:,1) == N(:,:,1));
f_m = sum( X3.*(1-1/2*X3).*cos(pi*M2.*X3)./Z2 ,2);
f_m(1) = f_m(1) + 1/2*sigma;

An = inv(alpha_nm)*f_m;

sum_term = zeros(size(X));


third_term = zeros(size(X));
for i = 1:length(n)
    third_term = third_term + An(i)*cosh(i*pi*(sigma-Y)).*cos(i*pi*X);
end
phi = X.*(1-1/2*X) - sigma*Y.*(1-1/(2*sigma).*Y) + third_term;

t = 0.001:0.1:1;
phasor = exp(1i*omega*t);


for i = 1:10
    phi_t = phi*phasor(i);
    disp = real(phi_t(1,:)) - real(phi_t(2,:));
    disp(1)
    plot(disp);
    hold on
end



