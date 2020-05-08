function [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh_fiber(n,r,side,dx,dy)

% This function creates an index mesh for the finite-difference
% mode solver.  The function will generate mesh for a rectangular
% waveguide based on "fiber.m".
%
% USAGE:
%
% [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh_fiber(n,r,side,dx,dy)
%
% INPUT
%
% n - indices of refraction for layers in fiber
% r - outer radius of each layer
% side - width of cladding layer to simulate
% dx - horizontal grid spacing
% dy - vertical grid spacing
%
% OUTPUT
%
% x,y - vectors specifying mesh coordinates
% xc,yc - vectors specifying grid-center coordinates
% nx,ny - size of index mesh
% eps - index mesh (n^2)
% edges - list of edge coordinates, to be used later
%   with the line() command to plot the waveguide edges

[x,y,xc,yc,nx,ny,eps] = fiber(n,r,side,dx,dy);

x = [flip(-x(2:end));x];
y = [flip(-y(2:end)) y];
xc = [flip(-xc);xc];
yc = [flip(-yc) yc];
eps = [flip(flip(eps,2),1) flip(eps,1); flip(eps,2) eps];

phi = linspace(0,2*pi,100);
for ii = 1:length(r)
    edges{1,ii} = r(ii)*cos(phi);
    edges{2,ii} = r(ii)*sin(phi);
end

end