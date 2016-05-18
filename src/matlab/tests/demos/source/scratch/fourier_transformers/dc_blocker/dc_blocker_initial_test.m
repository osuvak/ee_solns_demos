close all
clear all

format long e

N = 21;

T = 1;
no_periods = 1;

A = 1;
offset = 0.2;

w = 2 * pi / T;
t = linspace( 0 , no_periods * T , N * no_periods + 1 );
x = A * sin( w * t ) + offset;

figure;
plot( t , x )
title( 'Signal vs. time (sec)' )
grid on

%  fft
x_f = fft( x(1:end-1) ) / numel(x(1:end-1));
myRange = 0:numel(x_f)-1;

figure;

subplot(2,1,1)
stem( myRange , real(x_f) , 'filled' )
title('Real parts of fft coefficients')
grid on;

subplot(2,1,2)
stem( myRange , imag(x_f) , 'filled' )
title('Imaginary parts of fft coefficients')
grid on;

%  fft shift
x_f_shift = x_f( [ (numel(x_f)+1)/2+1:numel(x_f) , 1:(numel(x_f)+1)/2 ] );
myRange_shift = [ (-numel(x_f)+1)/2:(numel(x_f)-1)/2 ];

figure;

subplot(2,1,1)
stem( myRange_shift , real(x_f_shift) , 'filled' )
title('Real parts of fft coefficients')
grid on;

subplot(2,1,2)
stem( myRange_shift , imag(x_f_shift) , 'filled' )
title('Imaginary parts of fft coefficients')
grid on;

%  actually block dc
x_f_shift_dc_blocked = x_f_shift;
x_f_shift_dc_blocked( (numel(x_f)+1)/2 ) = 0 + 1j * 0;

%  fft shift back
x_f_shiftback = x_f_shift_dc_blocked( [ (numel(x_f)+1)/2:numel(x_f) , 1:(numel(x_f)-1)/2 ] );

figure;

subplot(2,1,1)
stem( myRange , real(x_f_shiftback) , 'filled' )
title('Real parts of fft coefficients')
grid on;

subplot(2,1,2)
stem( myRange , imag(x_f_shiftback) , 'filled' )
title('Imaginary parts of fft coefficients')
grid on;

%  ifft
x_dc_blocked = ifft( x_f_shiftback * numel(x_f) );
x_dc_blocked = real(x_dc_blocked);


figure;
plot( t(1:end-1) , x_dc_blocked )
title( 'DC Blocked Signal vs. time (sec)' )
grid on

