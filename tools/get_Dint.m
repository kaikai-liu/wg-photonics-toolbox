function Dint = get_Dint(f_pump,w_m,m)
% get_Dint
f_m = w_m/2/pi;
FSR_m = diff(w_m); FSR_m = [FSR_m(1); FSR_m];
m0 = m(abs(f_m-f_pump) == min(abs(f_m-f_pump))); % pump mode
Dint = w_m - (w_m(m==m0)+(m-m0)*FSR_m(m==m0));
end

