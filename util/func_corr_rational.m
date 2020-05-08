function [R0,fftR0] = func_corr_rational(u,xi,Lc)
R0 = 1./(1+u/Lc);

L = 10*Lc;
u = linspace(0,L,100)'; du = L/100;
fftR0 = sum(1./(1+u*ones(1,length(xi))/Lc).*cos(u*xi')*du)';

end