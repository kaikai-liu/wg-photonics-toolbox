function n = nSi(lambda)
% lambda in um
eps = 10.6684293*lambda.^2./(lambda.^2-0.301516485^2)...
    + 0.0030434748*lambda.^2./(lambda.^2-1.13475115^2)...
    + 1.54133408*lambda.^2./(lambda.^2-1104^2) + 1;
n = sqrt(eps);
end