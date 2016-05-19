close all
clear all

format long e

N = 41;
%  can try with less or more number of points per period (keep the number odd)
%  N = 21;

T = 1;
no_periods = 1;
%  try with more than one periods (keep the number odd)
%  no_periods = 3;

A = 1;
offset = 0.2;

w = 2 * pi / T;
t = linspace( 0 , no_periods * T , N * no_periods + 1 );

%  initial signal
x = A * sin( w * t ) + offset;

%  temp
x_temp = A / 4 * cos( w * t) + A / 2 * sin( 3 * w * t ) + offset * 5;
%  stack signals
x = [ x ; x_temp ];

%  temp
x_temp = A / 4 * cos( w * t) + A / 2 * sin( 3.5 * w * t ) + offset * 5;
%  stack signals
x = [ x ; x_temp ];

%  plot signals
figure;
for ii = 1:size(x,1)
    subplot( size(x,1) , 1 , ii )
    plot( t , x(ii,:) )
    title( sprintf( 'Signal %d vs. time (sec)' , ii ) );
    grid on
end

%  dc block
%  str = dcblocker( x(:,1:end-1) );
%  run this one to generate intermediate plots
str = dcblocker( x(:,1:end-1) , 1 );

%  plot dc blocked signals
figure;
for ii = 1:size(x,1)
    subplot( size(x,1) , 1 , ii )
    plot( t(1:end-1) , str.x_dc_blocked(ii,:) )
    title( sprintf( 'DC-Blocked Signal %d vs. time (sec)' , ii ) )
    grid on
end