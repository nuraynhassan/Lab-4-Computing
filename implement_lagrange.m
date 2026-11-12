
clear; clc; close all;

% Parameters from Week 1
params = [1.225, 0.247, 0.1, 0.6, 30, 6, -1.3, ...
          0.05, 16.2, 0.43, -1.28, 11346];

% Initial condition
x0 = [0.15; -0.1];

% Gradient
g = @(x) trim_gradient(x(1),x(2),params);

q = 0.5*params(1)*params(5)^2;

f = @(x) ((q*params(9)*(params(2)+params(6)*x(1)+ ...
    params(10)*x(2)+params(4)*exp(-(x(1)/params(8))^2)) ...
    -params(12))/params(12))^2 + ...
    (params(3)+params(7)*x(1)+params(11)*x(2))^2;

% Augmented Lagrangian
[position,path] = augmented_lagrange(g,x0,1e-6,1000,f);

% Results
iterations = size(path,2)-1;

alpha = rad2deg(position(1));
delta_e = rad2deg(position(2));

c1 = position(1)-deg2rad(10);
c2 = position(2)-deg2rad(-5);

fprintf('Alpha: %.4f deg\n',alpha);
fprintf('Delta_e: %.4f deg\n',delta_e);
fprintf('Iterations: %d\n',iterations);

fprintf('Alpha constraint residual: %.8e rad\n',c1);
fprintf('Delta constraint residual: %.8e rad\n',c2);

fprintf('Alpha constraint active: %d\n',abs(c1)<1e-6);
fprintf('Delta constraint active: %d\n',abs(c2)<1e-6);

fprintf('Alpha constraint satisfied: %d\n',c1<=0);
fprintf('Delta constraint satisfied: %d\n',c2<=0);

fprintf('Maximum alpha violation: %.8e rad\n', ...
    max(path(1,:)-deg2rad(10)));

fprintf('Maximum delta violation: %.8e rad\n', ...
    max(path(2,:)-deg2rad(-5)));

% Contour plot
a = linspace(-0.1,0.4,200);
d = linspace(-0.4,0.2,200);

[A,D] = meshgrid(a,d);
Z = arrayfun(@(a,d) f([a;d]),A,D);

figure;
contour(rad2deg(A),rad2deg(D),Z,40);
hold on;

plot(rad2deg(path(1,:)),rad2deg(path(2,:)), ...
    'r.-','LineWidth',1.5);

xline(10,'w--','LineWidth',1.5);
yline(-5,'w--','LineWidth',1.5);

plot(alpha,delta_e,'wo','MarkerFaceColor','w');

xlabel('Angle of Attack (deg)');
ylabel('Elevator Deflection (deg)');
title('Augmented Lagrangian Optimization Path');

legend('Contours','Optimization Path', ...
    'Alpha Constraint','Delta Constraint','Final Position');

grid on;
