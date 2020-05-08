% D-shape waveguide 8um by 100nm

% geometry
width = 4;      	% D-shape width
% r_D = 8;       	% D circle radius
r_D = (h_co^2+(width/2)^2)/(2*h_co); % D circle radius
h_co = 0.3;     	% Core thickness
h_cl = 0.4;         % Lower cladding
side = 0.5;         % Space on side
dx = 10e-3;         % grid size (horizontal)
dy = 4e-3;          % grid size (vertical)

% wavelength
n_co = 2.0;         % core index
n_cl = 1.44;        % clad index
lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of mode to compute
L = 2*pi*11.8e3;    % waveguide length (um)

% roughness
roughness.surfaces = {1,3};
roughness.Lc = {[10e-3 10e-3],10e-3};
roughness.sigma = {0.6e-3,10e-3};
roughness.ds = {[],50e-3};