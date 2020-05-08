function [v,dv] = freq_mismatch(f_pump,w_m,m)
% freq_mismatch
pi2 = 2*pi;
f_m = w_m/pi2; % mode freq
m0 = m(abs(f_m-f_pump) == min(abs(f_m-f_pump))); % pump mode
ind = min([m0-min(m) max(m)-m0]);
v = zeros(ind+1,1);
dv = zeros(ind+1,1);
for i = 0:ind
    dv(i+1) = (w_m(m==(m0+i)) + w_m(m==(m0-i)) - 2*w_m(m==m0))/pi2;
    v(i+1) = w_m(m==(m0+i))/pi2;
end
v = [v-(max(v)-min(v));v];
dv = [flip(dv);dv];
end

