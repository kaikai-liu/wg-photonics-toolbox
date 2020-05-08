function [x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_D_shape(n,h,r_D,side,dx,dy)

% This function creates an index mesh for the finite-difference
% mode solver.  The function will create mesh for D-shape waveguide
% 
% USAGE:
% 
% [x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_D_shape(n,h,r,side,dx,dy)
%
% INPUT
%
% n - indices of refraction for core and cladding
% h - height of each layer in waveguide: h1 and h3 for cladding, h2 for core
% r - radius for D shape
% side - excess space to the right of waveguide
% dx - horizontal grid spacing
% dy - vertical grid spacing
% 
% OUTPUT
% 
% x,y - vectors specifying mesh coordinates
% xc,yc - vectors specifying grid-center coordinates
% nx,ny - size of index mesh
% eps - index mesh (n^2)
% edges - (optional) list of edge coordinates, to be used later
%   with the line() command to plot the waveguide edges
% iedges - index of edge coordinates on meshgrid
%
% AUTHOR:  Kaikai Liu

rw = sqrt(r_D^2-(r_D-h(2))^2);
ih = round(h/dy);
irw = round (2*rw/dx);
iside = round (side/dx);

nx = irw+2*iside+1;
ny = sum(ih)+1;

x = dx*(-(irw/2+iside):1:(irw/2+iside))';
xc = (x(1:nx-1) + x(2:nx))/2;

y = (0:(ny-1))*dy;
yc = (1:(ny-1))*dy - dy/2;

eps_co = n(1)^2;
eps_cl = n(2)^2;
eps = ones(nx-1,ny-1)*eps_cl;

% center of D circle
xO = 0;
yO = h(1)+h(2)-r_D;

[Yc,Xc] = meshgrid(yc,xc);
isin1 = (Xc-xO).^2+(Yc-yO).^2 - r_D^2<0; % if in circle
isin2 = Yc>h(1);                       % if above h1
eps(isin1 & isin2) = eps_co;

% raw edges
phi0 = acos((r_D-h(2))/r_D);
phi = linspace(-phi0,phi0,100) + pi/2;
edgeX = r_D*cos(phi) + xO;
edgeY = r_D*sin(phi) + yO;
edges{1,:} = [edgeX edgeX(1)];
edges{2,:} = [edgeY edgeY(1)];

% index edge coordinate on the meshgrid
ixco = find(abs(x)<rw)';
iyco = find(y>h(1) & y<h(1)+h(2));
eps1 = mean(n.^2);
for ii = 1:length(ixco)
    if isempty(find(eps(ixco(ii),:)>eps1)), ixco(ii) = 0; end
end
ixco(ixco==0) = [];
iy_D = zeros(size(ixco));
for ii = 1:length(ixco)
        iy_ii = find(eps(ixco(ii),:)>eps1);
        iy_D(ii) = max(iy_ii);
end

iedges{1,1} = ixco;
iedges{2,1} = iy_D - 1; % -1 to avoid Ex spikes
iedges{1,2} = ixco;
iedges{2,2} = iyco(1)*ones(size(ixco));

end