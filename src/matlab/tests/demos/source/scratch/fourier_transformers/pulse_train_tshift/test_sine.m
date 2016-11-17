T = 1;
N = 51;

%  ch_time = 'correct';
ch_time = 'wrong';

switch lower(ch_time)
    case 'correct'
        t = linspace(0,T,N+1);
        t = t(1:end-1);
    case 'wrong'
        t = linspace(0,T,N);
    otherwise
        error('No such choice for time.');
end

x = sin(2*pi*t);

xf = fft(x) / numel(x);
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
