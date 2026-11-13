function [position, path] = Gradient_descent(g, initial_guess, tol, maxit, f, l_init, rho, mu1)

position = initial_guess;
path = position;

for k = 1:maxit
    grad = g(position);
    fx   = f(position);

    %line search
    l = l_init;
    while f(position - l*grad) > fx - mu1 * l * (grad' * grad)
        l = rho * l;
        if l < 1e-16
            break; 
        end
    end

    newPosition = position - l * grad;
    path(:, end+1) = newPosition;


    if norm(newPosition - position) < tol
        position = newPosition;
        break;
    end
    position = newPosition;
end
end