function [g,alpha_g,gamma_s,alpha_s,E_con] = scattering_splitting(modefield,roughness)
% scattering_splitting.m calculates the mode coupling rate between forward
% propagating mode and backward propagating mode due to roughness. It also
% calculates the scattering loss due to roughness
%
% USAGE:
% [g,gamma_s,alpha_s,E_con] = func_scattering_coupling(modefield,roughness)
%
% INPUT
%
% modefield - structure including detailed waveguide geometry information
%       modefield.x\y\dx\dy - field coordinates
%       modefield.Ex\Ey\Ez - E field
%       modefield.eps - refractive index field
%       modefield.iedges - index of edge coordinate on meshgrid
%       modefield.n_co,n_cl,neff,lambda,L - core and cladding index, wavelength,
%       waveguide length

% roughness - structure including detailed roughness function information
%       roughness.surfaces - index of surfaces NSEW(1234)
%       roughness.Lc - corration lengths
%       roughness.sigma - list of rms roughness
%
% OUTPUT
%
% gamma_s - scatter loss rate
% alpha - scattering loss dB/m
% E_con - energy concentration on the surfaces

% check modesolver
if exist('wgmodes') == 0
    error("Couldn't find modesover. Please run ""script_add_modesolver.m"" to add.");
end

% mode field info
x = modefield.x; dx = modefield.dx;
y = modefield.y; dy = modefield.dy;
Ex = modefield.Ex;
Ey = modefield.Ey;
Ez = modefield.Ez;
eps = modefield.eps;
iedges = modefield.iedges;
n_co = modefield.n_co;
n_cl = modefield.n_cl;
neff = modefield.neff;
lambda = modefield.lambda;
L = modefield.L;

c = 299792458;
f = c/lambda*1e6;
k0 = 2*pi/lambda;
beta = neff*k0;
dn2 = n_co^2 - n_cl^2;              % eps difference between clad and core
func_corr = @func_corr_exp;
% func_corr = roughness.func_corr;

% compute for each surface
for ii = 1:length(roughness.surfaces)
    % roughness info
    surface_ii = roughness.surfaces{ii};    % surface to integrate over
    Lc_ii = roughness.Lc{ii};               % correlation length
    sigma_ii = roughness.sigma{ii};
    
    % Lc - 1D or 2D
    Lcz = Lc_ii(1);
    if length(Lc_ii)>1
        Lcw = Lc_ii(2);
    else
        Lcw = Inf;
    end
    
    % surface coordinates and ds
    x_edge = x(iedges{1,surface_ii})';
    y_edge = y(iedges{2,surface_ii});
    if length(x_edge) == 1
        ds_r = roughness.ds{ii};
        ds = ds_r; 
    else
        ds = sqrt(diff(x_edge).^2+diff(y_edge).^2);
        ds = [ds(1) ds];
    end
    
    
    % field on the surface
    ind_field = sub2ind(size(Ex),iedges{1,surface_ii},iedges{2,surface_ii});
    Ex_edge = Ex(ind_field); Ey_edge = Ey(ind_field); Ez_edge = Ez(ind_field);
    Exyz_edge = [Ex_edge(:) Ey_edge(:) Ez_edge(:)];
    E2 = abs(Ex).^2 + abs(Ey).^2 + abs(Ez).^2;
    E2_edge = E2(ind_field); E2_edge = E2_edge(:);
    
    % weigth integration
    Um_2D = sum(dx'*(1/2*eps.*E2)*dy','all');
    dx1x2 = sqrt((ones(length(x_edge),1)*x_edge - x_edge'*ones(1,length(x_edge))).^2 ...
            + (ones(length(y_edge),1)*y_edge - y_edge'*ones(1,length(y_edge))).^2);
    weight = func_corr(dx1x2,0,Lcw);
    
    % coupling rate integration
    [~,R2beta_ii] = func_corr(0,2*neff*k0,Lcz); % R_hat at 2*beta
    E2_edge_int = ds*(real(E2_edge*E2_edge').*weight)*ds';
%     E2_edge_int = sqrt(ds*(real(E2_edge*E2_edge').*weight)*ds');
    g(ii) = 2*f*dn2*sigma_ii*sqrt(R2beta_ii/L)*E2_edge_int/Um_2D;
    alpha_g(ii) = g(ii)*2*pi*neff/c*4.34;
%     E2_edge_int = sqrt(ds*(real(E2_edge*E2_edge').*weight)*ds');
%     alpha_g(ii) = (beta*1e6)*beta*(dn2*sqrt(R2beta_ii)*sigma_ii*E2_edge_int/Um_2D)^2;
%     g(ii) = alpha_g(ii)*c/neff/(2*pi);
%     alpha_g(ii) = alpha_g(ii)*4.34;
    
    % scattering loss calculation
    N1 = 50;
    N2 = 50;
    theta = linspace(0,pi,N1)'; dtheta = theta(2) - theta(1);
    phi = linspace(0,2*pi,N2)'; dphi = phi(2) - phi(1);
    S = zeros(N1,N2);
    for i = 1:N1
        for j = 1:N2
            theta_i = theta(i);
            phi_j = phi(j);
            r = [sin(theta_i)*cos(phi_j) sin(theta_i)*sin(phi_j) cos(theta_i)];
            rr = r'*r;
            E_far = Exyz_edge - Exyz_edge*rr;
            [~,Rz_ij] = func_corr(0,neff*k0-n_cl*cos(theta_i),Lcz);
            S(i,j) = Rz_ij*(ds*(real(E_far*E_far').*weight)*ds')*sin(theta_i);
        end
    end
    
    gamma_s(ii) = f*n_cl*dn2^2*k0^3*sigma_ii^2/(32*pi^2*Um_2D)*sum(S*dtheta*dphi,'all');
    alpha_s(ii) = 2*pi*neff*gamma_s(ii)/c*4.34;
    
    % energy concentration
    E_con = E2_edge_int/Um_2D;
    
end
end