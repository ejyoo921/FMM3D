function H_part = sur_fmm_Hsum(j, bie_f, posint, eps, pg, targ, pgt)

ntarg = size(targ,2);
H_part = zeros(1, ntarg);

ns_part = size(posint,2);
srcinfo.sources = posint;

for i = 1:3
    
    if i == j
        srcinfo.charges = bie_f(i).*ones(1, ns_part);
    else
        srcinfo.charges = zeros(1,ns_part);
    end
    
    srcinfo.dipoles = -bie_f.*posint;
    
    H_11 = lfmm3d(eps, srcinfo, pg, targ, pgt);
    H_part = H_part + H_11.pottarg;
end

end