function [res, matlab_Vtime] = fmm_test_analytic(Ck_fun, x0, y0, z0, xspan, yspan, zspan, tol)

% analytic values pack
tic
% Ck = perturb_Ck
% x0 = 2; 
% y0 = 2; 
% z0 = 2;

fun1 = @(x,y,z) Ck_fun(x,y,z)./(sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2));

fun21 = @(x,y,z) Ck_fun(x,y,z).*(x-x0).*(z-z0)./(sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2)).^3;
fun22 = @(x,y,z) Ck_fun(x,y,z).*(y-y0).*(z-z0)./(sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2)).^3;
fun23 = @(x,y,z) Ck_fun(x,y,z).*(z-z0).*(z-z0)./(sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2)).^3;

xmin = xspan(1); xmax = xspan(end);
ymin = yspan(1); ymax = yspan(end);
zmin = zspan(1); zmax = zspan(end);

q1 = integral3(fun1,xmin,xmax,ymin,ymax,zmin,zmax,'AbsTol',tol);

q21 = -integral3(fun21,xmin,xmax,ymin,ymax,zmin,zmax,'AbsTol',tol);
q22 = -integral3(fun22,xmin,xmax,ymin,ymax,zmin,zmax,'AbsTol',tol);
q23 = -integral3(fun23,xmin,xmax,ymin,ymax,zmin,zmax,'AbsTol',tol);

res = [q21, q22, q23+q1]';
matlab_Vtime = toc;

end
