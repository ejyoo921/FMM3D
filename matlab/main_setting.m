%% source points
Nx = Nsource;
Ny = Nsource;
Nz = Nsource;

x0 = -1; xend = 1;
y0 = x0; yend = xend;
z0 = x0; zend = xend;


lev = linspace(x0, xend, Nx);
dx = (xend - x0)/(Nx-1);
dy = (yend - y0)/(Ny-1);
dz = (zend - z0)/(Nz-1);
% xyz_nonMid = make_grid(lev, Nsource);


xlev = linspace(x0, xend, Nx);
ylev = 2.*linspace(y0, yend, Ny);
zlev = 3.*linspace(z0, zend, Nz);
xyz = make_grid(xlev, ylev, zlev);

xlev_mid = xlev(1:end-1) + dx/2;
ylev_mid = ylev(1:end-1) + dy/2;
zlev_mid = zlev(1:end-1) + dz/2;

ns = (Nx-1)^3; %total number of source pts 
xyz = make_grid(xlev_mid, ylev_mid, zlev_mid);


%% target points

ntarg = length(targ_x);
targ_yz = 0.5*ones(3, ntarg);
targ_yz(1,:) = targ_x;
targ = targ_yz;


%% Ck vector
% charge points cj (R1 x N) 
% This is the perturbation term C times \hat{k}

Ck = ones(1, ns); % one for all now








