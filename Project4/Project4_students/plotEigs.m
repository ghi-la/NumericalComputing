data_A=load("test_data/A_test.mat")

A = data_A.A_test;

eigvals = eig(A)

figure;
plot(eigvals, '-o');
xlabel('Index of Eigenvalue');
ylabel('Eigenvalue');
title('Eigenvalues');
grid on;

figure;
semilogy(eigvals, '-o');
xlabel('Index of Eigenvalue');
ylabel('Eigenvalue');
title('Eigenvalues (Log Scale)');
grid on;

% Compute the condition number
cond_num = cond(A);
fprintf('Condition number of A: %.2e\n', cond_num);