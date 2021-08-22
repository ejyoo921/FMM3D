%% clear things
clear
close all

%% begin
targ_x = linspace(-3, 6, 30);
main_setting


[Volume, fmm3d_time] = volume_integral(xyz, dx, targ, Ck);

error_vec = abs(Volume - matlabV_all);


%% figures
figure(1)
plot(targ_x, Volume(3,:), 'linewidth', 2)
hold on
plot(targ_x, matlabV_all(3,:), 'linewidth', 2)
hold off

figure(2)
semilogy(targ_x, error_vec(3,:))
