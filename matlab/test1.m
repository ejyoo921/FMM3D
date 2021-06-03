%

disp("This is an example matlab driver");
disp("On output the code prints the pot+grad in example1 and, pot+pottarg in example2");
disp(" ");
disp(" ");
%%   source to source, charges only, pot+grad example
%

clear srcinfo ns U eps pg;
disp("Example 1: source to source, charge, pot+grad");
disp(" ");
disp(" ");

ns = 27;
lev = linspace(1, 5, 3);
xvec = [lev, lev, lev];
yvec = [1,1,1, 3,3,3, 5,5,5];
xy = [xvec; yvec];
xyz = [];

for z = 1:2:5
    zlev = [xy; z * ones(1,9)];
    xyz = [xyz, zlev];
end

srcinfo.sources = xyz; %xj
srcinfo.charges = ones(1,ns); %cj
srcinfo.dipoles = zeros(3,ns); %vj

eps = 1e-5;
pg = 1;
% targ = zeros(3,1);
targ = [1; 1; 1];
pgt = 1;

U = lfmm3d(eps,srcinfo,pg,targ,pgt);
% disp("pot=");
% disp(U.pot(1:9));
% disp("grad=");
% disp(U.grad(:,1:3));
uval = U.pottarg;

%% check error
ux = 0;
for j = 2:ns
    src = xyz(:,j);
    
    dist = sqrt((src(1)-targ(1))^2 + (src(2)-targ(2))^2 + (src(3)-targ(3))^2);
    ux = ux + 1/dist;
end
