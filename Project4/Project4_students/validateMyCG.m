data_A=load("test_data/A_test.mat")
data_b=load("test_data/b_test.mat")

A = data_A.A_test;
b = data_b.b_test;

% Validate dimensions
n = size(A, 1);
assert(length(b) == n, 'Dimension mismatch: A and b');

x0 = zeros(n, 1); % Initial guess set to a random vector
% To ensure the condition that, as said in the document: 
% "it produces the exact solution after a finite number of iterations, 
% which is not larger than the size of the matrix" I set the number of max
% iterations as it is less than the size of A
max_itr = length(A)-1; 
tol = 1e-6;

[x, rvec] = myCG(A, b, x0, max_itr, tol);

% Plot residuals vs iterations
figure;
plot(0:length(rvec)-1, rvec, '-o');
xlabel('Iteration');
ylabel('Residual Norm');
title('Convergence of Conjugate Gradient Method');

% Display the final solution and residual
disp('Final solution vector x:');
disp(x);
disp('Final residual norm:');
disp(rvec(end));