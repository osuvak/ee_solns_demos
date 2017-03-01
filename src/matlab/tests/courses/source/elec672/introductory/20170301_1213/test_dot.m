N = 8;

x = (1:N)';
y = (N:-1:1)';

disp(dot(x,y))
disp(sum(x .* y))
disp(x' * y)
disp(y' * x)

temp = cumsum( x .* y );
disp( temp(end) )