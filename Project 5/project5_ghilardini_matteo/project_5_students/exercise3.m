%% Problem setup
% Coefficients of constrains
c1 = [4,3];
c2 = [4,1];
c3 = [4,2];

coeff = [3,4]; % Coefficients of the Objective function

%% Create Constrain Matrix
constraint_matrix = [c1; c2; c3]

%% Create RHS
rhs_constraints = [12, 8, 8]';

%% Constrain sign
% Sign for maximization (<= -> -1)
constraint_sign = -ones(1, size(constraint_matrix, 1));

%% Solve the optimization problem using the simplex method
[optimal_profit, basic_solution, basic_indices] = simplex('max', constraint_matrix, rhs_constraints, coeff, constraint_sign);