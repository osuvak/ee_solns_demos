function [ str ] = dcblocker( x , varargin )

flag_plotter = 0;
if nargin >= 2
    if varargin{1} ~= 0
        flag_plotter = 1;
    end
end

str = [];
[no_r,no_c] = size(x);

myRange       = 0:no_c-1;
myRange_shift = [ -(no_c-1)/2:(no_c-1)/2 ];

x_dc_blocked         = zeros( [no_r,no_c] );
x_f                  = zeros( [no_r,no_c] );
x_f_shift            = zeros( [no_r,no_c] );
x_f_shift_dc_blocked = zeros( [no_r,no_c] );
x_f_shiftback        = zeros( [no_r,no_c] );

for ii = 1:no_r
    % fft
    x_f(ii,:) = fft( x(ii,:) ) / no_c;
    
    if flag_plotter
        figure;

        subplot(2,1,1)
        stem( myRange , real(x_f(ii,:)) , 'filled' )
        title( sprintf('x f(%d,:) - Real parts of fft coefficients',ii) )
        grid on;

        subplot(2,1,2)
        stem( myRange , imag(x_f(ii,:)) , 'filled' )
        title( sprintf('x f(%d,:) - Imaginary parts of fft coefficients',ii) )
        grid on;

    end
    
    %  fft shift
    x_f_shift(ii,:) = x_f( ii , [ (no_c+1)/2+1:no_c , 1:(no_c+1)/2 ] );
    
    if flag_plotter
        figure;

        subplot(2,1,1)
        stem( myRange_shift , real(x_f_shift(ii,:)) , 'filled' )
        title( sprintf('x f shift(%d,:) - Real parts of fft coefficients',ii) )
        grid on;

        subplot(2,1,2)
        stem( myRange_shift , imag(x_f_shift(ii,:)) , 'filled' )
        title( sprintf('x f shift(%d,:) - Imaginary parts of fft coefficients',ii) )
        grid on;
    end

    %  actually block dc
    x_f_shift_dc_blocked(ii,:) = x_f_shift(ii,:);
    x_f_shift_dc_blocked( ii , (no_c+1)/2 ) = 0 + 1j * 0;

    %  fft shift back
    x_f_shiftback(ii,:) = x_f_shift_dc_blocked( ii , [ (no_c+1)/2:no_c , 1:(no_c-1)/2 ] );

    if flag_plotter
        figure;

        subplot(2,1,1)
        stem( myRange , real(x_f_shiftback(ii,:)) , 'filled' )
        title( sprintf('x f shiftback(%d,:) - Real parts of fft coefficients',ii) )
        grid on;

        subplot(2,1,2)
        stem( myRange , imag(x_f_shiftback(ii,:)) , 'filled' )
        title( sprintf('x f shiftback(%d,:) - Imaginary parts of fft coefficients',ii) )
        grid on;
    end

    %  ifft
    x_dc_blocked(ii,:) = ifft( x_f_shiftback(ii,:) * no_c );
    x_dc_blocked(ii,:) = real(x_dc_blocked(ii,:));

end

str.x_dc_blocked         = x_dc_blocked;
str.x_f                  = x_f;
str.x_f_shift            = x_f_shift;
str.x_f_shift_dc_blocked = x_f_shift_dc_blocked;
str.x_f_shiftback        = x_f_shiftback;
