function H2_part = sur_fmm_Hsum2(j, bie_f, eps, posint_H, pg, targ, pgt)


ntarg = size(targ,2);
H2_part = zeros(1, ntarg);

ns_H = size(posint_H,2);

srcinfo.charges = zeros(1,ns_H);
srcinfo.sources = posint_H;

for i = 1:3
    v_mx2 = zeros(3, ns_H);
    v_mx2(j,:) = bie_f(i).*ones(1,ns_H);
    
    srcinfo.dipoles = v_mx2;
    
    H_21 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H2_part = H2_part + targ(i,:).*H_21.pottarg;
end

end
