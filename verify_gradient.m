function verify_gradient(G,params,alpha,delta,f)
h = [sqrt(2.2e-16)*alpha; sqrt(2.2e-16)*delta];
df = [(f(alpha,delta) + h(1)*alpha - f(alpha,delta))/h(1);
    (f(alpha,delta) + h(2)*delta - f(alpha,delta))/h(2)];

gradientcheck = abs(G-df);
if any(gradientcheck > 1e-6)
    warning('Gradient check failed: maximum error is %g.', max(gradientcheck));
end
end
