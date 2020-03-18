pdem = createpde;

len_y = 0.1;
len_x = 3.5;
omega = 5000;
f = 0.01;

gdm = [3 4 0 len_x len_x 0 0 0 len_y len_y]';
g = decsg(gdm,'S1',('S1')');
% Create a geometry entity
geometryFromEdges(pdem,g);

% Plot the geometry and display the edge labels for use in the boundary
% condition definition.
%figure;
pdegplot(pdem,'EdgeLabels','on');
ylim([-1,11])
%axis equal
%title 'Geometry With Edge Labels Displayed';

[p,e,t] = initmesh(g,'hmax',0.005);
%View the mesh.
%pdeplot(pdem)

% Apply neumann boundary conditions 
% n*c*grad(u) + q*u = g  --n:outward unit normal

% Two static walls:
applyBoundaryCondition(pdem, 'Edge', 2,'g', 0,'q', 0);
applyBoundaryCondition(pdem, 'Edge', 3,'g', 0,'q', 0);
applyBoundaryCondition(pdem, 'Edge', 1,'g', @myfun,'q', 0);
applyBoundaryCondition(pdem, 'Edge', 4,'g', @myfun2,'q', 0);

%applyBoundaryCondition(pdem,'neumann','Edge', e3,'g', 0,'q', 0);

%applyBoundaryCondition(pdem,'neumann','Edge', e1,'g', 0,'q', 0);
%applyBoundaryCondition(pdem,'neumann','Edge', e4,'g', 1,'q', 0);

% Specify equation 
% -div(c*grad(u)) + a*u = f
c = 1; a = 0; f = 0;
u = assempde(pdem,p,e,t,c,a,f);
%pdeplot(pdem,'XYData',results.NodalSolution)

figure
%pdesurf(p,t,gradient(abs(u)));
[ux,uy] = pdegrad(p,t,abs(u));

time = 0.001:0.00001:1;
% omega = 800;

phasor = exp(1i*omega*time);

% for i = 1:200
%     [ux_m(:,:,i),uy_m(:,:,i)] = pdegrad(p,t,real((u*phasor(i))));
% end
% 
for i = 1:80
    a = pdeplot(p,e,t,'FlowData',[ux_m(:,:,i);uy_m(:,:,i)]);
    sel = a.YData == 0;
    
    grad_x(:,i) = a.XData(sel);
    grad2(:,i) = a.VData(sel);
    grad_y(:,i) = a.XData(sel);
    grad1(:,i) = a.VData(sel);
    
    xlim([0, 3.5])
    ylim([0, 0.1])
    %drawnow
end
% 
% for i = 1:80
%     pdesurf(p,t,real(u*phasor(i)));
%     drawnow
% end
% 
% 
% for i = 1:80
%     plot(grad1(:,i))
%     drawnow
% end
% 
y = 0.01:0.001:0.1;
x = 0.01:0.001:3.5;
uxy = tri2grid(p,t,u,x,y);
absuxy = abs(uxy*phasor(1));









