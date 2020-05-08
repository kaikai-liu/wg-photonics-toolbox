function [R0,fftR0] = func_corr_exp(u,xi,Lc)
R0 = exp(-u/Lc);
fftR0 = 2*Lc./(1+(Lc*xi).^2);
end