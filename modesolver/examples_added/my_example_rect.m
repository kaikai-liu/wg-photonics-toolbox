% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.

clear;
close all;

% Refractive indices:
n_cl = 1.44;          % Lower cladding
n_co = 2.0;           % Core

% Layer heights:
h1 = 0.5;           % Lower cladding
h2 = 0.04;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions
rw = 9/2;           % Ridge half-width
side = 0.5;         % Space on side

% Grid size:
dx = 10e-3;         % grid size (horizontal)
dy = 5e-3;          % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 2;         % number of modes to compute

% primitive mesh
[x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_rect(...
    [n_cl,n_co,n_cl],[h1,h2,h3],rw,side,dx,dy);

% undistorted stretch mesh
n_north = round(ny*h1/(h1+h2+h3)); 
n_east = round(nx*side/rw/2);
n_st = [n_north n_north n_east n_east];
[x,y,xc,yc,dx,dy] = stretchmesh(x,y,n_st,[5,5,5,5]);
[X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,'0000');

fprintf(1,'neff = %.6f\n',neff);

%%
for ii = 1:nmodes
    [Hz,Ex,Ey,Ez] = postprocess(lambda,neff(ii),Hx(:,:,ii),Hy(:,:,ii),dx,dy,eps,'0000');
    figure;
    colormap(jet(256));
    
    subplot(121);
    imagemode(x,y,Ex);
    title(['Ex (for TE mode) neff=' num2str(neff(ii),'%.5f')]); xlabel('x(\mum)'); ylabel('y(\mum)');
    line(edges{:});
    
    subplot(122);
    imagemode(x,y,Ey);
    title(['Ex (for TE mode) neff=' num2str(neff(ii),'%.5f')]); xlabel('x(\mum)'); ylabel('y(\mum)');
    line(edges{:});
end

%%
subplot(121);
for v = iedges, line(x(v{1})',y(v{2}));  end