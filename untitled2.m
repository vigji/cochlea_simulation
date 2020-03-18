%Problem Definition
%The following variables will define our problem:

%g: A specification function that is used by initmesh. For more information, please see the documentation pages for circleg and pdegeom.
%c, a, f: The coefficients and inhomogeneous term.
g = @circleg;
c = 1;
a = 0;
f = 1;

%Boundary Conditions
%Plot the geometry and display the edge labels for use in the boundary condition definition.
%pdegplot(g, 'edgeLabels', 'on');
%axis equal

% Create a PDE Model with a single dependent variable
numberOfPDE = 1;
pdem = createpde(numberOfPDE);
% Create a geometry entity
geometryFromEdges(pdem, g);
% Solution is zero at all four outer edges of the circle
applyBoundaryCondition(pdem,'Edge',(1:4), 'u', 0);


%Generate Initial Mesh
%The function initmesh takes a geometry specification function and returns a discretization of that domain. The 'hmax' option lets the user specify the maximum edge length. In this case, because the domain is a unit disk, a maximum edge length of one creates a coarse discretization.

[p,e,t] = initmesh(g,'hmax',1);
%figure
pdemesh(p,e,t);
axis equal


%Refinement
%We repeatedly refine the mesh until the infinity-norm of the error vector is less than a  $10^{-3}$.
%For this domain, each refinement halves the lengths of the edges of the triangles that compose the mesh. Note also that the error decreases by a factor of about one-third.
for i = 1:4
    [p,e,t] = refinemesh(g,p,e,t);
end



%Plot Final Mesh

%figure
pdemesh(p,e,t);
axis equal

u = assempde(pdem,p,e,t,c,a,f);

%Plot FEM Solution
figure
[ux,uy] = pdegrad(p,t,u);

v = linspace(-0.3,0.3,15);
[X,Y] = meshgrid(v);
quiver()
%[gradx,grady] = evaluateGradient(results,X,Y,[1,2]);
