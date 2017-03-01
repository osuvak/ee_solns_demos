N = 101; 
noPeriods = 5;

A = 2.5;
offset = 1.0;
ph = 45;
period = 10;

t = linspace( 0 , noPeriods * period , noPeriods * N + 1 );
x = A * sin( 2 * pi / period * t - ph * pi / 180 );

figure;
plot ...
    ( ...
        t , x , ...
        'LineWidth' , 4 , 'Color' , 'r' ...
    )

grid on;
title('Generic Sine Signal vs time (sec)')
xlabel( 'time (sec)' )
ylabel( 'signal' )

noPhArray = 45;
phArray = linspace( 0 , 180 , noPhArray );
timePause = 0.05;

figure;
for kk = 1:numel(phArray)
   y = A * sin( 2 * pi / period * t - phArray(kk) * pi / 180 );
   plot ...
    ( ...
        t , y , ...
        'LineWidth' , 4 , 'Color' , 'r' ...
    ) 
    
    grid on;
    title( sprintf( 'Generic Sine Signal (phase = %.2f)  vs time (sec)' , phArray(kk) ) )
    xlabel( 'time (sec)' )
    ylabel( 'signal' )
    
    pause(timePause)
    drawnow
    pause(timePause)
end






