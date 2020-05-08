function [x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_rect(n,h,rw,side,dx,dy)

% This function creates an index mesh for the finite-difference
% mode solver.  The function will generate mesh for a rectangular
% waveguide based on "waveguidemeshfull.m".
% 
% USAGE:
% 
% [x,y,xc,yc,nx,ny,edges] = waveguidemesh_rect(n,h,rh,rw,side,dx,dy)
%
% INPUT
%
% n - indices of refraction for layers in waveguide
% h - height of each layer in waveguide
% rw - half-width of waveguide
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
% edges - list of edge coordinates, to be used later
%   with the line() command to plot the waveguide edges

[x,y,xc,yc,nx,ny,eps] = waveguidemeshfull(...
    n,h,h(2),rw,side,dx,dy);

% raw edges
edges{1,:} = [-rw rw rw -rw -rw];
edges{2,:} = [h(1) h(1) h(1)+h(2) h(1)+h(2) h(1)];

% index of edge coordinates on the meshgrid
[~,indx1] = min(abs(x+rw));
[~,indx2] = min(abs(x-rw));
[~,indy1] = min(abs(y-h(1)));
[~,indy2] = min(abs(y-(h(1)+h(2))));
iedges{1,1} = find(abs(x)<rw)';
iedges{2,1} = indy2*ones(1,indx2-indx1-1);
iedges{1,2} = find(abs(x)<rw)';
iedges{2,2} = indy1*ones(1,indx2-indx1-1);
iedges{1,3} = indx2*ones(1,indy2-indy1-1);
iedges{2,3} = find(y>h(1)&y<h(1)+h(2));
iedges{1,4} = indx1*ones(1,indy2-indy1-1);
iedges{2,4} = find(y>h(1)&y<h(1)+h(2));
end