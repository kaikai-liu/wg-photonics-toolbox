% geometry
width = 2.0;        % waveguide width
h_co = 0.4;         % Core thickness
h_cl = 1.0;         % Cladding thichness
side = 1.0;         % Space on side
dx = 20e-3;         % grid size (horizontal)
dy = 20e-3;         % grid size (vertical)

% wavelength
n_cl = 1.4431;      % Cladding index
n_co = 1.9963;      % Core index
lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of mode to compute
L = 2*pi*11.8e3;    % waveguide length (um)

% roughness
roughness.surfaces = {1,3};
roughness.Lc = {[36e-3 36e-3],120e-3};
roughness.sigma = {0.18e-3,1.4e-3};