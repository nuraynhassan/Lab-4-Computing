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


% Call minsearch with f, x0, and opts with x0 in radians
dtr = pi / 180;

f = @(alpha, deltae) lift_error(alpha, deltae, params);
x0 = [10*dtr, -5*dtr];
opts = optimset('TolX', 1e-12, "TolFun", 1e-16);

[xstar, fstar] = fminsearch(@(xy) f(xy(1), xy(2)), x0, opts);

%get xstar in radians

xstarrad = (1 / dtr) .* xstar

disp('fstar = ')
disp(fstar)

