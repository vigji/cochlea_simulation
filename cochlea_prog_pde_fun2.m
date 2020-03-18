function [uxy] = cochlea_prog_pde_fun(omega)

pdem = createpde;

%Omega frequenza con cui forzo il contorno 1; serve anche alla funzione per
%il contorno della parete elastica

global omega_in;
omega_in = omega;
disp(omega_in);

%Lunghezza della scatola
len_y = 0.1;
len_x = 3.5;

%Parametro arbitrario: ampiezza della forzatura su x = 0
F = 1;

gdm = [3 4 0 len_x len_x 0 0 0 len_y len_y]';
g = decsg(gdm,'S1',('S1')');
% Create a geometry entity
geometryFromEdges(pdem,g);

% Plot the geometry and display the edge labels for use in the boundary
% condition definition.
%figure;
%pdegplot(pdem,'EdgeLabels','on');


[p,e,t] = initmesh(g,'hmax',0.01);
%View the mesh.
%pdeplot(pdem)

% Apply neumann boundary conditions 
% n*c*grad(u) + q*u = g  --n:outward unit normal
% Two static walls:
applyBoundaryCondition(pdem, 'Edge', 2,'g', 0,'q', 0);
applyBoundaryCondition(pdem, 'Edge', 3,'g', 0,'q', 0);
applyBoundaryCondition(pdem, 'Edge', 1,'g', 0,'q', @myfun_in1);
%applyBoundaryCondition(pdem, 'Edge', 4,'g', 1i*omega_in*F,'q', 0);
applyBoundaryCondition(pdem, 'Edge', 4,'g', @myfun_in2,'q', 0);


%applyBoundaryCondition(pdem,'neumann','Edge', e3,'g', 0,'q', 0);

%applyBoundaryCondition(pdem,'neumann','Edge', e1,'g', 0,'q', 0);
%applyBoundaryCondition(pdem,'neumann','Edge', e4,'g', 1,'q', 0);

% Specify equation 
% -div(c*grad(u)) + a*u = f
c = 1; a = 0; f = 0;
u = assempde(pdem,p,e,t,c,a,f);


time = 0.00001:0.00001:1;
phasor = exp(1i*omega_in*time);

y = 0.01:0.001:0.1;
x = 0.01:0.001:3.5;

uxy = tri2grid(p,t,u,x,y);


function term = myfun_in1(region, state)
global omega_in

x = region.x;

p = 1;
m_x = 0.05*ones(1,length(x)); %mass (kg/cm^3)
r_x = 3000*exp(-1.5*x);%damping (dyne*s/cm^3)
k_x = 10^7*exp(-1.5*x);%stiffness (dyne/cm^3)

z_x_omega = 1i*omega_in*m_x + r_x + k_x/(1i*omega_in);%

term = 1i*omega_in*p./z_x_omega;


function term = myfun_in2(region, state)
% 
y = region.y;
% 
F = 1;
% 
% y = sin
% 
term = sin(y*pi/0.1)*F;












