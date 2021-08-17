function [fmm3d_time_all, matlabV_time_all, error] = volume_integral(Nx_targ)

% few setups 
eps = 1e-6;
pg = 1;
pgt = 1;



x0 = -3; xend = 3;
xspan = [x0, xend];
yspan = [x0, xend];
zspan = [x0, xend];t

Nsource = 100;
dx = (xend - x0)/(Nsource);
lev = linspace(x0, xend, Nsource);
ns = (Nsource)^3; %total number of source pts 

xyz = make_grid(lev, Nsource);
srcinfo.sources = xyz; %xj (R3 x N)

% charge points cj (R1 x N) 
% This is the perturbation term C times \hat{k}
Ck = ones(1, ns); % one for all now

% target point
% making cube for targets
% lev_targ = linspace(-5, 5, Nx_targ);
% targ = make_grid(lev_targ, Nx_targ);


targ = [4;4;4];
matlabV_all = [];
matlabV_time_all = 0;
for t = 1:Nx_targ^3
    targ_t = targ(:,t);
    
    x0 = targ_t(1);
    y0 = targ_t(2);
    z0 = targ_t(3);
    [matlabV, matlabV_time] = fmm_test_analytic(Ck(1), x0, y0, z0, xspan, yspan, zspan);
    
    matlabV_all = [matlabV_all, matlabV];
    matlabV_time_all = matlabV_time_all + matlabV_time;
end

size_targ = size(targ);
ntarg = size_targ(2);



% store x3m - C3n * x3n constant for each n
const = zeros(1,ns);
for n = 1:ns
    cn = Ck(n);
    xn = xyz(:,n);
    x3n = xn(3);

    const(n) = cn * x3n;
end

% We compute each element in the volume integral 
Volume_pt1 = zeros(3, ntarg);

fmm3d_time_all = 0;
for j = 1:3
    if j == 1
        srcinfo.charges = zeros(1,ns);
        vj1 = [const; zeros(1,ns); zeros(1,ns)];
        srcinfo.dipoles = vj1;
    elseif j == 2
        srcinfo.charges = zeros(1,ns);
        vj2 = [zeros(1,ns); const; zeros(1,ns)];
        srcinfo.dipoles = vj2;
    else % j==3
        srcinfo.charges = Ck; %for the very first integral 
        vj3 = [zeros(1,ns); zeros(1,ns); const;];
        srcinfo.dipoles = vj3;
    end
    
    tic
    U = lfmm3d(eps,srcinfo,pg,targ,pgt);
    fmm3d_time_all = fmm3d_time_all + toc;
    Volume_pt1(j,:) = U.pottarg * (dx^3);
end

Volume_pt2 = zeros(3, ntarg);

for j = 1:3
        
    % for extra term
    if j == 1
        srcinfo.charges = zeros(1,ns);
        vj1 = [Ck; zeros(1,ns); zeros(1,ns)];
        srcinfo.dipoles = vj1;
    elseif j == 2
        srcinfo.charges = zeros(1,ns);
        vj2 = [zeros(1,ns); Ck; zeros(1,ns)];
        srcinfo.dipoles = vj2;
    else % j==3
        srcinfo.charges = zeros(1,ns);
        vj3 = [zeros(1,ns); zeros(1,ns); Ck;];
        srcinfo.dipoles = vj3;
    end
    
    tic
    U_targ = lfmm3d(eps,srcinfo,pg,targ,pgt);
    fmm3d_time_all = fmm3d_time_all + toc;
    
    x3m = targ(end,:);
    Volume_pt2(j,:) = x3m.*U_targ.pottarg .* (dx^3);
end

Volume = Volume_pt1 - Volume_pt2;



format long

error = abs(Volume - matlabV_all);
% inf_norm_error1 = norm(error(1,:), inf);
% inf_norm_error2 = norm(error(2,:), inf);
% inf_norm_error3 = norm(error(3,:), inf);
fprintf('matlab time is %d \n', matlabV_time_all)
fprintf('fmm3d time is %d \n', fmm3d_time_all)




