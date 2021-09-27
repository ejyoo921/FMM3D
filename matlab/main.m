%% clear things
clear
close all

%% begin - Main function to run FMM3D package 


ntarg = 20;
Nsource = 20;
main_setting

[Volume, fmm3d_time] = volume_integral(xyz, dx, targ, Ck);
main_matlab_sol





