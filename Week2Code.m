clc;clear all; close;
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


params.rho = rho;
params.Clnot = Clnot;
params.CMnot = CMnot;
params.deltaCl = deltaCl; 
params.V = V;
params.Clalpha = Clalpha;
params.CMalpha = CMalpha;
params.alphap = alphap;
params.S = S;
params.Cldelta = Cldelta;
params.CMdelta = CMdelta;
params.W = W;
params.g = 9.81;
params.etamax = 0.70;
params.kstall = 1.25;
params.mmax = 15;
params.rho = 1.225;
params.Veta = 18;
params.Pmax = 500;
params.mfix = 1.5;
params.fres = 0.20;
params.RCmin = 2.0;
params.kw = 0.35;
params.CLmax = 1.3;
params.bmax = 4.0;

lower_bounds = [0.3 4 2 8];
upper_bounds = [3 20 10 40];

%params.a = [rho, Clnot, CMnot, deltaCl, V, Clalpha, CMalpha, alphap, S, Cldelta, CMdelta, W];

%params.b = [9.81,0.70,1.24,15,1.225,18,500,1.5,0.2,2,0.35,1.3,4];

x = [0.5, 12, 4, 20];
theta = [2.0, 0.0325, 648000, 4];

[R,g] = uav_range(x,theta,params);

function R = fun(x,theta,params)
[R,g] = uav_range(x,theta,params);
R=-R;
end

function [g,geq] = nonlcon(x,theta,params)
[R,g] = uav_range(x,theta,params);
geq = [];
end
options = optimoptions('fmincon', 'Algorithm', 'SQP', 'Display', 'off', 'OptimalityTolerance', 1e-10, 'StepTolerance', 1e-12, 'ConstraintTolerance', 1e-10, 'MaxIterations', 500, 'MaxFunctionEvaluations', 5000);

x1 = fmincon(@(x) fun(x,theta,params),x,[],[],[],[],lower_bounds,upper_bounds,@(x) nonlcon(x,theta,params),options);

[R1,g1] = uav_range(x1,theta,params)


%%Generate and plot theta different distributions
thetaparams = scenario('nominal');
theta = scenario('sample',thetaparams,1000);

plot(theta(:,1));
xlabel('mass of payload (kg)');
figure;
plot(theta(:,2));
xlabel('C_D0 Distribution');
figure;
plot(theta(:,3));
xlabel('e_b (J/kg)');
figure;
plot(theta(:,4));
xlabel('V_w (m/s)');
