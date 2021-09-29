%% Accuracy
eps = 1e-5;

%% source points

x0 = -1; xend = 1;
y0 = x0; yend = xend;
z0 = -1; zend = 1;


lev = linspace(x0, xend, Nx);
dx = (xend - x0)/(Nx-1);
dy = (yend - y0)/(Ny-1);
dz = (zend - z0)/(Nz-1);

xlev = linspace(x0, xend, Nx);
ylev = linspace(y0, yend, Ny);
zlev = linspace(z0, zend, Nz);


xlev_mid = xlev(1:end-1) + dx/2;
ylev_mid = ylev(1:end-1) + dy/2;
zlev_mid = zlev(1:end-1) + dz/2;

ns = (Nx-1)*(Ny-1)*(Nz-1); %total number of source pts 
xyz = make_grid(xlev_mid, ylev_mid, zlev_mid);


%% target points


targ_x0 = -1; targ_xend = 1;
targ_xlev = linspace(targ_x0, targ_xend, nt_x);

targ_y0 = -1; targ_yend = 1;
targ_ylev = linspace(targ_y0, targ_yend, nt_y);

targ_z0 = -1; targ_zend = 1;
targ_zlev = linspace(targ_z0, targ_zend, nt_z);


nt = nt_x * nt_y * nt_z;
targ = make_grid(targ_xlev, targ_ylev, targ_zlev);

[X, Y, Z] = ndgrid(targ_xlev, targ_ylev, targ_zlev);

%% Ck vector
% charge points cj (R1 x N) 
% This is the perturbation term C times \hat{k}

% Ck = ones(1, ns); % one for all now
Ck = exp(-(xyz(1,:)).^2 -(xyz(2,:)).^2 -(xyz(3,:)).^2);









