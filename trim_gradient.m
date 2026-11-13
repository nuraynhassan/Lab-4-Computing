function G = trim_gradient(alpha, delta_e, params)

q   = 0.5 * params.rho * params.V^2;
p   = params.deltaCl * exp(-(alpha/params.alphap)^2);
CL  = params.Clnot + params.Clalpha*alpha + params.Cldelta*delta_e + p;
CM  = params.CMnot + params.CMalpha*alpha + params.CMdelta*delta_e;
eL  = (q*params.S*CL - params.W) / params.W;

dCL_da = params.Clalpha + p * (-2*alpha / params.alphap^2);

dfda = 2*eL*(q*params.S/params.W)*dCL_da   + 2*CM*params.CMalpha;
dfdd = 2*eL*(q*params.S/params.W)*params.Cldelta + 2*CM*params.CMdelta;

G = [dfda; dfdd];
end


