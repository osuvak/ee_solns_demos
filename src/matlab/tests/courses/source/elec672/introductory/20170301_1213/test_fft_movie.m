N = 101; 
noPeriods = 5;

A = 2.5;
offset = 1.0;
ph = 45;
period = 10;

if noPeriods == 1
    totalNoPoints = noPeriods * N + 1;
else
    totalNoPoints = ceil(noPeriods * N + 1);
    if ( 0 ~= rem(totalNoPoints,2) )
        totalNoPoints = totalNoPoints + 1;
    end
end

t = linspace( 0 , noPeriods * period , totalNoPoints );
 
t = t( 1:end-1 );
%  t = t( 1:length(t)-1 );
%  t = t( 1:numel(t)-1 );
%  t = t( 1:size(t,2)-1 );

noPhArray = 45;
phArray = linspace( 0 , 180 , noPhArray );
timePause = 0.2;

%  phArray = 0;

figure;
for kk = 1:numel(phArray)

x = offset + A * sin( 2 * pi / period * t - phArray(kk) * pi / 180 );

x_f = fft( x );
x_f = x_f / numel(x_f);

noH = numel(x_f);

x_f = [ x_f(((noH+1)/2+1):end) x_f(1:(noH+1)/2) ];
myIndexRange = (1:noH) - 1 - (noH-1)/2;

subplot(3,2,1)
plot( t , x , 'LineWidth' , 3 )
grid on;
title('Signal vs time (sec)')

subplot(3,2,2)
plot( t , x , 'LineWidth' , 3 )
grid on;
title('Signal vs time (sec)')

subplot(3,2,3)
stem( myIndexRange , real(x_f) , 'filled' , 'LineWidth' , 3 )
grid on;
title(sprintf('Real Parts (phase = %.f)' , phArray(kk) ))

subplot(3,2,5)
stem( myIndexRange , imag(x_f) , 'filled' , 'LineWidth' , 3 )
grid on;
title(sprintf('Imag Parts (phase = %.f)' , phArray(kk) ))

subplot(3,2,4)
stem( myIndexRange , abs(x_f) , 'filled' , 'LineWidth' , 3 )
grid on;
title(sprintf('Amplitudes (phase = %.f)' , phArray(kk) ))

subplot(3,2,6)
stem( myIndexRange , 180 / pi * atan( imag(x_f) ./ real(x_f) ) , 'filled' , 'LineWidth' , 3 )
grid on;
title(sprintf('Phases (phase = %.f)' , phArray(kk) ))

pause(timePause)
drawnow
pause(timePause)
end % for