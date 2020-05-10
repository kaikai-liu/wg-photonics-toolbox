Lc = 10e-3;

u = (1:100)';
% plot(u,[func_corr_exp(u,0,Lc) func_corr_rational(u,0,Lc)]);
xi = linspace(0,1/Lc,100)';
[~,y1] = func_corr_exp(0,xi,Lc);
[~,y2] = func_corr_rational(0,xi,Lc);
plot(xi,[y1 y2]);