clc;
clear;


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


%tolerance
tol = 1e-6;

f = @(alpha, deltae) lift_error(alpha, deltae, params);

plot_contours(1, f);