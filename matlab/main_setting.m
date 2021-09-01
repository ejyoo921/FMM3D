%% source points

x0 = -1; xend = 1;
y0 = x0; yend = xend;
z0 = x0; zend = xend;
xspan = [x0, xend];
yspan = [x0, xend];
zspan = [x0, xend];

lev = linspace(x0, xend, Nsource);
dx = (xend - x0)/(Nsource-1);

lev_mid = lev(1:end-1) + dx/2;
ns = (Nsource-1)^3; %total number of source pts 
xyz = make_grid(lev_mid, Nsource-1);


%% target points

% targ = [2.6; 2.6; 2.6];
% ntarg = size(targ,2);

ntarg = length(targ_x);
targ_yz = 0.5*ones(3, ntarg);
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








