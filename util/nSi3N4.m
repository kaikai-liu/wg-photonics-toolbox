function n = nSi3N4(lambda)
% lambda in um
eps = 3.0249*lambda.^2./(lambda.^2-0.1353406^2)...
    + 40314*lambda.^2./(lambda.^2-1239.84^2) + 1;
n = sqrt(eps);
end