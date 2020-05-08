
clear;
close all;

%% input
% input_Si_SiO2clad_1;
% input_Si_SiO2clad_2;
% input_SiN_SiO2clad;
% input_SiN_SiO2clad_9000by40
input_SiN_SiO2clad_2500by730;
% input_SiN_SiO2clad_1500by800;

%% mode field
% primitive mesh
[x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_rect(...
    [n_cl,n_co,n_cl],[h_cl,h_co,h_cl],width/2,side,dx,dy);

% undistorted stretch mesh
n_north = round(ny*h_cl/(2*h_cl+h_co)); 
n_east = round(nx*side/(width+2*side));
n_st = [n_north n_north n_east n_east];
[x,y,xc,yc,dx,dy] = stretchmesh(x,y,n_st,[5,5,5,5]);
% [X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,'0000');
Hx = Hx(:,:,nmodes); Hy = Hy(:,:,nmodes); neff = neff(nmodes);
[~,Ex,Ey,Ez] = postprocess(lambda,neff,Hx,Hy,dx,dy,eps,'0000');

%% plot
visualizemode(Ex,Ey,x,y,edges,neff)
% v = linspace(0,max(Ex,[],'all'),100);
% contourf(X',Y',Ex,v,'LineStyle','None');
% line(edges{:},'Color','Black');
% xlim([-6 6]); ylim([-1 3]);
% xlabel('x (\mum)'); ylabel('y (\mum)');
%% scattering
modefield.x = x; modefield.dx = dx;
modefield.y = y; modefield.dy = dy;
modefield.Ex = Ex;
modefield.Ey = Ey;
modefield.Ez = Ez;
modefield.eps = eps;
modefield.iedges = iedges;
modefield.n_co = n_co;
modefield.n_cl = n_cl;
modefield.neff = neff;
modefield.lambda = lambda;
modefield.L = L;

[g,gamma_s,alpha_s,E_con] = scattering_coupling(modefield,roughness);

%% report
for ii = 1:length(roughness.Lc)
    fprintf('--------------------REPORT-------------------\n');
    fprintf('Surface %1d %1dD:                      \n',roughness.surfaces{ii},length(roughness.Lc{ii}));
    fprintf('Mode coupling rate             %.3f MHz\n',g(ii)*1e-6);
    fprintf('Scattering loss rate           %.3f MHz\n',gamma_s(ii)*1e-6);
    fprintf('Propagation loss               %.3f dB/m\n',alpha_s(ii));
end