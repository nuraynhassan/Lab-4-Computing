function [position, path] = newtons_method(g, initial_guess, tol, maxit, f, h, l_init, rho, mu1)

position = initial_guess;
path = position;

for k = 1:maxit
    grad = g(position);
    H    = h(position);
    fx   = f(position);

    %Newton direction
    d = -H \ grad;
    if grad' * d >= 0
        d = -grad;
    end

    %back tracking
    l = l_init;
    while f(position + l*d) > fx + mu1 * l * (grad' * d)
        l = rho * l;
        if l < 1e-16, break; end
    end

    
    newPosition = position + l * d;
    path(:, end+1) = newPosition;


    if norm(newPosition - position) < tol
        position = newPosition;
        break;
    end
    position = newPosition;
end
end