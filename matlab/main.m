%% clear things
clear
close all

%% begin
% ntarg_vec = 40;
% Nsource_vec = 50:10:100;

% ntarg_vec = 40:100:1240;
% Nsource_vec = 100;

ntarg_vec = logspace(1,5,10);
ntarg_vec = ntarg_vec(8:end);
% ntarg_vec = 50:100:1040;
Nsource_vec = 20:20:100;

fmm3d_t = zeros(length(ntarg_vec), length(Nsource_vec));
% matlab_t = zeros(length(ntarg_vec), 1);

for k = 1:length(ntarg_vec)
    for s = 1:length(Nsource_vec)

    targ_x = linspace(-4, 4, ntarg_vec(k));
    Nsource = Nsource_vec(s);

    main_setting
%     matlab_t(k) = matlabV_time_all;
% 
    [Volume, fmm3d_time] = volume_integral(xyz, dx, targ, Ck);
    fmm3d_t(k,s) = fmm3d_time;

%     matlabV_time_all = 0;
    fmm3d_time = 0;
    end
    k
end

% error_vec = abs(Volume - matlabV_all);

%% figures solution & error
% for i = 1:3
%     figure1=figure('Position', [100, 100, 1500, 500]);
%     subplot(1,2,1)
% 
%     plot(targ_x, Volume(i,:), 'linewidth', 2)
%     hold on
%     plot(targ_x, matlabV_all(i,:), 'linewidth', 2)
%     hold off
%     if i == 1
%         title('solution in x-dir.')
%     elseif i == 2
%         title('solution in y-dir.')
%     else 
%         title('solution in z-dir.')
%     end
%     legend('FMM3d', 'real');
%     set(gca,'Fontsize',20);
% 
% 
%     subplot(1,2,2)
% 
%     semilogy(targ_x, error_vec(i,:),'linewidth',2)
%     if i == 1
%         title('error in x-dir.')
%     elseif i == 2
%         title('error in y-dir.')
%     else 
%         title('error in z-dir.')
%     end
%     set(gca,'Fontsize',20);
% 
%     saveas(figure1,['./figures/nsource_1e2_direction',num2str(i),'.eps'], 'epsc');
%     close all
% end


%% save data
save data_time_5ns_nt_1e4_pt2
%% figure timing

figure1 = figure('Position', [100, 100, 800, 650]);
loglog(ntarg_vec, fmm3d_t, '*-', 'linewidth',2);
hold on
loglog(ntarg_vec(1:8), matlab_t(1:8), 'linewidth',2)
%slope
% loglog_slope(ntarg_vec, fmm3d_t, 'fmm3d', 'k--')
x = ntarg_vec(1:8); y = matlab_t(1:8);
logx1 = log(x); %
logy1 = log(y);
Const1 = polyfit(logx1, logy1, 1);
slope1 = Const1(1);
plot(ntarg_vec, exp(polyval(Const1, log(ntarg_vec))),'k--','Linewidth',2.5) %
dim = [0.65 0.20 0.0 0.45];
str = {['slope = ',num2str(round(slope1,4))]}; %
annotation('textbox',dim,'String',str,'FitBoxToText','on','Fontsize',17)


legend('Ns = 20','Ns = 40','Ns = 60','Ns = 80','Ns = 100', 'matlab','location','northwest')
xlabel('Number of target points', 'interpreter','latex')
ylabel('Elapsed time (sec)', 'interpreter','latex')
% title('Targets (40pts) in $$x \in [-4,4]$$ (eps 1e-3)', 'interpreter','latex')
% title('Computation time (Nsource = 1e6, tol = 1e-3)', 'interpreter','latex')
title('Computation time w/ various Nsource', 'interpreter','latex')
grid on
set(gca,'Fontsize',18);

% hold off
% saveas(figure1,'./figures/time_ntarg_50_1e2.fig');
% saveas(figure1,'./figures/time_ntarg_50_1e2.eps', 'epsc');

%%
figure3 =figure('Position', [100, 100, 1500, 500]);
for i = 1:3
    subplot(1,3,i)
    plot(targ_x, volume_ns50(i,:), '--','linewidth', 3)
    hold on
    plot(targ_x, Volume(i,:), '*-','linewidth', 2, 'markersize', 4)
    plot(targ_x, matlabV_all(i,:), 'linewidth', 2)
    hold off
    
    if i == 1
        title(' solution in x.','interpreter','latex')
    elseif i == 2
        title(' solution in y.','interpreter','latex')
    else 
        title(' solution in z.','interpreter','latex')
    end
    
    xlabel('x','interpreter','latex')
    
    
    legend('$$ns = 50^3$$', '$$ns = 100^3$$','real','interpreter','latex')
    legend('Location','southwest')
    grid on
    set(gca,'Fontsize',18);
end

%%
figure4 =figure('Position', [100, 100, 1500, 500]);
for i = 1:3
    subplot(1,3,i)
    err_v_ns50 = abs(matlabV_all - volume_ns50);
    err_v_ns100 = abs(matlabV_all - Volume);
    semilogy(targ_x, err_v_ns50(i,:), '--','linewidth', 3)
    hold on
    semilogy(targ_x, err_v_ns100(i,:), '*-','linewidth', 2, 'markersize', 4)
    hold off
    
    if i == 1
        title(' Error in x.','interpreter','latex')
    elseif i == 2
        title(' Error in y.','interpreter','latex')
    else 
        title(' Error in z.','interpreter','latex')
    end
    
    xlabel('x','interpreter','latex')
    
    
    legend('$$ns = 50^3$$', '$$ns = 100^3$$','interpreter','latex')
    legend('Location','southwest')
    grid on
    set(gca,'Fontsize',18);
end





