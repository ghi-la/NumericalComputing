x1 = 0:3;  % Range of x

% Constrains
y1 = (12 - 4*x1) / 3;  % Constraint 1: 4x1 + 3x2 ≤ 12
y2 = 8 - 4*x1;         % Constraint 2: 4x1 + x2 ≤ 8
y3 = (8 - 4*x1) / 2;   % Constraint 3: 4x1 + 2x2 ≤ 8

% Plot the functions
figure(1);
hold on;
plot(x1, y1, 'r-', 'LineWidth', 2);
plot(x1, y2, 'g-', 'LineWidth', 2);
plot(x1, y3, 'b-', 'LineWidth', 2);

% Add labels and legend
xlabel('x_1');
ylabel('x_2');
title('Plots of Constraints for Linear Problem');
legend('4x_1 + 3x_2 ≤ 12', '4x_1 + x_2 ≤ 8', '4x_1 + 2x_2 ≤ 8', 'Location', 'Best');

% Set intersection points (computed using geogebra)
i1 = [0, 4];   
i2 = [2, 0]; 
i3 = [0, 0]; 

% Fill the feasible area
x_fill = [i1(1), i2(1), i3(1)];
y_fill = [i1(2), i2(2), i3(2)];
fill(x_fill, y_fill, 'x', 'DisplayName', 'Feasible area');

% Set axis limits
xlim([0 4]);
ylim([0 9]);

grid on;
hold off;
