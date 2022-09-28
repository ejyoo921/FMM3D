function H2_part = sur_fmm_Hsum2(j, ns, bie_f, eps, srcinfo, pg, targ, pgt)


ntarg = size(targ,2);
H2_part = zeros(1, ntarg);

srcinfo.charges = zeros(1,ns);

for i = 1:3
    v_mx2 = zeros(3, ns);
    v_mx2(j,i) = bie_f(i);
    
    srcinfo.dipoles = v_mx2;
    
    H_21 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H2_part = H2_part + targ(i,:).*H_21.pottarg;
end

end
