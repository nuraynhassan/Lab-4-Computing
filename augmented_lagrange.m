
function [position, path] = augmented_lagrange(g, initial_guess, tol, max_iterations, f)

x = initial_guess(:);
lambda = zeros(2,1);
mu = 10;

alpha_max = deg2rad(10);
delta_max = deg2rad(-5);

c = @(x) [x(1)-alpha_max; x(2)-delta_max];

path = x;

for k = 1:20

    grad_phi = @(x) g(x) + max(0,lambda + mu*c(x));

    [x_new, inner_path] = adam(grad_phi,x,tol,max_iterations, ...
        0.0005,0.7,0.99,1e-8);

    path = [path,inner_path(:,2:end)];

    lambda = max(0,lambda + mu*c(x_new));

    step = norm(x_new-x);
    violation = max([0;c(x_new)]);

    x = x_new;

    if step < 5*tol && violation <= tol
        break
    end

    mu = 4*mu;

end

position = x;

end
