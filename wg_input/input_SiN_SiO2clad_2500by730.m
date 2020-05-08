% Ji, Xingchen, et al. "Ultra-low-loss on-chip resonators with 
% sub-milliwatt parametric oscillation threshold." Optica 4.6 (2017): 
% 619-624.

% 2500nm x 730nm SiN 

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
nmodes = 1;         % number of mode to compute
L = 2*pi*11.8e3;    % waveguide length (um)

% roughness
roughness.surfaces = {1,1,3};
roughness.Lc = {[29e-3 29e-3],[8.8e-3 8.8e-3],50e-3};
roughness.sigma = {0.38e-3,0.08e-3,1e-3};