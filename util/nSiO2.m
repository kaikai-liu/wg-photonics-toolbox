function n = nSiO2(lambda)
% lambda in um
eps = 0.6961663*lambda.^2./(lambda.^2-0.0684043^2)...
     + 0.4079426*lambda.^2./(lambda.^2-0.1162414^2)...
     + 0.8974794*lambda.^2./(lambda.^2-9.896161^2) + 1;
n = sqrt(eps);
end