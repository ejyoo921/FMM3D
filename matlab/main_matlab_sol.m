%% analytic-kind solution
xspan = [targ_x0, targ_xend];
yspan = [targ_y0, targ_yend];
zspan = [targ_z0 targ_zend];

tol = 1e-5;

matlabV_all = zeros(3, ntarg^3);
matlabV_time_all = 0;

Ck_fun = @(x,y,z) exp(-(x).^2 -(y).^2 -(z).^2);

for t = 1:nt
    targ_t = targ(:,t);

    
    x0_t = targ_t(1);
    y0_t = targ_t(2);
    z0_t = targ_t(3);
    
    [matlabV, matlabV_time] = fmm_test_analytic(Ck_fun, x0_t, y0_t, z0_t, xspan, yspan, zspan, tol);
    
    matlabV_all(:,t) = matlabV;
    matlabV_time_all = matlabV_time_all + matlabV_time;
end
