A = 1;
T = 10;
t0 = 2;

N = 51;

x = A * ones(1,N);
t = linspace(0,T,N+1);
t = t(1:end-1);

ind_t0 = find( t > t0 );
x(ind_t0) = 0;
%  x(ind_t0) = zeros(size(ind_t0));

figure;
plot(t,x)

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

xfr_right = real(xf((N+1)/2+1:N));
xfr_left  = real(xf((N+1)/2-1:-1:1));

disp('Check: fft coef real parts evenness');
disp(norm(xfr_right-xfr_left))

xfi_right = imag(xf((N+1)/2+1:N));
xfi_left  = imag(xf((N+1)/2-1:-1:1));

disp('Check: fft coef imag parts evenness');
disp(norm(xfi_right+xfi_left))

