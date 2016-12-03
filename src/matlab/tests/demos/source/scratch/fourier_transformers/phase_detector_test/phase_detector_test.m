close all
clear all

format long e

VDD = 5;
no_period_dupl = 2;

phi = pi / 5;

N = 101;
T = 10;

no_periods = 3;

t = linspace( 0 , no_periods * T , 1 + no_periods * N );
x = [ ones(1,floor(N/2)) -ones(1,N-floor(N/2)) ];

x_multi = [];
for kk = 1:no_periods
    x_multi = [ x_multi x ];
end
x_multi = [ x_multi x(1) ];

w0 = 2 * pi / T;

figure;
subplot(2,1,1)
stem(t,x_multi,'filled')
title('Signal vs. time(sec)')
subplot(2,1,2)
stem(w0*t,x_multi,'filled')
title('Signal vs. phase(rad/sec)')

no_samples_inside_phi = ceil( N * phi / 2 / pi );

x_shifted = [ x(no_samples_inside_phi+1:end) x(1:no_samples_inside_phi) ];

x_shifted_multi = [];
for kk = 1:no_periods
    x_shifted_multi = [ x_shifted_multi x_shifted ];
end
x_shifted_multi = [ x_shifted_multi x_shifted(1) ];

figure;
subplot(2,1,1)
stem(t,x_shifted_multi,'filled')
title('Shifted Signal vs. time(sec)')
subplot(2,1,2)
stem(w0*t,x_shifted_multi,'filled')
title('Shifted Signal vs. phase(rad/sec)')

x_out = zeros( size(x) );
for kk = 1:numel(x_out)
    if sign(x(kk)) * sign(x_shifted(kk)) > 0
    else
        x_out(kk) = VDD;
    end
end

x_out_multi = [];
for kk = 1:no_periods
    x_out_multi = [ x_out_multi x_out ];
end
x_out_multi = [ x_out_multi x_out(1) ];

figure;
subplot(2,1,1)
stem(t,x_out_multi,'filled')
title('Phase Comparator Output vs. time(sec)')
subplot(2,1,2)
stem(w0*t,x_out_multi,'filled')
title('Phase Comparator Output vs. phase(rad/sec)')

x_out_f = fft(x_out) / numel(x_out);
x_out_f = [ x_out_f((1+numel(x_out_f))/2+1:end) x_out_f(1:(1+numel(x_out_f))/2) ];

x_out_f([ 1:(1+numel(x_out_f))/2-(1+no_period_dupl) (1+numel(x_out_f))/2+(1+no_period_dupl):end ]) = 0 + 1j * 0;

x_out_f = [ x_out_f((1+numel(x_out_f))/2:end)  x_out_f(1:(1+numel(x_out_f))/2-1) ];
x_out_filtered = real( numel(x_out_f) * ifft(x_out_f) );

x_out_filtered_multi = [];
for kk = 1:no_periods
    x_out_filtered_multi = [ x_out_filtered_multi x_out_filtered ];
end
x_out_filtered_multi = [ x_out_filtered_multi x_out_filtered(1) ];

figure;
subplot(2,1,1)
stem(t,x_out_filtered_multi,'filled')
title('Filtered Phase Detector Output vs. time(sec)')
subplot(2,1,2)
stem(w0*t,x_out_filtered_multi,'filled')
title('Filtered Phase Detector Output vs. phase(rad/sec)')
