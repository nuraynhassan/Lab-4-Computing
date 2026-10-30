function [R,g] = uav_range(x, theta, params)
g = zeros(size(theta,1),4);

for n = 1 : size(theta,1)
mw = params.kw*(x(1)^1.2)*x(2)^0.9;
m = theta(n,1) + x(3) + params.mfix + mw;
W = 9.81*(m);
q = 0.5*params.rho*x(4)^2;
e=1.78*(1-0.045*x(2)^0.68)-0.64;
D=q*x(1)*theta(n,2) + W^2/(q*x(1)*pi*e*x(2));
r = x(4)/params.Veta;
eta = params.etamax*2*r/(1+r^2);
E=(1-params.fres)*theta(n,3)*x(3)*eta/(D*x(4));
R=E*x(4)*(1-theta(n,4)^2/x(4)^2);

g(n,1) = params.kstall*sqrt(2*W/(params.rho*x(1)*params.CLmax))-x(4);
g(n,2) = params.RCmin-(eta*params.Pmax - D*x(4))/W;
g(n,3) = sqrt(x(2)*x(1))-params.bmax;
g(n,4) = m -params.mmax;
end

end