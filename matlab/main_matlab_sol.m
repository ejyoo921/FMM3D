%% analytic-kind solution
xspan = [x0, xend];
yspan = [x0, xend];
zspan = [x0, xend];

tol = 1e-5;

matlabV_all = zeros(3, ntarg);
matlabV_time_all = 0;
for t = 1:ntarg
    targ_t = targ(:,t);

    
    x0_t = targ_t(1);
    y0_t = targ_t(2);
    z0_t = targ_t(3);
    % For simple constant Ck, take just one value
    % This need to be changed for Ck depending on locations
    [matlabV, matlabV_time] = fmm_test_analytic(Ck(1), x0_t, y0_t, z0_t, xspan, yspan, zspan, tol);
    
    matlabV_all(:,t) = matlabV;
    matlabV_time_all = matlabV_time_all + matlabV_time;
end
