function [x, rvec] = myCG(A, b, x0, max_itr, tol)
    % myCG - Conjugate Gradient solver to solve the system A*x = b
    %
    % Inputs:
    %   A        - The matrix (symmetric positive-definite)
    %   b        - The right-hand side vector
    %   x0       - Initial guess for the solution
    %   max_itr  - Maximum number of iterations
    %   tol      - Convergence tolerance (stopping criterion)
    %
    % Outputs:
    %   x        - Solution vector (approximation to the solution of A*x = b)
    %   rvec     - Residual norm at each iteration

    x = x0; % Initial guess
    r = b - A * x; % Initial residual
    d = r; % Initial search direction
    rho_old = dot(r,r); % Initial value of ⟨r, r⟩
    norm_b = norm(b); % Precompute norm of b for relative residual
    rvec = zeros(max_itr, 1); % Initialize the vector used to store the residual norms

    % Main iterative loop
    for i = 1:max_itr
        s = A * d; 
        alpha = rho_old / dot(d,s); 
        x = x + alpha * d; 
        r = r - alpha * s; 
        rho_new = dot(r, r); % Compute new residual norm squared
        
        rvec(i) = sqrt(rho_new) / norm_b; % Compute the relative residual norm
        
        % Check for convergence
        if rvec(i) < tol
            fprintf('Converged at iteration %d with relative residual norm %.2e\n', i, rvec(i));
            rvec = rvec(1:i); % Trim rvec to include only the computed residuals
            return; % Exit if converged
        end

        % Update the search direction
        beta = rho_new / rho_old; 
        d = r + beta * d; % Update the direction
        rho_old = rho_new; % Update old residual norm for next iteration
    end
    
    % If the loop ends without convergence, display a message
    fprintf('Reached maximum iterations without convergence. Final relative residual norm: %.4e\n', rvec(end));
end
