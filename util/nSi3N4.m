function n = nSi3N4(lambda)
% lambda in um
% https://refractiveindex.info/?shelf=main&book=Si3N4&page=Luke
% Luke et al. 2015: n 0.310-5.504 µm
eps = 3.0249*lambda.^2./(lambda.^2-0.1353406^2)...
    + 40314*lambda.^2./(lambda.^2-1239.84^2) + 1;
n = sqrt(eps);
end