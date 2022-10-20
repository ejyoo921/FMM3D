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
for j = 1:3
    
    for nn = 1:ns
        normal_dir = ndir(nn);
        bie_f_n = bie_f(:,nn);
        
        
        if normal_dir == 1

            ySpan = posint(2,nn)-1+dSx:dSx:posint(2,nn)+1-dSx; 
            zSpan = posint(3,nn)-1+dSz:dSz:posint(3,nn)+1-dSz; 
            xSpan = posint(1,nn);

            ySpan = posint(2,nn) + (dSy).*x2;
            zSpan = posint(3,nn) + (dSz).*x3;
            
    

            posint_H = make_grid(xSpan, ySpan, zSpan);
            
            H_part  = (dSy*dSz).*sur_fmm_Hsum(j, bie_f_n, posint_H, eps, pg, targ, pgt);            
            H2_part = (dSy*dSz).*sur_fmm_Hsum2(j,  bie_f_n, eps, posint_H, pg, targ, pgt);
            
        elseif normal_dir == 2

            xSpan = posint(1,nn)-1+dSx:dSx:posint(1,nn)+1-dSx; 
            zSpan = posint(3,nn)-1+dSz:dSz:posint(3,nn)+1-dSz; 
            ySpan = posint(2,nn);

            xSpan = posint(1,nn) + (dSx).*x1;
            zSpan = posint(3,nn) + (dSz).*x3;
            
            posint_H = make_grid(xSpan, ySpan, zSpan);
            
            H_part = (dSx*dSz).*sur_fmm_Hsum(j, bie_f_n, posint_H, eps, pg, targ, pgt);        
            H2_part = (dSx*dSz).*sur_fmm_Hsum2(j, bie_f_n, eps, posint_H, pg, targ, pgt);
            
        else %normal dir = 3
            
            xSpan = posint(1,nn)-1+dSx:dSx:posint(1,nn)+1-dSx; 
            ySpan = posint(2,nn)-1+dSx:dSx:posint(2,nn)+1-dSx;
            zSpan = posint(3,nn);

            xSpan = posint(1,nn) + (dSx).*x1;
            ySpan = posint(2,nn) + (dSy).*x2;
            
            posint_H = make_grid(xSpan, ySpan, zSpan);
             
            H_part = (dSx*dSy).*sur_fmm_Hsum(j, bie_f_n, posint_H, eps, pg, targ, pgt);
            H2_part = (dSx*dSy).*sur_fmm_Hsum2(j, bie_f_n, eps, posint_H, pg, targ, pgt);
            
            
        end
        
        slp_pt1(j,:) = slp_pt1(j,:) + H_part;
        slp_pt2(j,:) = slp_pt2(j,:) + H2_part;
    end
end


%% Finalize 
slp_fmm = slp_pt1 + slp_pt2;

% Add one more part : direct computation when source == targ
% if vel_compute
% for ii = 1:size(posint,2)
%     slp_fmm(:,ii) = slp_fmm(:,ii) + Ck(ii).*singular;
% end
% % else
%     for ii = 1:size(xyz,2)
%         for jj = 1:size(targ,2)
%             if norm(xyz(:,ii) - targ(:,jj)) < 1e-6
%                 slp_fmm(:,jj) = slp_fmm(:,jj) + Ck(ii).*singular;
%             end
%         end
%     end
% end

% end




