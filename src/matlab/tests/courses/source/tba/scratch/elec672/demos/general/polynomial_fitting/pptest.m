close all
clear all

format long e

xStart = 0;
xEnd   = 1;

%  N = [ 10 20 40 100 ];
N = 5:5:200;

cM = zeros(size(N));

for ii = 1:numel(N)
%  for ii = 1:2

NN = N(ii);

xRange = linspace(xStart,xEnd,NN);
M = zeros(NN,NN);

for kk = 1:NN
    tmp = xRange';
    M(:,kk) = tmp.^(kk-1);
end
b = xRange';

x = M \ b;

cM(ii) = cond(M);

figure;
stem(0:NN-1,x,'filled');
title(sprintf('N = %d',NN))

end

xAxisMax = ( ceil( max(N) / 10 ) + 1 ) * 10;

yLength = log10(max(cM)) - log10(min(cM));
yExtra = yLength * (0.10);
yMax = ceil((log10(max(cM))+yExtra)/5) * 5;
yMin = floor((log10(min(cM))-yExtra)/5) * 5;
yMax = yMax + 0.1;
yMin = yMin - 0.1;

figure;
semilogy(N,cM,'o','MarkerSize',10,'MarkerFaceColor','b')
title('condition number vs. N')
axis([0 xAxisMax 10^yMin 10^yMax])
grid on