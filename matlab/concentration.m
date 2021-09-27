%Original code is in matlab-3d-advection-diffusion
%modified on Sep 27, 2021

% domain size 
ic_x = zeros(Nx-1,1);
ic_y = zeros(Ny-1,1);
ic_z = zeros(Nz-1,1);


% use posint to and make value 1 at the point 
Nx_mid = Nx/2;
Ny_mid = Ny/2;
Nz_mid = Nz/2;

n = Nx_mid/2;
for i = 1:n
    ic_x(Nx_mid + floor(n/2)-i) = 0.5;
    ic_y(Ny_mid + floor(n/2)-i) = 0.5;
    ic_z(Nz_mid + floor(n/2)-i) = 0.5;
%     ic_x = exp(-(xvec-pi/2));
%     ic_y = exp(-(yvec-pi/2));
%     ic_z = exp(-(zvec-2*pi));
end

[icX, icY, icZ] = ndgrid(ic_x, ic_y, ic_z);
