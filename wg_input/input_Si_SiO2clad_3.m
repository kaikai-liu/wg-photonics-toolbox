% Morichetti, Francesco, et al. "Roughness induced backscattering in 
% optical silicon waveguides." Physical review letters 104.3 (2010): 033902.

% 500nm x 200nm Si waveguide 32dB/cm in paper

% geometry
width = 0.49;        % waveguide width
h_co = 0.22;         % Core thickness
h_cl = 0.4;         % Cladding thichness
side = 0.4;         % Space on side
dx = 4e-3;          % grid size (horizontal)
dy = 4e-3;          % grid size (vertical)

% wavelength
n_cl = 1.45;        % Cladding index
n_co = 3.45;        % Core index
lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of mode to compute

% roughness
roughness.surfaces = {3};
roughness.Lc = {60e-3};
roughness.sigma = {2e-3};