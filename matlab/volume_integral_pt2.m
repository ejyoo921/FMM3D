function Volume = volume_integral_pt2(perturb_Ck, targ, dx, ntarg, ns, eps, pg, pgt)

const = zeros(1,ns);
for n = 1:ns
    cn = perturb_Ck(n);
    const(n) = cn;
end

Volume = zeros(3, ntarg);

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
        srcinfo.charges = perturb_Ck;
        vj3 = [zeros(1,ns); zeros(1,ns); const;];
        srcinfo.dipoles = vj3;
    end
    
    U = lfmm3d(eps, srcinfo, pg, targ, pgt);
    Volume(j,:) = U.pottarg .* (dx^3);
end