close all
clear all

format long

xExact = 2^(1/3);
%  xInit = 5;
xInit = xExact * (1+0.1);

xSoln = [ xInit ];
maxIter = 20;

fh    = @myFunction;
fhder = @myFunctionDer;

for kk = 1:maxIter
    tmp = - fh(xSoln(end)) / fhder(xSoln(end));
    xSoln = [ xSoln xSoln(end)+tmp ];
end

xErr = abs( xSoln - xExact * ones(1,numel(xSoln)) ) ./ abs( xExact * ones(1,numel(xSoln)) );

%{
figure;
semilogy(0:numel(xSoln)-1,xErr,'LineWidth',4)
hold off;
hold on;
semilogy(0:numel(xSoln)-1,xErr,'o','LineWidth',2,'MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k')
hold off;
grid on
title('Errors vs. Iterations')
%}

figure;
semilogy(0:numel(xSoln)-1,xErr,'o-','Color','k','LineWidth',4,'MarkerSize',16,'MarkerFaceColor','r','MarkerEdgeColor','k')
grid on
title('Errors vs. Iterations')
