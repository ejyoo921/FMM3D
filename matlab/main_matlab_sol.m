%% analytic-kind solution
xspan = [x0, xend];
yspan = [y0, yend];
zspan = [z0 zend];

tol = 1e-6;

matlabV_all = zeros(3, nt);
matlabV_time_all = 0;

for t = 1:nt
    targ_t = targ(:,t);

    
    x0_t = targ_t(1);
    y0_t = targ_t(2);
    z0_t = targ_t(3);
    
    [matlabV, matlabV_time] = fmm_test_analytic(Ck_fun, x0_t, y0_t, z0_t, xspan, yspan, zspan, tol);
    
    matlabV_all(:,t) = matlabV;
    matlabV_time_all = matlabV_time_all + matlabV_time;
end
