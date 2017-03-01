N = 5;
x = 5  * rand(N,1);
y = 10 * rand(1,N);

%  disp(x + y)

B = x * y;
disp('Matrix B :')
disp(B)

for kk = 2:size(B,2)
    disp( sprintf( 'Ratios of col %d elements to col 1 elements :' , kk ) );
    disp( B(:,kk) ./ B(:,1) )
end

disp('Rank of Matrix B :')
disp( rank(B) )
