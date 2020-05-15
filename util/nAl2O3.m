function n = nAl2O3(lambda)
% lambda in um
% https://refractiveindex.info/?shelf=main&book=Al2O3&page=Malitson-o
% Malitson and Dodge 1972: ?-Al2O3 (Sapphire); n(o) 0.20-5.0 µm
eps = 1.4313493*lambda.^2./(lambda.^2-0.0726631^2)...
    + 0.65054713*lambda.^2./(lambda.^2-0.1193242^2)...
    + 5.3414021*lambda.^2./(lambda.^2-18.028251^2) + 1;
n = sqrt(eps);
end