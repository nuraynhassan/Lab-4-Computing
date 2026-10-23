function alpha = line_search(f,x,p,alpha_init,mu_1,rho)
    phia = @(alpha, x, p) f(x + p*alpha);
    phiprime0 = g'*p;
    alpha = alpha_init;
    while phia(alpha,x,p) > phia(0,x,p) + mu_1*alpha*phiprime0
        alpha = rho*alpha;
    end
end