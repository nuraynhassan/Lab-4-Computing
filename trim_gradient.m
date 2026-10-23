function G = trim_gradient(alpha, delta_e, params)
syms a d
q = 0.5*params(1)*params(5)^2;
deltaCl = params(4)*exp(-(a/params(8))^2);
Cl = params(2) + params(6)*a + params(10)*d + deltaCl;
Cm = params(3) + params(7)*a + params(11)*d;
f = ((q*params(9)*Cl-params(12))/params(12))^2+Cm;
dfda = diff(f,a);
dfdd = diff(f,d);

G = [subs(dfda, {a,d}, {alpha, delta_e});
    subs(dfdd),{a,d},{alpha,delta_e}];

end