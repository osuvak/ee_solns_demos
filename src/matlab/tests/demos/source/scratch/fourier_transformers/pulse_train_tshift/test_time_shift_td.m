A = 2;
T = 10.7;
t0 = 4.3;

dt_min = 0.10;
dt_max = 0.90;

N_init = 81;
N_max = 501;
flag_found = 0;

no_min_ON = 11;

if t0/T < dt_min
    error('Duty cycle percentage is too small.')
end
if t0/T > dt_max
    error('Duty cycle percentage is too big.')
end

for N=N_init:2:N_max
    t = linspace(0,T,N+1);
    t = t(1:end-1);
    
    ind_t0 = find( t <= t0 );
    
    logic_val_1 = (mod(numel(ind_t0),2) == 1);
    logic_val_2 = ( numel(ind_t0) >= no_min_ON );
    
    if logic_val_1 && logic_val_2
        flag_found = 1;
        break;
    end
end

if ~flag_found
    error('N could not be set given the specs.');
end

x = A * zeros(1,N);
x(ind_t0) = A * 1;

figure;
stem(t,x,'filled')
title('Original Signal')

no_entries_tshift = (numel(ind_t0)+1)/2;
x_tshifted = [ x(no_entries_tshift:end) x(1:no_entries_tshift-1) ];

figure;
stem(t,x_tshifted,'filled')
title('Time-Shifted Signal')

xf = fft(x_tshifted) / numel(x_tshifted);
xf = [ xf((N+1)/2+1:N) xf(1:(N+1)/2) ];

figure;
subplot(2,1,1)
stem(-(N-1)/2:(N-1)/2,real(xf),'filled')
title('FFT coefs - real parts')
grid on;
subplot(2,1,2)
stem(-(N-1)/2:(N-1)/2,imag(xf),'filled')
title('FFT coefs - imag parts')
grid on;

xf_orig = xf;
for kk = 1:(N-1)/2
    tmp = exp( - 1j*2*pi/T * kk * t0/2 );
    xf_orig((N+1)/2+kk) = xf_orig((N+1)/2+kk) * tmp;
    tmp = 1 / tmp;
    xf_orig((N+1)/2-kk) = xf_orig((N+1)/2-kk) * tmp;
end

figure;
subplot(2,1,1)
stem(-(N-1)/2:(N-1)/2,real(xf_orig),'filled')
title('FFT coefs - reverse tshifted - real parts')
grid on;
subplot(2,1,2)
stem(-(N-1)/2:(N-1)/2,imag(xf_orig),'filled')
title('FFT coefs - reverse tshifted - imag parts')
grid on;

xf_orig = [ xf_orig((N+1)/2:N) xf_orig(1:(N-1)/2) ];
x_orig = ifft( N * xf_orig );
x_orig = real(x_orig);

figure;
%  stem(t,x_orig,'filled')
plot(t,[x_orig ; x])
title('Original Signal - reconstructed')
grid on;