%% clear things
clear
close all

%% begin - Main function to run FMM3D package 


nt_x = 41;
nt_y = 1;
nt_z = 1;

Nx = 31;
Ny = 31;
Nz = 31;

main_setting

% FMM3D solution and grid
[Volume, fmm3d_time_all] = volume_integral(xyz, dx, dy, dz, targ, Ck);
[vol_X, vol_Y, vol_Z] = make_grid_inv(Volume, nt_x, nt_y, nt_z);

% solve the same problem w/ matlab integral3
main_matlab_sol
% re-organize the values for plots
[mb_X, mb_Y, mb_Z] = make_grid_inv(matlabV_all, nt_x, nt_y, nt_z);

Error_abs = abs(Volume - matlabV_all);

%% line plot
figure3 =figure('Position', [100, 100, 1500, 500]);
for i = 1:3
    subplot(1,3,i)

    plot(targ_xlev, Volume(i,:), '*-','linewidth', 2, 'markersize', 4)
    hold on
    plot(targ_xlev, matlabV_all(i,:), 'linewidth', 2)
    hold off
    
    if i == 1
        ylabel(' solution in $$x$$-dir.','interpreter','latex')
    elseif i == 2
        ylabel(' solution in $$y$$-dir.','interpreter','latex')
    else 
        ylabel(' solution in $$z$$-dir.','interpreter','latex')
    end
    
    xlabel('$$x$$','interpreter','latex')
    
    
    legend(['$$Ns = $$',num2str(ns)],'real','interpreter','latex')
    legend('Location','southwest')
    grid on
    set(gca,'Fontsize',18);
end

%% error line
figure4 =figure('Position', [100, 100, 1500, 500]);
for i = 1:3
    subplot(1,3,i)
    semilogy(targ_xlev, Error_abs(i,:), '*-','linewidth', 2, 'markersize', 4)
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
    
    
    legend(['$$Ns = $$',num2str(ns)],'interpreter','latex')
    legend('Location','northeast')
    grid on
    set(gca,'Fontsize',18);
end


%% plot setup

% tried to re-run this part on 04/19/22 but not working.

% m = floor(nt_y/2)+1; % where do you want to slice?
% 
% xx = squeeze(X(:,:,m));
% yy = squeeze(Y(:,:,m));
% 
% vv = squeeze(vol_Z(:,:,m));
% 
% mb_vv = squeeze(mb_Z(:,m,:));
% error_vv = abs(squeeze(mb_Z(:,m,:)) - squeeze(vol_Z(:,m,:)));
% 
% % get images
% h=figure;
% subplot(1,2,1)
% % surf(xx ,yy ,vv);
% surf(xx ,yy ,error_vv);
% 
% set(h, 'Position', [100, 100, 800, 600]); 
% set(gca,'Fontsize',20);
% 
% xlabel('$$x$$','fontsize',30,'interpreter','latex')
% ylabel('$$y$$', 'fontsize',30,'interpreter','latex')
% 
% hsp1 = get(gca, 'Position');
% 
% 
% subplot(1,2,2)
% % vv need to be transposed! 
% pcolor(xx(:,1), yy(1,:) ,error_vv'); %grid on
% 
% set(gca,'Fontsize',20);
% xlabel('$$x$$','fontsize',30,'interpreter','latex')
% ylabel('$$y$$', 'fontsize',30,'interpreter','latex')
% 
% colorbar
% hsp2 = get(gca, 'Position');             % Get 'Position' for (2,1,2)
% set(gca, 'Position', [hsp2(1:3)  hsp1(4)])

