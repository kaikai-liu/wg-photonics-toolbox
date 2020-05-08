
clear;
close all;

%% input
input_Si_SiO2clad_D_shape;

%% mode field
% primitive mesh
[x,y,xc,yc,nx,ny,eps,edges,iedges] = waveguidemesh_D_shape(...
    [n_co n_cl],[h1 h2 h3],r_D,side,dx,dy);

% undistorted stretch mesh
n_north = round(ny*h1/(h1+h2+h3)); 
n_east = round(nx*side/(width+2*side));
n_st = [n_north n_north n_east n_east];
[x,y,xc,yc,dx,dy] = stretchmesh(x,y,n_st,[5,5,5,5]);
[X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');

% First consider the fundamental TE/TM mode
[Hx,Hy,neff] = wgmodes(lambda,n_co,nmodes,dx,dy,eps,'0000');
[~,Ex,Ey,Ez] = postprocess(lambda,neff,Hx,Hy,dx,dy,eps,'0000');

% plot
visualizemode(Ex,Ey,x,y,edges,neff)

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

% add the index of the single point as edge 3
[~,indx] = min(abs(x-0));
indy = max(find(eps(indx,:)>1.6^2));
iedges{1,3} = indx;
iedges{2,3} = indy;
modefield.iedges = iedges;

[g,gamma_s,alpha_s,E_con] = scattering_coupling(modefield,roughness);

%% report
for ii = 1:length(roughness.Lc)
    fprintf('--------------------REPORT-------------------\n');
    fprintf('Surface %1d:                           \n',roughness.surfaces{ii});
    fprintf('Mode coupling rate             %.3f MHz\n',g(ii)*1e-6);
    fprintf('Scattering loss rate           %.3f MHz\n',gamma_s(ii)*1e-6);
    fprintf('Propagation loss               %.3f dB/m\n',alpha_s(ii));
end