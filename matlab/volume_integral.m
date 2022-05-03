function [Volume, fmm3d_time_all] = volume_integral(xyz, dx, dy, dz, targ, Ck, CG_singular)
% xyz = numerical grid
% targ = target points
eps = 1e-10;
% few setups 
pg = 1;
pgt = 1;

ns = size(xyz,2);
srcinfo.sources = xyz; %xj (R3 x N)


ntarg = size(targ,2);

% store x3m - C3n * x3n constant for each n
Cnx3n = zeros(1,ns);
for n = 1:ns
    cn = Ck(n);
    xn = xyz(:,n);
    x3n = xn(3);

    Cnx3n(n) = cn * x3n;
end

% We compute each element in the volume integral 
Volume_pt1 = zeros(3, ntarg);

fmm3d_time_all = 0;
for j = 1:3
    if j == 1
        srcinfo.charges = zeros(1,ns);
        vj1 = [Cnx3n; zeros(1,ns); zeros(1,ns)];
        srcinfo.dipoles = vj1;
    elseif j == 2
        srcinfo.charges = zeros(1,ns);
        vj2 = [zeros(1,ns); Cnx3n; zeros(1,ns)];
        srcinfo.dipoles = vj2;
    else % j==3
        srcinfo.charges = Ck; %for the very first integral 
        vj3 = [zeros(1,ns); zeros(1,ns); Cnx3n];
        srcinfo.dipoles = vj3;
    end
    
    tic
    U = lfmm3d(eps,srcinfo,pg,targ,pgt);
    fmm3d_time_all = fmm3d_time_all + toc;
    Volume_pt1(j,:) = U.pottarg * (dx*dy*dz);
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
        vj3 = [zeros(1,ns); zeros(1,ns); Ck];
        srcinfo.dipoles = vj3;
    end
    
    tic
    U_targ = lfmm3d(eps,srcinfo,pg,targ,pgt);
    fmm3d_time_all = fmm3d_time_all + toc;
    
    x3m = targ(end,:);
    Volume_pt2(j,:) = x3m.*U_targ.pottarg .* (dx*dy*dz);
end

% Add one more part : direct computation when source == targ

Volume = Volume_pt1 - Volume_pt2;

% Add singularity point
singular = zeros(size(xyz,2), size(targ,2));
for ii = 1:size(xyz,2)
    for jj = 1:size(targ,2)
        
        if xyz(:,ii) == targ(:,jj)
            singular(ii, jj) = 1; %missing part
            Volume(:,jj) = Volume(:,jj) + Ck(ii).*CG_singular;
        end
        
    end
end

end




