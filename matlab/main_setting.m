%% source points

x0 = 0; xend = 3;
y0 = x0; yend = xend;
z0 = x0; zend = xend;
xspan = [x0, xend];
yspan = [x0, xend];
zspan = [x0, xend];

Nsource = 100;
lev = linspace(x0, xend, Nsource);
dx = (xend - x0)/(Nsource);
% dx = 0.02;
% boundary not included
% lev = x0+dx:dx:xend-dx;
% lev = x0:dx:xend;
% Nsource = length(lev);
ns = (Nsource)^3; %total number of source pts 

xyz = make_grid(lev, Nsource);


%% target points

% targ = [2.6; 2.6; 2.6];
% ntarg = size(targ,2);

ntarg = length(targ_x);
targ_yz = 2*ones(3, ntarg);
targ_yz(1,:) = targ_x;
targ = targ_yz;


% make many target points

% making cube for targets
% Nx_targ = 10;
% lev_targ = linspace(2, 4, Nx_targ);
% targ = make_grid(lev_targ, Nx_targ);
% ntarg = size(targ,2);

%% Ck vector
% charge points cj (R1 x N) 
% This is the perturbation term C times \hat{k}

Ck = ones(1, ns); % one for all now


%% analytic-kind solution
tol = 1e-10;
matlabV_all = zeros(3, ntarg);
matlabV_time_all = 0;
for t = 1:ntarg
    targ_t = targ(:,t);
    
    x0 = targ_t(1);
    y0 = targ_t(2);
    z0 = targ_t(3);
    [matlabV, matlabV_time] = fmm_test_analytic(Ck(1), x0, y0, z0, xspan, yspan, zspan, tol);
    
    matlabV_all(:,t) = matlabV;
    matlabV_time_all = matlabV_time_all + matlabV_time;
end

%% Calculate boundary values analytically

% for t = 1:ntarg^3
%     targ_t = targ(:,t);
%     
%     x0 = targ_t(1);
%     y0 = targ_t(2);
%     z0 = targ_t(3);
%     
%     
%     [x0_y0_z0, time000] = fmm_test_analytic(Ck(1), x0, y0, z0, [x0, x0+dx], [y0, y0+dx], [z0, z0+dx]);
%     [x0_y0_zend, time001] = fmm_test_analytic(Ck(1), x0, y0, z0, [x0, x0+dx], [y0, y0+dx], [zend-dx, zend]);
%     [x0_yend_z0, time010] = fmm_test_analytic(Ck(1), x0, y0, z0, [x0, x0+dx], [yend-dx, yend], [z0, z0+dx]);
%     [x0_yend_zend, time011] = fmm_test_analytic(Ck(1), x0, y0, z0, [x0, x0+dx], [yend-dx, yend], [zend-dx, zend]);
%     [xend_y0_z0, time100] = fmm_test_analytic(Ck(1), x0, y0, z0, [xend-dx, xend], [y0, y0+dx], [z0, z0+dx]);
%     [xend_y0_zend, time101] = fmm_test_analytic(Ck(1), x0, y0, z0, [xend-dx, xend], [y0, y0+dx], [zend-dx, zend]);
%     [xend_yend_z0, time110] = fmm_test_analytic(Ck(1), x0, y0, z0, [xend-dx, xend], [yend-dx, yend], [z0, z0+dx]);
%     [xend_yend_zend, time111] = fmm_test_analytic(Ck(1), x0, y0, z0, [xend-dx, xend], [yend-dx, yend], [zend-dx, zend]);
%     
%     bd_values = x0_y0_z0 + x0_y0_zend + x0_yend_z0 + x0_yend_zend + xend_y0_z0 + xend_y0_zend + xend_yend_z0 + xend_yend_zend;
%     bd_time_all = time000 + time001 + time010 + time011 + time100 + time101 + time110 + time111;
% end
