N = 101; 
noPeriods = 1;

A = 2.5;
offset = 1.0;
ph = 45;
period = 10;

t = linspace( 0 , noPeriods * period , noPeriods * N + 1 );
 
t = t( 1:end-1 );
%  t = t( 1:length(t)-1 );
%  t = t( 1:numel(t)-1 );
%  t = t( 1:size(t,2)-1 );

x = A * sin( 2 * pi / period * t - ph * pi / 180 );

x_f = fft( x );
myIndexRange = (1:numel(x_f)) - 1;

figure;

subplot(2,2,1)
stem( myIndexRange , real(x_f) , 'filled' , 'LineWidth' , 3 )
grid on;
title('Real Parts vs index')

subplot(2,2,3)
stem( myIndexRange , imag(x_f) , 'filled' , 'LineWidth' , 3 )
grid on;
title('Imag Parts vs index')

subplot(2,2,2)
stem( myIndexRange , abs(x_f) , 'filled' , 'LineWidth' , 3 )
grid on;
title('Amplitudes vs index')

subplot(2,2,4)
stem( myIndexRange , 180 / pi * atan( imag(x_f) ./ real(x_f) ) , 'filled' , 'LineWidth' , 3 )
grid on;
title('Phases vs index')

