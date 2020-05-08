% Ciminelli, Caterina, et al. "Fully three-dimensional accurate modeling 
% of scattering loss in optical waveguides." Optical and quantum 
% electronics 41.4 (2009): 285-298.

% 300nm x 300nm Si waveguide 25dB/cm in paper

% Refractive indices:


% Layer heights:


% Horizontal dimensions
width = 0.305;      % waveguide width
h_co = 0.3;         % Core thickness
h_cl = 0.8;         % Cladding thichness
side = 0.8;         % Space on side
dx = 5e-3;          % grid size (horizontal)
dy = 5e-3;          % grid size (vertical)

% wavelength
n_cl = 1.44;        % Cladding index
n_co = 3.48;        % Core index
lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of mode to compute
L = 2*pi*11.8e3;    % waveguide length (um)

% roughness
roughness.surfaces = {3};
roughness.Lc = {50e-3};
roughness.sigma = {3.5e-3};