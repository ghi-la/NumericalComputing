%% Problem 1
x = 0:50;  % Range of x

% Constrains
y1 = 20 - (1/2) * x;
y2 = 30 - x;
y3 = 24 - (2/3) * x;

% Plot the functions
figure(1);
hold on;
plot(x, y1, 'r-', 'LineWidth', 2);
plot(x, y2, 'g-', 'LineWidth', 2);
plot(x, y3, 'b-', 'LineWidth', 2);

% Add labels and legend
xlabel('x');
ylabel('y');
title('Plots of Problem 1');
legend('y1 = 20 - 1/2 * x', 'y2 = 30 - x', 'y3 = 24 - 2/3 * x', 'Location', 'Best');

% Set intersection points (computed using geogebra)
i1 = [24 8];
i2 = [36 0];
i3 = [40 0];

% Fill the feasible area
x_fill = [i1(1), i2(1), i3(1)];
y_fill = [i1(2), i2(2), i3(2)];
fill(x_fill, y_fill, 'x', 'DisplayName', 'Feasible area');

% Set axis limits
xlim([0 45]);
ylim([0 45]);

grid on;
hold off;
%% Problem 2
x = 0:290;  % Range of x

% Constrains
y1 = 175 - (5/8) * x;
y2 = 265 - x;

% Plot the functions
figure(2);
hold on;
plot(x, y1, 'r-', 'LineWidth', 2);
plot(x, y2, 'g-', 'LineWidth', 2);

% Add labels and legend
xlabel('x');
ylabel('y');
title('Plots of Problem 2');
legend('y1 = 175 - (5/8) * x', 'y2 = 265 - x', 'Location', 'Best');

% Set intersection points (computed using geogebra)
i1 = [0 175];
i2 = [240 25];
i3 = [265 0];
i4 = [0 0];

% Fill the feasible area
x_fill = [i1(1), i2(1), i3(1), i4(1)]; 
y_fill = [i1(2), i2(2), i3(2), i4(2)]; 
fill(x_fill, y_fill, 'x', 'DisplayName', 'Feasible area'); 

% Set axis limits
xlim([0 290]);
ylim([0 200]);

grid on;
hold off;