clc;
clear;

%params
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

%objective function
f = @(alpha, deltae) lift_error(alpha, deltae, params);

alpha = 0.2;
delta = 0.1;

%difference
G  = trim_gradient(alpha, delta, params);
h  = sqrt(eps) * abs([alpha; delta]);
df = [(f(alpha + h(1), delta) - f(alpha, delta)) / h(1);
      (f(alpha, delta + h(2)) - f(alpha, delta)) / h(2)];

disp(table(G, df, abs(G - df), 'VariableNames', {'Analytic','Finite','Error'}))