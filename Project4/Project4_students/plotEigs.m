data_A=load("test_data/A_test.mat")

A = data_A.A_test;

eigvals = eig(A) % Compute eigenvalues

% Plot in linear scale
figure;
plot(eigvals, '-o');
xlabel('Index of Eigenvalue');
ylabel('Eigenvalue');
title('Eigenvalues');
grid on;

% Plot in logarithmic scale
figure;
semilogy(eigvals, '-o');
xlabel('Index of Eigenvalue');
ylabel('Eigenvalue');
title('Eigenvalues (Log Scale)');
grid on;

% Compute the condition number
cond_num = cond(A);
fprintf('Condition number of A: %d\n', cond_num);