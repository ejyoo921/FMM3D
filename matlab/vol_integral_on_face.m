addpath('../../matlab_BIE')

clear

%%
NC = 1; % number of cubes
[xc, cm, rad] = DLA_3D(NC);
% now xc contains the center of the cubes of side 2 making up the cluster


%% build the aggregates
% Now compute where are the faces and what are their normals and orientations
[posint, ndir, ori, Nf] = build_faces(xc, NC);

%% Accuracy
eps = 1e-5;

%% source points
Nx = 31;
Ny = 31;
Nz = 31;

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

%% initial concentration/perturbation

Ck_fun = @(x,y,z) exp(-(x).^2 -(y).^2 -(z).^2);
Ck = exp(-(xyz(1,:)).^2 -(xyz(2,:)).^2 -(xyz(3,:)).^2);

%% target points - center of each square face = posint
targ = posint';

%% Solve the integral
[vol_integral, fmm3d_time] = volume_integral(xyz, dx, targ, Ck);


