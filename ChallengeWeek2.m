%%Challenge Week 2
clc;clear;close all;
options = optimoptions('fmincon', 'Algorithm', 'SQP', 'Display', 'off', 'OptimalityTolerance', 1e-10, 'StepTolerance', 1e-12, 'ConstraintTolerance', 1e-1);
thetaparams = scenario('nominal');
thetadist = scenario('sample',thetaparams,1000);
RVals = zeros(length(thetadist),1);
gVals = zeros(length(thetadist),4);
gdpot1 = zeros(length(thetadist),1);
xvec = zeros(length(thetadist),4);
score = zeros(length(thetadist),1);
x = [0.5, 12, 4, 20];

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

%Find R and G values for every theta vector
for i = 1:length(thetadist)
    x = fmincon(@(x) fun(x,thetadist(i,:),params),x,[],[],[],[],[],[],@(x) nonlcon(x,thetadist(i,:),params),options);
    xvec(i,:) = x;
    [R1,g1] = uav_range(x,thetadist(i,:),params);
    RVals(i) = R1;
    gVals(i,:) = g1;
    g1nonneg = g1(g1 >=0);
    gdot1 = sum(g1);
    score(i) = RVals(i) - gdot1 - 300;
end

[maxscore, maxidx] = max(score);
maxx = xvec(maxidx,:);

evaluate(x, 'nurayn.hassan@colorado.edu');

function R = fun(x,theta,params)
[R,g] = uav_range(x,theta,params);
R=-R;
end

function [g,geq] = nonlcon(x,theta,params)
[R,g] = uav_range(x,theta,params);
geq = [];
end
