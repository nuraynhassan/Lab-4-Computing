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

