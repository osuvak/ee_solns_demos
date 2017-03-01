close all
clear all

xInit = 0;
nIter = 40;

xSoln = 10 / 0.7;

x = [ xInit ];

for kk = 1:nIter
    tmp = x(end) - 0.7 * x(end) + 10;
    x = [ x tmp ];
end

err = abs( xSoln * ones(size(x)) - x );
err = err / abs(xSoln);

figure;
semilogy(0:numel(x)-1,err)
title('Errors vs. iterations')
grid on
