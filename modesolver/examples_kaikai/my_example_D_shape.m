% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of D shape waveguide

clear;
close all;

% Refractive indices
n_co = 2.0;               % core index
n_cl = 1.44;              % clad index

% Layer heights
h1 = 0.4;                 % Lower cladding
h2 = 0.2;                 % Core thickness
h3 = 0.4;                 % Upper cladding

r_D = 8;                  % D circle radius
side = 0.5;               % Space on side

% Grid size:
dx = 10e-3;               % grid size (horizontal)
dy = 5e-3;               % grid size (vertical)

lambda = 1.55;            % vacuum wavelength
nmodes = 1;               % number of modes to compute

% Boundary conditions for antisymmetric mode
boundary = '0000';

[x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_D_shape(...
    [n_co n_cl],[h1 h2 h3],r_D,side,dx,dy);

% undistorted stretch mesh
n_north = round(ny*h1/(h1+h2+h3)); 
n_east = round(nx*side/max(x)/2);
n_st = [n_north n_north n_east n_east];
[x,y,xc,yc,dx,dy] = stretchmesh(x,y,n_st,[5,5,5,5]);
[X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,boundary);

fprintf(1,'neff = %.6f\n',neff);
%%
for ii = 1:nmodes
    [Hz,Ex,Ey,Ez] = postprocess(lambda,neff(ii),Hx(:,:,ii),Hy(:,:,ii),dx,dy,eps,boundary);
    figure;
    colormap(jet(256));
    
    subplot(121);
    imagemode(x,y,Ex);
    title('Ex (TE/TM mode)'); xlabel('x'); ylabel('y');
    line(edges{:});
    
    subplot(122);
    imagemode(x,y,Ey);
    title('Ey (TE/TM mode)'); xlabel('x'); ylabel('y');
    line(edges{:});
end

%%
% figure;
% linind = sub2ind(size(Ex),iedges{1,1},iedges{2,1}-1); hold on;
% plot(Ex(linind));