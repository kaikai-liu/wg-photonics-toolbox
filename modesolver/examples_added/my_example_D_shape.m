% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of D shape waveguide

clear;
close all;

% geometry
width = 4;      	% D-shape width
% r_D = 8;       	% D circle radius
h_co = 0.3;     	% Core thickness
r_D = (h_co^2+(width/2)^2)/(2*h_co); % D circle radius
h_cl = 0.4;         % Lower cladding
side = 0.5;         % Space on side
dx = 10e-3;         % grid size (horizontal)
dy = 4e-3;          % grid size (vertical)

% wavelength
n_co = 2.0;         % core index
n_cl = 1.44;        % clad index
lambda = 1.55;      % vacuum wavelength
nmodes = 3;         % number of mode to compute

% Boundary conditions for antisymmetric mode
boundary = '0000';

[x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_D_shape(...
    [n_co n_cl],[h_cl h_co h_cl],r_D,side,dx,dy);

% undistorted stretch mesh
n_north = round(ny*h_cl/(2*h_cl+h_co)); 
n_east = round(nx*side/(width+2*side));
n_st = [n_north n_north n_east n_east];
[x,y,xc,yc,dx,dy] = stretchmesh(x,y,n_st,[5,5,5,5]);
[X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,boundary);

fprintf(1,'neff = %.6f\n',neff);
%%
for ii = 1:nmodes
    [Hz,Ex,Ey,Ez] = postprocess(lambda,neff(ii),Hx(:,:,ii),Hy(:,:,ii),dx,dy,eps,'0000');
    visualizemode(Ex,Ey,x,y,edges,neff(ii))
end

%%
% figure;
% linind = sub2ind(size(Ex),iedges{1,1},iedges{2,1}-1); hold on;
% plot(Ex(linind));