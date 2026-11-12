
function [position, path] = adam(g, initial_guess, tol, max_iterations, l, gamma_v, gamma_s, epsilon)

x = initial_guess(:);

v = zeros(length(x), max_iterations+1);
s = zeros(length(x), max_iterations+1);

v_hat = zeros(length(x), max_iterations+1);
s_hat = zeros(length(x), max_iterations+1);

path = x;

for k = 1:max_iterations

    grad = g(x);

    v(:,k+1) = gamma_v*v(:,k) + (1-gamma_v)*grad;

    s(:,k+1) = gamma_s*s(:,k) + (1-gamma_s)*(grad.^2);

    v_hat(:,k+1) = v(:,k+1)/(1-gamma_v^k);

    s_hat(:,k+1) = s(:,k+1)/(1-gamma_s^k);

    x_new = x - l*(v_hat(:,k+1)./(epsilon + sqrt(s_hat(:,k+1))));

    path(:,end+1) = x_new;

    if norm(x_new-x) < tol
        x = x_new;
        break
    end

    x = x_new;

end

position = x;

disp(k)

end
