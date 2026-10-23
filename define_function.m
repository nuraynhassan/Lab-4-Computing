clc;
clear;


%parameters
rho = 1.225;
Clnot = .247;
CMnot = .1;
deltaCl = .6;
V = 30;
Clalpha = 6;
CMalpha = -1.3;
alphap = .05;
S = 16.2;
Cldelta = .43;
CMdelta = -1.28;
W = 11346;

params = [rho, Clnot, CMnot, deltaCl, V, Clalpha, CMalpha, alphap, S, Cldelta, CMdelta, W];

%tolerance
tol = 1e-6;

f = @(alpha, deltae) lift_error(alpha, deltae, params);

plot_contours(1, f);
