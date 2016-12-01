close all
clear all

format long e
rng('shuffle');

T = 10;
no_harm = 5;
no_periods = 3;
no_pts_per_period = 101;

coefs.dc     = rand;
coefs.sine   = rand(no_harm,1);
coefs.cosine = rand(no_harm,1);

%  coefs.dc     = ones;
%  coefs.sine   = ones(no_harm,1);
%  coefs.cosine = ones(no_harm,1);

w = 2 * pi / T;

t = linspace( 0 , T * no_periods , 1 + no_pts_per_period * no_periods * no_harm );

x = zeros(size(t));
%  x = zeros( size(t,1) , size(t,2) );

ch = 'add_in_place';

switch lower(ch)
    case 'add_in_place'
        x = x + coefs.dc;
%          x = x + coefs.dc * ones(size(t));
        for kk = 1:no_harm
            x = x + coefs.sine(kk)   * sin( w * t * kk );
            x = x + coefs.cosine(kk) * cos( w * t * kk );
        end
    otherwise
        error('No such choice');
end

figure;
plot(t,x)
title('Original Signal vs time')
grid on;

data.x  = x(1,1:end-1);
data.xf = fft(data.x) / numel(data.x);
data.xf = [ data.xf((1+numel(data.x))/2+1:end) data.xf(1:(+1+numel(data.x))/2) ];

data.ind = find( abs(data.xf) < 1e-15 );
data.xf(data.ind) = 0 + 1j * 0;

figure;
subplot(2,1,1)
stem( -(-1+numel(data.x))/2:(-1+numel(data.x))/2 , real(data.xf) , 'filled')
title('fft coefs - real parts')
grid on;
subplot(2,1,2)
stem( -(-1+numel(data.x))/2:(-1+numel(data.x))/2 , imag(data.xf) , 'filled')
title('fft coefs - imag parts')
grid on;

data.ind_nonzero = find( abs(data.xf) ~= 0.0 );

data_many_periods = data;

data.x  = x( 1 , 1:no_harm*no_pts_per_period);
data.xf = fft(data.x) / numel(data.x);
data.xf = [ data.xf((1+numel(data.x))/2+1:end) data.xf(1:(+1+numel(data.x))/2) ];

data.ind = find( abs(data.xf) < 1e-15 );
data.xf(data.ind) = 0 + 1j * 0;

figure;
subplot(2,1,1)
stem( -(-1+numel(data.x))/2:(-1+numel(data.x))/2 , real(data.xf) , 'filled')
title('fft coefs - real parts')
grid on;
subplot(2,1,2)
stem( -(-1+numel(data.x))/2:(-1+numel(data.x))/2 , imag(data.xf) , 'filled')
title('fft coefs - imag parts')
grid on;

data.ind_nonzero = find( abs(data.xf) ~= 0.0 );

data_single_period = data;

disp('Check harmonic content:')
disp(data_single_period.xf(data_single_period.ind_nonzero)-data_many_periods.xf(data_many_periods.ind_nonzero))

no_periods_new = 7;
t_new = linspace( 0 , T * no_periods_new , 1 + no_pts_per_period * no_periods_new * no_harm );
t_new = t_new(1:end-1);

data.xf = zeros( 1 , no_pts_per_period * no_periods_new * no_harm );
tmp_indices = ...
    + ( data_single_period.ind_nonzero - (1+numel(data_single_period.xf))/2 ) * no_periods_new ...
    + (1+numel(data.xf))/2;
data.xf( tmp_indices ) = data_single_period.xf(data_single_period.ind_nonzero);

data.xf_shiftback = [ data.xf((+1+numel(data.xf))/2:end) data.xf(1:(-1+numel(data.xf))/2) ];
data.x = real( ifft(data.xf_shiftback * numel(data.xf)) );

figure;
plot(t_new,data.x)
grid on;

data_many_periods_new = data;

array = data_single_period.xf(data_single_period.ind_nonzero);
array = array((1+numel(array))/2:end);
for kk = 2:numel(array)
    disp(sprintf('Checking %d th cos coef : ',kk-1));
    disp( coefs.cosine(kk-1) - real(array(kk)) * 2 );
    disp(sprintf('Checking %d th sin coef : ',kk-1));
    disp( coefs.sine(kk-1) + imag(array(kk)) * 2 );
end