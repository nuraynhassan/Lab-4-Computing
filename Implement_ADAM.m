
clear; clc; close all;

% Parameters from part 1 of the lab
params = [1.225, 0.247, 0.1, 0.6, 30, 6, -1.3, ...
          0.05, 16.2, 0.43, -1.28, 11346];

% Given initial condition
x0 = [0.2; 0.1];

% Gradient
g = @(x) trim_gradient(x(1), x(2), params);

% Implement ADAM function
[position,path] = adam(g,x0,1e-6,1000,0.02,0.3,0.99,1e-8);

% Number of iterations
iterations = size(path,2) - 1;

alpha = rad2deg(position(1));
delta_e = rad2deg(position(2));

q = 0.5*params(1)*params(5)^2;

f = @(x) ((q*params(9)*(params(2) + params(6)*x(1) + ...
    params(10)*x(2) + params(4)*exp(-(x(1)/params(8))^2)) ...
    - params(12))/params(12))^2 + ...
    (params(3) + params(7)*x(1) + params(11)*x(2))^2;

% Find reference optimum from Week 1
opts = optimset('TolX',1e-12,'TolFun',1e-16);

x0_ref = [deg2rad(10); deg2rad(-5)];
xstarrad = fminsearch(f,x0_ref,opts);

distance = norm(position-xstarrad);

% Output results
fprintf('Alpha: %.4f deg\n',alpha);
fprintf('Delta_e: %.4f deg\n',delta_e);
fprintf('Iterations: %d\n',iterations);
fprintf('Distance: %.8e rad\n',distance);

a = linspace(-0.1,0.4,200);
d = linspace(-0.4,0.2,200);

[A,D] = meshgrid(a,d);
Z = arrayfun(@(a,d) f([a;d]),A,D);

% Contour plot
figure;
contour(rad2deg(A),rad2deg(D),Z,40);
hold on;

plot(rad2deg(path(1,:)),rad2deg(path(2,:)), ...
    'r.-','LineWidth',1.5);

plot(rad2deg(xstarrad(1)),rad2deg(xstarrad(2)), ...
    'ko','MarkerFaceColor','k');

xlabel('Angle of Attack (deg)');
ylabel('Elevator Deflection (deg)');
title('ADAM Optimization Path');
legend('Contours','ADAM Path','Reference Optimum');
grid on;
