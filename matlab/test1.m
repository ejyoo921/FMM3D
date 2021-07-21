%

disp("This is an example matlab driver");
disp("On output the code prints the pot+grad in example1 and, pot+pottarg in example2");
disp(" ");
disp(" ");
%%   source to source, charges only, pot+grad example
clear srcinfo ns U eps pg;
disp("Example 1: source to source, charge, pot+grad");
disp(" ");
disp(" ");

ns = 3^3;
lev = linspace(1, 5, 3);
xvec = [lev, lev, lev];
yvec = [1,1,1, 3,3,3, 5,5,5];
xy = [xvec; yvec];
xyz = [];

for z = 1:2:5
    zlev = [xy; z * ones(1,9)];
    xyz = [xyz, zlev];
end

eps = 1e-5;
pg = 1;
targ = [[9;10;11], [1;2;3]];
pgt = 1;

srcinfo.sources = xyz; %xj (R3 x N)

% set cj values for each 'n' 
% srcinfo.charges = ones(1,ns); %cj (R1 x N)
srcinfo.charges = 1:ns;

%make vj realted to the sources 
vj3 = [];
for n = 1:ns
    c3n = srcinfo.charges(n);
    xn = xyz(:,n);
    x3n = xn(3);
    const = c3n * x3n;
    
    vn3 = [0; 0; const];
    vj3 = [vj3, vn3];    
end
srcinfo.dipoles = vj3;

U = lfmm3d(eps,srcinfo,pg,targ,pgt);
% disp("pot=");
% disp(U.pot(1:9));
% disp("grad=");
% disp(U.grad(:,1:3));
uval = U.pottarg;
    x3m = targ(3,:); % bring all third elements in target points
    x3m .* uval;
disp(uval)



%% check error for vj \cdot gradient(1/rnm) term only
% ux = 0;
% 
% for j = 1:ns
%     src = xyz(:,j);
%     
%     r_nm = sqrt((src(1)-targ(1))^2 + (src(2)-targ(2))^2 + (src(3)-targ(3))^2);
%     
%     if r_nm == 0
%         ux = ux;
%     else
%         cj = srcinfo.charges(j);
%         ux = ux + cj/r_nm;
%     end
%     
% end
% disp(ux)

%% check error for cj/rnm term only
% ux = 0;
% for j = 1:ns
%     src = xyz(:,j);
%     
%     r_nm = sqrt((targ(1) - src(1))^2 + (targ(2) - src(2))^2 + (targ(3) - src(3))^2);
%     x_m_xj = [targ(1) - src(1); targ(2) - src(2); targ(3) - src(3)];
%     
%     if r_nm == 0
%         ux = ux;
%     else
%         vj = srcinfo.dipoles(:,j)';
%         ux = ux +  vj * (-x_m_xj)/(r_nm)^3;
%     end
%     
% end
% ux = -ux;
% disp(ux)
% 
%% check error for entire sum
% ux = zeros(1,2);
% for j = 1:ns
%     src = xyz(:,j);
%     for i = 1:2
%         r_nm = ((targ(1,i) - src(1)).^2 + (targ(2,i) - src(2)).^2 + (targ(3,i) - src(3)).^2).^(1/2);
%         x_m_xj = [targ(1,i) - src(1); targ(2,i) - src(2); targ(3,i) - src(3)];
% 
%         if r_nm == 0
%             ux = ux;
%         else
%             cj = srcinfo.charges(j);
%             vec_vj = srcinfo.dipoles(:,j)';
%             ux(j,:) = ux(j,:) + cj/r_nm  - vec_vj * (-x_m_xj)/(r_nm)^3;
%         end
%     end
% end
%% check error for entire sum with Multiple targets

ux = zeros(1,2);
for i = 1:2
    for j = 1:ns
        src = xyz(:,j);
        r_nm = ((targ(1,i) - src(1)).^2 + (targ(2,i) - src(2)).^2 + (targ(3,i) - src(3)).^2).^(1/2);
        x_m_xj = [targ(1,i) - src(1); targ(2,i) - src(2); targ(3,i) - src(3)];
        
        if r_nm == 0
            ux = ux;
        else
            cj = srcinfo.charges(j);
            vec_vj = srcinfo.dipoles(:,j)';
            ux(:,i) = ux(:,i) + cj/r_nm  - vec_vj * (-x_m_xj)/(r_nm)^3;
        end
    end
end

    
disp(ux)
