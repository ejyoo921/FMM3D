function H_part = sur_fmm_Hsum(j, bie_f, posint_H, eps, pg, targ, pgt)

ntarg = size(targ,2);
H_part = zeros(1, ntarg);

ns_H = size(posint_H,2);
srcinfo.sources = posint_H;

for i = 1:3
    v_mx = zeros(3, ns_H);
    
    if i == j
         srcinfo.charges = bie_f(i).*ones(1, ns_H);
    else
        srcinfo.charges = zeros(1,ns_H);
    end
    
    v_mx(j, :) = -bie_f(i).*posint_H(i,:);
    srcinfo.dipoles = -v_mx;
    
    H_11 = lfmm3d(eps, srcinfo, pg, targ, pgt);
    H_part = H_part + H_11.pottarg;
end

end