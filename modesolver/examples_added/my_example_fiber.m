% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer fiber waveguide.

clear;
close all;

% Refractive indices:
n_co = 2.5;         % core index
n_cl = 1.5;         % clad index

% Layers
r = 0.3;            % core radius
side = 0.7;

% Grid size:
dx = 10e-3;         % grid size (horizontal)
dy = 10e-3;         % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 2;         % number of modes to compute

% Boundary conditions for antisymmetric mode
boundary = '0000';

% waveguide mesh
% [x,y,xc,yc,nx,ny,eps,edges] = fiber1([n_co n_cl],[r],side,dx,dy);
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh_fiber([n_co n_cl],[r],side,dx,dy);

% stretch mesh
% [x,y,xc,yc,dx,dy] = stretchmesh(x,y,[40,40,40,40],[4,4,4,4]);
% [X Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,boundary);

fprintf(1,'neff = %.6f\n',neff);

%%
for ii = 1:nmodes
    [Hz,Ex,Ey,Ez] = postprocess(lambda,neff(ii),Hx(:,:,ii),Hy(:,:,ii),dx,dy,eps,'0000');
    visualizemode(Ex,Ey,x,y,edges,neff(ii))
end