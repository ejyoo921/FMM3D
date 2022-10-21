function slp_fmm = surf_integral(posint, nSx, nSy, nSz, targ, bie_f, ndir)
% posint = center of square faces : size should be 3 x something
% bie_f also has 3 x something form
% targ = target points

eps = 1e-5;

% few setups
pg = 1;
pgt = 1;

ns = size(posint,2);
% srcinfo.sources = posint; %xj (3 x N)

ntarg = size(targ,2);

% We compute each element in the volume integral

slp_pt1 = zeros(3, ntarg);
slp_pt2 = zeros(3, ntarg);

x1 = -floor(nSx/2):floor(nSx/2);
x2 = -floor(nSy/2):floor(nSy/2);
x3 = -floor(nSz/2):floor(nSz/2);

dSx = 2./nSx;
dSy = 2./nSy;
dSz = 2./nSz;
%% part 1

% getting source info 
srcinfo.dipoles = [];
srcinfo.charges = [];
srcinfo.sources = [];

H_part1 = zeros(1, ntarg);
bie_f_ext = [];
for nn = 1:ns
    normal_dir = ndir(nn);

    if normal_dir == 1

        xSpan = posint(1,nn);
        ySpan = posint(2,nn) + (dSy) .* x2;
        zSpan = posint(3,nn) + (dSz) .* x3;

        d_square = dSy * dSz;

    elseif normal_dir == 2

        xSpan = posint(1,nn) + (dSx) .* x1;
        ySpan = posint(2,nn);
        zSpan = posint(3,nn) + (dSz) .* x3;

        d_square = dSx * dSz;

    else %normal dir = 3

        xSpan = posint(1,nn) + (dSx) .* x1;
        ySpan = posint(2,nn) + (dSy) .* x2;
        zSpan = posint(3,nn);

        d_square = dSx * dSy;

    end

    posint_H = make_grid(xSpan, ySpan, zSpan);
    ns_H = size(posint_H,2);

    bie_f_ext = [bie_f_ext, repmat(bie_f(:,nn), 1, ns_H)];

    srcinfo.sources = [srcinfo.sources, posint_H];
end

ns_total = size(srcinfo.sources, 2);

for j = 1:3

    for i = 1:3
        v_mx = zeros(3, ns_total);

        if i == j
            srcinfo.charges = bie_f_ext(i,:) .* ones(1, ns_total);
        else
            srcinfo.charges = zeros(1, ns_total);
        end

        v_mx(j, :) = - bie_f_ext(i,:) .* srcinfo.sources(i,:);
        srcinfo.dipoles = v_mx;

        H_ij = lfmm3d(eps, srcinfo, pg, targ, pgt);
        slp_pt1(j,:) = H_part1 + d_square .* H_ij.pottarg;
    end
end

H_part2 = zeros(1, ntarg);
srcinfo.dipoles = [];
for j = 1:3


    for i = 1:3
        v_mx2 = zeros(3, ns_total);
        v_mx2(j,:) = bie_f_ext(i,:) .* ones(1, ns_total);

        srcinfo.dipoles = v_mx2;


        srcinfo.charges = zeros(1, size(srcinfo.sources,2));
        H_ij2 = lfmm3d(eps,srcinfo,pg,targ,pgt);
        slp_pt2(j,:) = H_part2 + d_square .* targ(i,:) .* H_ij2.pottarg;
    end

end

%Finalize 
slp_fmm = slp_pt1 + slp_pt2;


