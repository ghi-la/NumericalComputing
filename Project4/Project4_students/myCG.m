function [x, rvec] = myCG(A, b, x0, max_itr, tol)
    x = x0; % Initial guess of the solution vector (approximation of A*x = b)
    r = b - A * x; % Initial residual
    d = r; % Initial search direction
    rho_old = dot(r,r); % Initial value of ⟨r, r⟩
    norm_b = norm(b); % Precompute norm of b for relative residual
    rvec = zeros(max_itr, 1); % Initialize the vector used to store the residual norms

    for i = 1:max_itr
        s = A * d; 
        alpha = rho_old / dot(d,s); 
        x = x + alpha * d; 
        r = r - alpha * s; 
        rho_new = dot(r, r); % Compute new residual norm
        
        rvec(i) = sqrt(rho_new) / norm_b; % Compute the relative residual norm
        
        % Check for convergence
        if rvec(i) < tol
            fprintf('Converged at iteration %d with relative residual norm %d\n', i, rvec(i));
            rvec = rvec(1:i); % Trim rvec to include only the computed residuals
            return; % Exit if converged
        end

        beta = rho_new / rho_old; 
        d = r + beta * d;
        rho_old = rho_new
    end
    
    fprintf('No convergence; reached max_itr. Final relative residual norm: %d\n', rvec(end));
end
