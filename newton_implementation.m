clc;
clear;
close all;

%parameters
params.rho = 1.225;
params.Clnot = .247;
params.CMnot = .1;
params.deltaCl = .6;
params.V = 30;
params.Clalpha = 6;
params.CMalpha = -1.3;
params.alphap = .05;
params.S = 16.2;
params.Cldelta = .43;
params.CMdelta = -1.28;
params.W = 11346;

%fixed for hessian
params.q       = 0.5 * params.rho * params.V^2;
params.CL0     = params.Clnot;
params.CLalpha = params.Clalpha;
params.CLdelta = params.Cldelta;


l_init = 1;      
rho = 0.5;   
mu1 = 1e-4;
tol = 1e-6;
maxit = 1000;

f_ad = @(alpha, deltae) lift_error(alpha, deltae, params);
f = @(x) f_ad(x(1), x(2));                                          
g = @(x) trim_gradient(x(1), x(2), params);
h = @(x) trim_hessian(x(1), x(2), params);  

[posN, pathN] = newtons_method(g, [0.2; 0.1], tol, maxit, f, h, l_init, rho, mu1);

plot_contours(1, f_ad); 
hold on
plot(rad2deg(pathN(1,:)), rad2deg(pathN(2,:)), 'c.-', 'DisplayName', 'Newton');

[posB, pathB] = Gradient_descent(g, [0.2; 0.1], tol, maxit, f, 0.045, rho, mu1);
plot(rad2deg(pathB(1,:)), rad2deg(pathB(2,:)), 'm.-', 'DisplayName', 'Gradient');

xlabel('\alpha [deg]');
ylabel('\delta_e [deg]');
title('1.5: Gradient Descent vs Newton''s Method');
legend('show', 'Location', 'northeast');

opts = optimset('TolX', 1e-12, 'TolFun', 1e-16);
x_star = fminsearch(f, [0.2; 0.1], opts);
x_star = x_star(:);    

plot(rad2deg(x_star(1)), rad2deg(x_star(2)), 'wp', 'MarkerSize', 6, 'DisplayName', 'fminsearch optimum');

hold off




iters_GD = size(pathB, 2) - 1;
iters_N = size(pathN, 2) - 1;

dist_GD = norm(posB - x_star);
dist_N = norm(posN - x_star);

Method = ["Gradient Descent"; "Newton"];
alpha_deg = rad2deg([posB(1); posN(1)]);
deltae_deg = rad2deg([posB(2); posN(2)]);
Iterations = [iters_GD; iters_N];
Dist_rad = [dist_GD; dist_N];

disp(table(Method, alpha_deg, deltae_deg, Iterations, Dist_rad));


fprintf('\nReference optimum: alpha* = %.4f deg, delta_e* = %.4f deg, f* = %.3e\n', rad2deg(x_star), f(x_star));