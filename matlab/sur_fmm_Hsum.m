function H_part = sur_fmm_Hsum(j, ns, bie_f, posint, eps, srcinfo, pg, targ, pgt)
ntarg = size(targ,2);
H_part = zeros(1, ntarg);

% j = 1;
for i = 1:3
    v_mx = zeros(3, ns);
    
    if i == j
        srcinfo.charges = bie_f(i).*ones(1, ns);
    else
        srcinfo.charges = zeros(1,ns);
    end
    
    v_mx(j,i) = bie_f(i).*posint(i);
    srcinfo.dipoles = -v_mx;
    
    H_11 = lfmm3d(eps, srcinfo, pg, targ, pgt);
    H_part = H_part + H_11.pottarg;
end
% slp_pt1(j,:) = H_11_sum * (dS1*dS2);


% j = 2;
% for i = 1:3
%     v_mx = zeros(3, ns);
%     
%     if i == j
%         srcinfo.charges = bie_f(i,:);
%     else
%         srcinfo.charges = zeros(1,ns);
%     end
%     
%     v_mx(j,:) = bie_f(i,:).*posint(i,:);
%     srcinfo.dipoles = -v_mx;
%     
%     H_12 = lfmm3d(eps,srcinfo,pg,targ,pgt);
%     H_12_sum = H_12_sum + H_12.pottarg;
% end
% slp_pt1(j,:) = H_12_sum * (dSx*dSy);
% 
% 
% % j = 3;
% for i = 1:3
%     v_mx = zeros(3, ns);
%     
%     if i == j
%         srcinfo.charges = bie_f(i,:);
%     else
%         srcinfo.charges = zeros(1,ns);
%     end
%     
%     v_mx(j,:) = bie_f(i,:).*posint(i,:);
%     srcinfo.dipoles = -v_mx;
%     
%     H_13 = lfmm3d(eps,srcinfo,pg,targ,pgt);
%     H_13_sum = H_13_sum + H_13.pottarg;
% end
% slp_pt1(j,:) = H_13_sum * (dSx*dSy);
