N = 100;

A = 5 * rand(N);
%  b = 2 * rand(N,1);

%  x1 = A \ b;

[L,U] = lu(A);

%  y = L \ b;
%  x2 = U \ y;

%  disp( norm( x1 - x2 ) / ( ( norm(x1) + norm(x2) ) / 2) )

noEvaluations = 1000;
bVal = 2 * rand( N , noEvaluations );

tic;
x1 = A \ bVal;
toc;

x1new = zeros( size(x1) );
x2    = zeros( size(x1) );

check = zeros(noEvaluations,1);

tic;
for kk = 1:noEvaluations
    x1new(:,kk) = A \ bVal(:,kk); 
end
toc;

tic;
for kk = 1:noEvaluations
    x2(:,kk) = U \ ( L \ bVal(:,kk) ); 
end
toc;

for kk = 1:noEvaluations
    check(kk) = norm( x1(:,kk) - x2(:,kk) ) / ( ( norm(x1(:,kk)) + norm(x2(:,kk)) ) / 2);
end

%  disp(check)