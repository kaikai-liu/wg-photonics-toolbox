function [wg_results,modes_results]  = dispersion_calc1(f_in,neff_in,L,f1,f2,f_points)
% This function calculates the dispersion property based on neff(w), e.g.,
% beta2(w), D(w), etc.
% Input:
%       f_in            [Hz]
%       neff            [1]
%       L               cavity length [m]
%       f1, f2          start freq and stop freq [Hz]
%       f_points        freq points
% Output:
%       f_out           [Hz]
%       ng_out
%       D_out           [s/m^2] ([s/m^2]/1e6 = [ps/(nm*km)])
%       m               mode number
%       f_m             mode freq [Hz]
%       fsr_m           mode fsr [Hz]
%       dfsr_m          mode fsr increase [Hz]

% settings
c = 299792458;                      % [m/s]
pi2 = 2*pi;                         % 2 pi
thz = 1e-12; um = 1e-6;             % unit scale

% input and output
f_in = f_in(:);
neff_in = neff_in(:);
w_in = pi2*f_in;
f_out = linspace(f1,f2,f_points)'; 
w_out = pi2*f_out;

% calculate beta1 and beta2 from poly3 fitting of beta(w)
dw_in = (w_in-w_in(1))*thz;         % dw denote w_in-w0 in [THz]
dw_out = (w_out-w_in(1))*thz;       % dw denote w_out-w0 in [THz]
n_ft = fit(dw_in,neff_in,'poly4');
neff_out = n_ft(dw_out);
% p1 = ft.p1; p2 = ft.p2; p3 = ft.p3; p4 = ft.p4;
% beta1 = (3*p1*dw_out.^2 + 2*p2*dw_out + p3)*thz/um;
% beta2 = (6*p1*dw_out    + 2*p2)*thz^2/um;
[n_w, n_ww] = differentiate(n_ft,dw_out);
beta1 = n_ft(dw_out)/c + w_out/c.*n_w*thz;
beta2 = 2/c*n_w*thz + w_out/c.*n_ww*thz^2;
beta_out = neff_out.*w_out/c;
neff_out = beta_out./(w_out/c);     % neff = beta/k = beta/(w/c);
ng_out = c*beta1;                   % vg = c/ng = (dbeta/dw)^-1;
D_out = -pi2*f_out.^2/c.*beta2;     % dispersion [s/m^2] ([s/m^2]/1e6 = [ps/(nm*km)]

% simulate FSR and 2*pi*m = beta_m*L and beta_m = beta(w_m)
m_min = floor(min(beta_out)*L/pi2)+1;
m_max = floor(max(beta_out)*L/pi2);
m = (m_min:m_max)';
w_m = zeros(size(m));
beta_m = pi2*m/L;

syms x;
% expr = p1*x^3 + p2*x^2 + p3*x + p4;
poly_coef = coeffvalues(n_ft);
expr = poly2sym(poly_coef,x);
for i = 1:length(m)
    x1 = (f1*pi2-w_in(1))*thz;
    x2 = (f2*pi2-w_in(1))*thz;
    sol = vpasolve(expr == beta_m(i)*c*thz/(x+w_in(1)*thz),x,[x1,x2]); % neff == beta_m*c/w
    w_m(i) = w_in(1) + double(sol(1))/thz;
end

% simulate FSR and dFSR
FSR_m = diff(w_m)/pi2;
dFSR_m = diff(FSR_m);
FSR_m = [FSR_m(1); FSR_m];
dFSR_m = [dFSR_m(1); dFSR_m(1); dFSR_m];

% FSR and dFSR can also be derectly calculated from ng and D
dw_m = (w_m - w_in(1))*thz;
[n_w, n_ww] = differentiate(n_ft,dw_m);
beta1_m = n_ft(dw_m)/c + w_m/c.*n_w*thz;
beta2_m = 2/c*n_w*thz + w_m/c.*n_ww*thz^2;

ng_m = c*beta1_m;
D_m = -pi2*(w_m/pi2).^2/c.*beta2_m;
FSR_m_c = c/L./ng_m;
dFSR_m_c = (c./(w_m/pi2).*FSR_m_c).^2./ng_m.*D_m;

% return as a structure
wg_results.f_out = f_out;
wg_results.neff_out = neff_out;
wg_results.ng_out = ng_out;
wg_results.D_out = D_out;
modes_results.m = m;
modes_results.f_m = w_m/pi2;
modes_results.FSR_m = FSR_m;
modes_results.dFSR_m = dFSR_m;
modes_results.FSR_m_c = FSR_m_c;
modes_results.dFSR_m_c = dFSR_m_c;
end