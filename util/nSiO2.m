function n = nSiO2(lambda)
% lambda in um
% https://refractiveindex.info/?shelf=main&book=SiO2&page=Malitson
% Malitson 1965: Fused silica; n 0.21-6.7 µm
eps = 0.6961663*lambda.^2./(lambda.^2-0.0684043^2)...
     + 0.4079426*lambda.^2./(lambda.^2-0.1162414^2)...
     + 0.8974794*lambda.^2./(lambda.^2-9.896161^2) + 1;
n = sqrt(eps);
end