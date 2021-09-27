%% clear things
% clear
% close all

%% begin

ntarg_vec = 1*round(logspace(1,2,10));
Nsource_vec = 1*round(logspace(1,2,10));

% fmm_sol_all = zeros(length(ntarg_vec), length(Nsource_vec));

% error_inf = zeros(1, length(Nsource_vec));
% error_L2 = zeros(1, length(Nsource_vec));


% fmm3d_t = zeros(length(ntarg_vec), length(Nsource_vec));
% matlab_t = zeros(length(ntarg_vec), 1);

for k = 1:length(ntarg_vec)-2
    for s = 9:length(Nsource_vec)

        targ_x = linspace(-4, 4, ntarg_vec(k).^3);
        Nsource = Nsource_vec(s);

        main_setting
    % 
        [Volume, fmm3d_time] = volume_integral(xyz, dx, targ, Ck);
    %     error_inf(k,s) = norm(Volume-matlabV_all, inf);
    %     error_L2(k,s) = norm(Volume-matlabV_all, 2);

        fmm3d_t(k,s) = fmm3d_time;

    end
%     main_matlab_sol
%     matlab_t(k) = matlabV_time_all;
%     
%     matlabV_time_all = 0;
%     fmm3d_time = 0;
    k
end

% error_vec = abs(Volume - matlabV_all);



%% save data
% save data_nt1e2_2ns1e2_m4_4



