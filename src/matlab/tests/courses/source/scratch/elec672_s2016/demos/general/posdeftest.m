close all
clear all

format long e
rng('shuffle','twister');

N = 3;
L = 5;

A = 2 * L * rand(N) - L;
[Q,R] = qr(A);

disp('Check if Q has orthonormal columns:');
disp(Q'*Q - eye(N));
disp('Check if Q tps is Q inv:');
disp(Q' - inv(Q));

[V,D] = eig(Q);

disp('Check if Q eigenvalues are on the unit circle in the complex plane');
disp(abs(diag(D)) - ones(N,1));

%  eVal = 0.1 + 4 * rand(N,1);
eVal = -0.1 - 4 * rand(N,1); eVal = -eVal;

M = Q * diag(eVal) * Q';
M = 1/2 * (M+M');
disp('Check if pos def M is symmetric:');
disp(M - M');

U = chol(M);
disp('Check Cholesky factor of pos def M:');
disp(U'*U - M);

b = ((1:N)/ N * 2)';
x = U \ ( U' \ b);

disp('Check M x = b soln:');
disp(M * x - b);