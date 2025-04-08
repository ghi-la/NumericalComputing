%% Problem setup

% Cargo type weights for each compartment
cargo_weights = [16, 32, 40, 28];  % Weight coefficients per cargo (Cargo 1, 2, 3, 4)
max_weights = [18, 32, 25, 17];    % Maximum weight limits per compartment

% Cargo type volumes for each compartment
cargo_volumes = [320, 500, 630, 125];  % Volume coefficients per cargo
max_volumes = [11830, 22552, 11209, 5870]; % Maximum volume limits per compartment

% Define profit values for each cargo type
cargo_profits = [135, 200, 410, 520];

% Apply bonus multipliers based on compartment (10%, 20%, 30%...)
bonus_multipliers = kron(cargo_profits, [1, 1.1, 1.2, 1.3]);

%% Create Constrain Matrix

% Weight constraints (one for each compartment)
weight_constraint_matrix = kron(ones(1, 4), eye(4)); 

% Volume constraints (one for each compartment)
volume_constraint_matrix = kron(cargo_volumes, eye(4)); 

% Cargo availability constraints (one for each cargo)
availability_constraint_matrix = kron(eye(4), ones(1, 4));

% Combine all constraints into a single matrix A
constraint_matrix = [weight_constraint_matrix; volume_constraint_matrix; availability_constraint_matrix];

%% Create RHS
% Combine all constraint limits
rhs_constraints = [max_weights, max_volumes, cargo_weights]';

%% Constrain sign
% Sign for maximization (<= -> -1)
constraint_sign = -ones(1, size(constraint_matrix, 1));

%% Solve the optimization problem using the simplex method
[optimal_profit, basic_solution, basic_indices] = simplex('max', constraint_matrix, rhs_constraints, bonus_multipliers, constraint_sign);

%% Plotting results
distribution_matrix = zeros(4, 4);

% Populate the distribution matrix using the basic solution and basic indices
for i = 1:length(basic_indices)
    if basic_indices(i) <= 16
        compartment_idx = ceil(basic_indices(i) / 4);  % Find the compartment index
        cargo_idx = mod(basic_indices(i) - 1, 4) + 1; % Find the cargo index
        distribution_matrix(compartment_idx, cargo_idx) = basic_solution(i);
    end
end

figure;
bar(distribution_matrix', 'stacked');
title('Cargo Distribution by Compartment');
xlabel('Compartment Number');
ylabel('Cargo Weight (Tons)');
legend('C_1', 'C_2', 'C_3', 'C_4', 'Location', 'best');
grid on;

xticks(1:4); % Specify the positions of the compartments (1, 2, 3, 4)
% Set the custom labels according to exercise
xticklabels({'S_1', 'S_2', 'S_3', 'S_4'}); 