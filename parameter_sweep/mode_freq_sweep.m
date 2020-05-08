% mode_freq_sweep.m
% calculate mode field when sweeping freq/lambda

clear;

%% input
input_SiN_SiO2clad;

c = 299792458;
f = (150:2:500)*1e12;                 % optical freq [Hz]
lambda = c./f*1e6;                    % wavelength [um]
n_cl = nSiO2(lambda);
n_co = nSi3N4(lambda);
neff = zeros(size(f));

%% mode field

for ii = 1:length(lambda)
    % primitive mesh
    [x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh_rect(...
        [n_cl(ii),n_co(ii),1],...
        [h_cl,h_co,h_cl],width/2,side,dx,dy);
    
    % undistorted stretch mesh
    n_north = round(ny*h_cl/(2*h_cl+h_co));
    n_east = round(nx*side/(width+2*side));
    n_st = [n_north n_north n_east n_east];
    [x,y,xc,yc,dx1,dy1] = stretchmesh(x,y,n_st,[4,4,4,4]);
%     [X,Y] = meshgrid(x,y); figure; scatter(X(:),Y(:),'.'); line(edges{:},'Color','red');
    
    % First consider the fundamental TE/TM mode
    [Hx,Hy,neff(ii)] = wgmodes(lambda(ii),n_co(ii),nmodes,dx1,dy1,eps,'0000');
    
    if ii == 1
        [~,Ex,Ey,~] = postprocess(lambda(ii),neff(ii),Hx,Hy,dx,dy,eps,'0000');
        visualizemode(Ex,Ey,x,y,edges,neff(ii)); 
    end
%     disp(ii);
end

%% save
save('.\data\modesolver_neff_SiN_airclad_1160by510.mat','neff','f','lambda');