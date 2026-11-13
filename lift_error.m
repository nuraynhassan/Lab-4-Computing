function f = lift_error(alpha, deltae, params)

S = params.S;
W = params.W;
q = (.5) .* params.rho .* params.V.^2;

deltaClp = params.deltaCl .* exp(-((alpha ./ params.alphap).^2));

CL = params.Clnot + params.Clalpha .* alpha + params.Cldelta .* deltae + deltaClp;

CM = params.CMnot + params.CMalpha .* alpha + params.CMdelta .* deltae;

L = q .* S .* CL;

f = ((L - W) ./ W).^2 + CM.^2;

end