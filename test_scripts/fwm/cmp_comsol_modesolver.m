% calculate beta, ng, D from neff

clear;
close all;

c = 299792458;                  % [m/s]
pi2 = 2*pi;                     % 2 pi
L = 2*pi*23e-6;                 % roundtrip length [m]
thz = 1e-12; ghz = 1e-9; mhz = 1e-6; % units
f1 = 150e12; f2 = 400e12; f_points = 200;

%% input lumerical neff
load('comsol_neff_SiN_SiO2clad_1600by800.mat');
% load('comsol_neff_SiN_SiO2clad_2000by730.mat');
neff = real(neff(:,1));

% calculate wg property and FP modes
wg = dispersion_calc(f,neff,L,f1,f2,f_points);
f = wg.f_out;
lambda = c./f*1e9;
neff1 = wg.neff_out;
ng = wg.ng_out;
D = wg.D_out;

% plot ng, D, FSR, dFSR
subplot(1,3,1); hold on;
plot(lambda,neff1);
xlabel('\lambda (nm)'); ylabel('n_{eff}'); grid on; title('n_{eff}');
subplot(1,3,2); hold on;
plot(lambda,ng);
xlabel('\lambda (nm)'); ylabel('ng'); grid on; title('Group Index n_g');
subplot(1,3,3); hold on;
plot(lambda,D*1e6);
xlabel('\lambda (nm)'); ylabel('D(ps/nm*km)'); grid on; title('Dispersion D');

%% input modesolver neff
load('modesolver_neff_SiN_SiO2clad_1600by800.mat');
% load('modesolver_neff_SiN_SiO2clad_2000by730.mat');
neff = real(neff);

% calculate wg property and FP modes
wg = dispersion_calc(f,neff,L,f1,f2,f_points);
f = wg.f_out;
lambda = c./f*1e9;
neff1 = wg.neff_out;
ng = wg.ng_out;
D = wg.D_out;

% plot ng, D, FSR, dFSR
subplot(1,3,1); hold on;
plot(lambda,neff1);
xlabel('\lambda (nm)'); ylabel('n_{eff}'); grid on; title('n_{eff}');
legend('COMSOL simulation','modesolver');

subplot(1,3,2); hold on;
plot(lambda,ng);
xlabel('\lambda (nm)'); ylabel('ng'); grid on; title('Group Index n_g');

subplot(1,3,3); hold on;
plot(lambda,D*1e6);
xlabel('\lambda (nm)'); ylabel('D(ps/nm*km)'); grid on; title('Dispersion D');

