% calculate beta, ng, D from neff

clear;
close all;

%% input
load('lumerical_neff_SiN_airclad_1160by510.mat');
% load('lumerical_neff_SiN_SiO2clad_1680by800.mat');
% load('lumerical_neff_SiN_SiO2clad_600by800.mat');
% load('lumerical_neff_SiN_SiO2clad_2000by700.mat');
% load('comsol_neff_SiN_SiO2clad_1600by800.mat');
% load('comsol_neff_SiN_SiO2clad_2000by730.mat');
% load('modesolver_neff_SiN_SiO2clad_2000by730.mat');
% load('modesolver_neff_SiN_SiO2clad_1600by800.mat');
% load('modesolver_neff_SiN_airclad_1160by510.mat');

neff = real(neff);
c = 299792458;                  % [m/s]
pi2 = 2*pi;                     % 2 pi
L = 2*pi*23e-6;                 % roundtrip length [m]
thz = 1e-12; ghz = 1e-9; mhz = 1e-6;

%% calculate wg property and FP modes
f1 = 150e12; f2 = 400e12; f_points = 100;
[wg,modes] = dispersion_calc(f,neff,L,f1,f2,f_points);
f = wg.f_out;
lambda = c./f*1e9;
neff = wg.neff_out;
ng = wg.ng_out;
D = wg.D_out;
m = modes.m;
f_m = modes.f_m;
w_m = f_m*pi2;
FSR_m = modes.FSR_m;
dFSR_m = modes.dFSR_m;
FSR_m_c = modes.FSR_m_c;
dFSR_m_c = modes.dFSR_m_c;


%% plot ng, D, FSR, dFSR
figure;
subplot(1,3,1);
plot(f*thz,neff); xlabel('Freq (THz)');
% plot(lambda,neff); xlabel('\lambda (\mum)'); 
ylabel('n_{eff}'); grid on; title('n_{eff}');
subplot(1,3,2);
plot(f*thz,ng); xlabel('Freq (THz)');
% plot(lambda,ng); xlabel('\lambda (\mum)');
ylabel('ng'); grid on; title('Group Index n_g');
subplot(1,3,3);
plot(f*thz,D*1e6); xlabel('Freq (THz)'); 
% plot(lambda,D*1e6); xlabel('\lambda (\mum)');
ylabel('D(ps/nm*km)'); grid on; title('Dispersion D');

% plot simulated and calculated fsr & dfsr
figure;
subplot(1,2,1);
plot(f_m*thz,[FSR_m FSR_m_c]*thz);
% plot(f_m*thz,FSR_m*thz);
xlabel('Freq (THz)'); ylabel('FSR(THz)'); grid on; 
legend('Simulated','Calculated'); title('FSR'); %ylim([0.96 0.99]);
subplot(1,2,2);
plot(f_m*thz,[dFSR_m dFSR_m_c]*mhz);
% plot(f_m*thz,dFSR_m*mhz);
xlabel('Freq (THz)'); ylabel('\deltaFSR(MHz)'); grid on; 
legend('Simulated','Calculated'); title('\deltaFSR');

%% Integrated dispersion Dint(MHz)
% f_pump = 194e12;            % pump freq
f_pump = 305e12;            % pump freq
Dint = get_Dint(f_pump,w_m,m);
% figure;
plot(f_m*thz,Dint/pi2*ghz,'.'); grid on; hold on; ylim([-100 100]);
% dv for fwm frequency matching dv = v(-i) + v(i) - 2v(0)
[v,dv] = freq_mismatch(f_pump,w_m,m);
plot(v*thz,dv*ghz,'.');
xlabel('optical freq offset \nu(THz)');
ylabel('D_{int}/2\pi & \delta\nu(GHz)');
title('Integrated dispersion & frequency mismatch');
legend('D_{int}=\omega_{\mu}-(\omega_0+D_1\mu)',...
    '\delta\nu = \nu_i+\nu_s-2\nu_0');