% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.

clear;
close all;

% geometry
width = 2.5;        % waveguide width
h_co = 0.73;        % Core thickness
h_cl = 1.0;         % Cladding thichness
side = 1.0;         % Space on side
dx = 20e-3;         % grid size (horizontal)
dy = 10e-3;         % grid size (vertical)

% wavelength
n_cl = 1.4431;      % Cladding index
n_co = 1.9963;      % Core index
lambda = 1.55;      % vacuum wavelength
nmodes = 3;         % number of mode to compute

% primitive mesh
[x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_rect(...
    [n_cl,n_co,n_cl],[h_cl,h_co,h_cl],width/2,side,dx,dy);

% undistorted stretch mesh
n_north = round(ny*h_cl/(2*h_cl+h_co)); 
n_east = round(nx*side/(width+2*side));
n_st = [n_north n_north n_east n_east];
[x,y,xc,yc,dx,dy] = stretchmesh(x,y,n_st,[3,3,3,3]);
[X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,'0000');

fprintf(1,'neff = %.6f\n',neff);

%%
for ii = 1:nmodes
    [Hz,Ex,Ey,Ez] = postprocess(lambda,neff(ii),Hx(:,:,ii),Hy(:,:,ii),dx,dy,eps,'0000');
    visualizemode(Ex,Ey,x,y,edges,neff(ii))
end

%%
% subplot(121);
% for v = iedges, line(x(v{1})',y(v{2}));  end