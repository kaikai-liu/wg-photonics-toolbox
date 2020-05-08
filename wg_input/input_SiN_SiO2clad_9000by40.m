% 2500nm x 40nm SiN

% geometry
width = 9.0;        % waveguide width
h_co = 0.04;         % Core thickness
h_cl = 1.0;         % Cladding thichness
side = 1.0;         % Space on side
dx = 40e-3;         % grid size (horizontal)
dy = 10e-3;         % grid size (vertical)

% wavelength
n_cl = 1.4431;      % Cladding index
n_co = 1.9963;      % Core index
lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of mode to compute
L = 2*pi*11.8e3;    % waveguide length (um)

% roughness
roughness.surfaces = {1,3};
roughness.Lc = {[10]*1e-3,50e-3};
roughness.sigma = {0.45*1e-3,2.5*1e-3};