%%Challenge Week 2
options = optimoptions('fmincon', 'Algorithm', 'SQP', 'Display', 'off', 'OptimalityTolerance', 1e-10, 'StepTolerance', 1e-12, 'ConstraintTolerance', 1e-1);
thetaparams = scenario('nominal');
thetadist = scenario('sample',thetaparams,1000);
RVals = zeros(length(thetaparams),1);
gVals = zeros(length(thetaparams),1);

for i = 1:length(thetadist)
    x = fmincon(@(x) fun(x,thetadist(i,:),params),x,[],[],[],[],[],[],@(x) nonlcon(x,theta,params),options);
    [R1,g1] = uav_range(x1,thetadist(i,:),params);
    RVals(i) = R1;
    gVals(i) = g1;
end

function R = fun(x,theta,params)
[R,g] = uav_range(x,theta,params);
R=-R;
end

function [g,geq] = nonlcon(x,theta,params)
[R,g] = uav_range(x,theta,params);
geq = [];
end
