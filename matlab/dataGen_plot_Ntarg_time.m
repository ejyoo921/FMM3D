clear
close all

Ntarg_vec = 5:20;
fmm3d_t = zeros(length(Ntarg_vec),1);
matlab_t = zeros(length(Ntarg_vec),1);

for i = 1:length(Ntarg_vec)
    Ntarg = Ntarg_vec(i);
    [fmm3d_t(i), matlab_t(i), error] = volume_integral(Ntarg);
end

loglog(Ntarg_vec.^3, fmm3d_t, '*-', 'linewidth',2)
hold on
loglog(Ntarg_vec.^3, matlab_t, 'o-', 'linewidth',2)
legend('fmm3d', 'matlab','location','northwest')
xlabel('number of target points', 'interpreter','latex')
ylabel('elapsed time (sec)', 'interpreter','latex')
title('Source in cube $$[-1,1]^3$$ w/ Nx=50 (eps 1e-4)', 'interpreter','latex')

set(gca,'Fontsize',20);
hold off

% save Ntarg_time_data_w_error_ver3