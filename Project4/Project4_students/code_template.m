close all;
clear; clc;

%% Load Default Img Data
load('blur_data/B.mat');
B=double(B);

% Show Image
figure;
im_l=min(min(B));
im_u=max(max(B));
imshow(B,[im_l,im_u]);
title('Blured Image');

% Vectorize the image (row by row)
b=B';
b=b(:);


%% Validate Test values
load('test_data/A_test.mat');
load('test_data/x_test_exact.mat');
load('test_data/b_test.mat');

%res=||x^*-A^{-1}b||
res=x_test_exact-inv(A_test)*b_test
norm(res)

%% (Now do it with your CG and Matlab's PCG routine!!!)
A_struct = load("blur_data/A.mat");
A = A_struct.A;
load('blur_data/B.mat');
B=double(B);

% Vectorize the image (row by row)
b=B';
b=b(:);

% compute positive-definite augmented transformation matrix Ãx = ˜b
A_tilde = A' * A;
b_tilde = A' * b;

% Problem Variables declaration
alpha = 0.01;
max_iter = 200;
tol = 1e-6;

% Solve the CG with test data
n = size(A, 1);
x0 = zeros(size(b_tilde));

%% MyCG implementation
[x_mycg, rvec_mycg] = myCG(A_tilde, b_tilde, x0, max_iter, tol);

% convert vectorized image in actual image
unblurred_cg_flipped = reshape(x_mycg, [size(B, 1), size(B, 1)]);
unblurred_cg = unblurred_cg_flipped';

% Show Image
figure;
im_l=min(min(x_mycg));
im_u=max(max(x_mycg));
imshow(unblurred_cg,[im_l,im_u]);
title('Unblurred image - myCG');

%% PGC implementation
% Precondition
options.type = 'nofill'; 
options.diagcomp = alpha;
L = ichol(A_tilde,options);

[x,~,~,~,rvec] = pcg(A_tilde, b_tilde, tol, max_iter, L, L');

% result
unblurred_cg_flipped = reshape(x, [size(B, 1), size(B, 1)]);
unblurred_cg = unblurred_cg_flipped';

% Show Image
figure;
im_l=min(min(x));
im_u=max(max(x));
imshow(unblurred_cg,[im_l,im_u]);
title('Unblurred image - pcg');

%% Plot residual vs iteration
figure;
semilogy(rvec_mycg, '-ob');
hold on;
semilogy(rvec, '-or');
hold on;
xlabel('Iteration');
ylabel('Residual Norm (log)');
title('Convergence of Conjugate Gradient Methods of A (log scale)');
legend('myCG', 'PCG', 'Location', 'best'); 
