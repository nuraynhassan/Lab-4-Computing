function f = lift_error(alpha, deltae, p)

S = p(9);
W = p(12);
q = (.5) .* p(1) .* p(5).^2;

deltaClp = p(4) .* exp(-((alpha ./ p(8)).^2));

CL = p(2) + p(6) .* alpha + p(10) .* deltae + deltaClp;

CM = p(3) + p(7) .* alpha + p(11) .* deltae;

L = q .* S .* CL;

f = ((L - W) ./ W).^2 + CM.^2;

end
