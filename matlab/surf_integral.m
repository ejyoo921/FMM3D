function slp_fmm = surf_integral(posint, dx, dy, dz, targ, bie_f)
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

%% For a fixed j term - need to do a dot product first 


% We compute each element in the volume integral 
slp_pt1 = zeros(3, ntarg);
v_mx = zeros(3, ns);
H_11_sum = zeros(1, ntarg);
H_12_sum = zeros(1, ntarg);
H_13_sum = zeros(1, ntarg);

for j = 1:3
    if j == 1
        for i = 1:3
            srcinfo.charges = bie_f(i,:); 
            v_mx(i,:) = bie_f(i,:).*posint(i,:);
            srcinfo.dipoles = v_mx;
            H_11 = lfmm3d(eps,srcinfo,pg,targ,pgt);
            H_11_sum = H_11_sum + H_11.pottarg;
        end
        slp_pt1(j,:) = H_11_sum * (dx*dy*dz);

    elseif j == 2
        for i = 1:3
            srcinfo.charges = bie_f(i,:);
            v_mx(i,:) = bie_f(i,:).*posint(i,:);
            srcinfo.dipoles = v_mx;
            H_12 = lfmm3d(eps,srcinfo,pg,targ,pgt);
            H_12_sum = H_12_sum + H_12.pottarg;
        end
        slp_pt1(j,:) = H_12_sum * (dx*dy*dz);

    else % j==3
        for i = 1:3
            srcinfo.charges = bie_f(i,:);
            v_mx(i,:) = bie_f(i,:).*posint(i,:);
            srcinfo.dipoles = v_mx;
            H_13 = lfmm3d(eps,srcinfo,pg,targ,pgt);
            H_13_sum = H_13_sum + H_13.pottarg;
        end
        slp_pt1(j,:) = H_13_sum * (dx*dy*dz);

    end
   
end

%work on this after lunch!
slp_pt2 = zeros(3, ntarg);
srcinfo.charges = zeros(1,ns);

v_mx2 = zeros(3, ns);
H_21_sum = zeros(1, ntarg);
H_22_sum = zeros(1, ntarg);
H_23_sum = zeros(1, ntarg);
% for extra term
for j = 1:3
    if j == 1
        for i = 1:3
            v_mx2(i,:) = bie_f(i,:);
            srcinfo.dipoles = v_mx2;
            H_21 = lfmm3d(eps,srcinfo,pg,targ,pgt);
            H_21_sum = H_21_sum + H_21.pottarg;
        end
        slp_pt2(j,:) = targ(j,:).*H_21_sum * (dx*dy*dz);

    elseif j == 2
        for i = 1:3
            v_mx2(i,:) = bie_f(i,:);
            srcinfo.dipoles = v_mx2;
            H_22 = lfmm3d(eps,srcinfo,pg,targ,pgt);
            H_22_sum = H_22_sum + H_22.pottarg;
        end
        slp_pt2(j,:) = targ(j,:).*H_22_sum * (dx*dy*dz);

    else % j==3
        for i = 1:3
            v_mx2(i,:) = bie_f(i,:);
            srcinfo.dipoles = v_mx2;
            H_23 = lfmm3d(eps,srcinfo,pg,targ,pgt);
            H_23_sum = H_23_sum + H_23.pottarg;
        end
        slp_pt2(j,:) = targ(j,:).*H_23_sum * (dx*dy*dz);

    end
    
    U_targ = lfmm3d(eps,srcinfo,pg,targ,pgt);
    
    x3m = targ(end,:);
    slp_pt2(j,:) = x3m.*U_targ.pottarg .* (dx*dy*dz);
end

% Add one more part : direct computation when source == targ

slp_fmm = slp_pt1 - slp_pt2;

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




