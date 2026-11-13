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


tol = 1e-6;  maxit = 1000;
rho = 0.5;   mu1 = 1e-4;

f_ad = @(alpha, deltae) lift_error(alpha, deltae, params);
f = @(x) f_ad(x(1), x(2));                                          
g = @(x) trim_gradient(x(1), x(2), params);


[posA, pathA] = Gradient_descent(g, [0; 0], tol, maxit, f, 0.01, rho, mu1);
[posB, pathB] = Gradient_descent(g, [0.2; 0.1], tol, maxit, f, 0.045, rho, mu1);


plot_contours(1, f_ad); 
hold on
plot(rad2deg(pathA(1,:)), rad2deg(pathA(2,:)), 'r.-', 'DisplayName', 'x0 = [0, 0]');
plot(rad2deg(pathB(1,:)), rad2deg(pathB(2,:)), 'm.-', 'DisplayName', 'x0 = [0.2, 0.1]');
legend show

rtd = 180 / pi;
disp("Path A:")
disp(posA * rtd)
disp(lift_error(posA(1), posA(2), params))

disp("Path B:")
disp(posB * rtd)
disp(lift_error(posB(1), posB(2), params))

