function slp_fmm = surf_integral(posint, dx, dy, targ, bie_f)
% posint = center of square faces : size should be 3 x something
% bie_f also has 3 x something form
% targ = target points
eps = 1e-10;

% few setups 
pg = 1;
pgt = 1;

ns = size(posint,2);
srcinfo.sources = posint; %xj (3 x N)

ntarg = size(targ,2);

% We compute each element in the volume integral 
%% part 1
slp_pt1 = zeros(3, ntarg);

H_11_sum = zeros(1, ntarg);
H_12_sum = zeros(1, ntarg);
H_13_sum = zeros(1, ntarg);

j = 1;
for i = 1:3
    v_mx = zeros(3, ns);
    
    if i == j
        srcinfo.charges = bie_f(i,:);
    else
        srcinfo.charges = zeros(1,ns);
    end
    
    v_mx(j,:) = bie_f(i,:).*posint(i,:);
    srcinfo.dipoles = -v_mx;
    
    H_11 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H_11_sum = H_11_sum + H_11.pottarg;
end
slp_pt1(j,:) = H_11_sum * (dx*dy);


j = 2;
for i = 1:3
    v_mx = zeros(3, ns);
    
    if i == j
        srcinfo.charges = bie_f(i,:);
    else
        srcinfo.charges = zeros(1,ns);
    end
    
    v_mx(j,:) = bie_f(i,:).*posint(i,:);
    srcinfo.dipoles = -v_mx;
    
    H_12 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H_12_sum = H_12_sum + H_12.pottarg;
end
slp_pt1(j,:) = H_12_sum * (dx*dy);


j = 3;
for i = 1:3
    v_mx = zeros(3, ns);
    
    if i == j
        srcinfo.charges = bie_f(i,:);
    else
        srcinfo.charges = zeros(1,ns);
    end
    
    v_mx(j,:) = bie_f(i,:).*posint(i,:);
    srcinfo.dipoles = -v_mx;
    H_13 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H_13_sum = H_13_sum + H_13.pottarg;
end
slp_pt1(j,:) = H_13_sum * (dx*dy);


%% pt 2
slp_pt2 = zeros(3, ntarg);

H_21_sum = zeros(1, ntarg);
H_22_sum = zeros(1, ntarg);
H_23_sum = zeros(1, ntarg);

srcinfo.charges = zeros(1,ns);

j = 1;
for i = 1:3
    v_mx2 = zeros(3, ns);
    v_mx2(j,:) = bie_f(i,:);
    srcinfo.dipoles = v_mx2;
    
    H_21 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H_21_sum = H_21_sum + targ(i,:).*H_21.pottarg;
end
slp_pt2(j,:) = H_21_sum * (dx*dy);


j = 2;
for i = 1:3
    v_mx2 = zeros(3, ns);
    v_mx2(j,:) = bie_f(i,:);
    srcinfo.dipoles = v_mx2;
    
    H_22 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H_22_sum = H_22_sum + targ(i,:).*H_22.pottarg;
end
slp_pt2(j,:) = H_22_sum * (dx*dy);


j = 3;
for i = 1:3
    v_mx2 = zeros(3, ns);
    v_mx2(j,:) = bie_f(i,:);
    srcinfo.dipoles = v_mx2;
    
    H_23 = lfmm3d(eps,srcinfo,pg,targ,pgt);
    H_23_sum = H_23_sum + targ(i,:).*H_23.pottarg;
end
slp_pt2(j,:) = H_23_sum * (dx*dy);

%% Finalize 
slp_fmm = slp_pt1 + slp_pt2;

% Add one more part : direct computation when source == targ

% Add singularity point (not for now, 09/15/22)
% singular = zeros(size(xyz,2), size(targ,2));
% for ii = 1:size(xyz,2)
%     for jj = 1:size(targ,2)
%         
%         if norm(xyz(:,ii) - targ(:,jj)) < 1e-6
%             singular(ii, jj) = 1; %missing part
%             Volume(:,jj) = Volume(:,jj) + f_bie(ii).*CG_singular;
%         end
%         
%     end
% end

end




