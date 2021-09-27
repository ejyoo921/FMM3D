%% figure timing
load('data_time_5ns_nt_1e6.mat')
figure1 = figure('Position', [100, 100, 800, 650]);
for l = 1:5
    loglog(ntarg_vec, fmm3d_t(:,l), '*-', 'linewidth',2);
    hold on
end
% loglog(matlab_ntarg, matlab_t_pt, 'linewidth',2)
loglog(ntarg_matlab, matlab_t, 'linewidth',2)

%slope
% loglog_slope(ntarg_vec, fmm3d_t, 'fmm3d', 'k--')
% x = matlab_ntarg; y = matlab_t_pt;

x = ntarg_matlab(1:8); y = matlab_t(1:8);
logx1 = log(x); %
logy1 = log(y);
Const1 = polyfit(logx1, logy1, 1);
slope1 = Const1(1);
plot(ntarg_vec, exp(polyval(Const1, log(ntarg_vec))),'k--','Linewidth',2.5) %
dim = [0.65 0.20 0.0 0.45];
str = {['slope = ',num2str(round(slope1,4))]}; %
annotation('textbox',dim,'String',str,'FitBoxToText','on','Fontsize',17)


legend('$$Ns = 20^3$$','$$Ns = 40^3$$','$$Ns = 60^3$$','$$Ns = 80^3$$','$$Ns = 100^3$$', 'matlab','location','northwest','interpreter','latex')
xlabel('Number of target points', 'interpreter','latex')
ylabel('Elapsed time (sec)', 'interpreter','latex')

% title('Computation time w/ various Nsource', 'interpreter','latex')
grid on
set(gca,'Fontsize',18);

%% Fix ntarg varying nsource - fmm only
figure2 = figure('Position', [100, 100, 800, 650]);
cc = 7;
loglog(Nsource_vec.^3, fmm3d_t(cc, :), '*-', 'linewidth',2);
hold on
x = Nsource_vec.^3; y = fmm3d_t(cc, :);
logx1 = log(x); %
logy1 = log(y);
Const1 = polyfit(logx1, logy1, 1);
slope1 = Const1(1);
plot(x, exp(polyval(Const1, log(x))),'k--','Linewidth',2.5) %
dim = [0.65 0.20 0.0 0.01];
str = {['slope = ',num2str(round(slope1,4))]}; %
annotation('textbox',dim,'String',str,'FitBoxToText','on','Fontsize',17)

legend(['Ntarg $$=$$ ', num2str(round(ntarg_vec(cc)))],'Linear fit','interpreter','latex') 
xlabel('Number of source points', 'interpreter','latex')
ylabel('Elapsed time (sec)', 'interpreter','latex')
grid on
set(gca,'Fontsize',18);


%%
load('data_nt1e2_2ns1e2_m4_4.mat')
figure3 =figure('Position', [100, 100, 1500, 500]);
for i = 1:3
    subplot(1,3,i)
%     plot(targ_x, volume_ns50(i,:), '--','linewidth', 3)
%     hold on
    plot(targ_x, Volume(i,:), '*-','linewidth', 2, 'markersize', 4)
    hold on
    plot(targ_x, matlabV_all(i,:), 'linewidth', 2)
    hold off
    
    if i == 1
        ylabel(' solution in $$x$$-dir.','interpreter','latex')
    elseif i == 2
        ylabel(' solution in $$y$$-dir.','interpreter','latex')
    else 
        ylabel(' solution in $$z$$-dir.','interpreter','latex')
    end
    
    xlabel('$$x$$','interpreter','latex')
    
    
    legend(['$$Ns = $$',num2str(Nsource),'$$^3$$'],'real','interpreter','latex')
    legend('Location','southwest')
    grid on
    set(gca,'Fontsize',18);
end

%%
figure4 =figure('Position', [100, 100, 1500, 500]);
load('data_nt1e2_2ns1e2_m4_4.mat')
err_v_ns100 = abs(matlabV_all - Volume);
for i = 1:3
    subplot(1,3,i)
%     err_v_ns50 = abs(matlabV_all - volume_ns50);
    
%     semilogy(targ_x, err_v_ns50(i,:), '--','linewidth', 3)
%     hold on
    semilogy(targ_x, err_v_ns100(i,:), '*-','linewidth', 2, 'markersize', 4)
    hold on
    hold off
    
    if i == 1
        ylabel(' Error in $$x$$-dir.','interpreter','latex')
    elseif i == 2
        ylabel(' Error in $$y$$-dir.','interpreter','latex')
    else 
        ylabel(' Error in $$z$$-dir.','interpreter','latex')
    end
    
    xlabel('$$x$$','interpreter','latex')
    
    
    legend(['$$Ns = $$',num2str(Nsource),'$$^3$$'],'interpreter','latex')
    legend('Location','northwest')
    grid on
    set(gca,'Fontsize',18);
end

%% Convergence plot

figure5 = figure('Position', [100, 100, 800, 650]);

x = (xend-x0)./(Nsource_vec-1); y = error_inf;
loglog(x, y, '*-', 'linewidth', 2)
hold on
xlabel('$$\Delta x$$ ($$ = \Delta y = \Delta z$$)', 'interpreter','latex')
ylabel('Inf. norm(error)','interpreter','latex')


logx1 = log(x); %
logy1 = log(y);
Const1 = polyfit(logx1, logy1, 1);
slope1 = Const1(1);
plot(x, exp(polyval(Const1, log(x))),'k--','Linewidth',2.5) %
dim = [0.65 0.20 0.0 0.01];
str = {['slope = ',num2str(round(slope1,4))]}; %
annotation('textbox',dim,'String',str,'FitBoxToText','on','Fontsize',23)


grid on
set(gca,'Fontsize',23);