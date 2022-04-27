function [res, matlab_Vtime] = fmm_singular(Ck_fun, x0, y0, z0, xspan, yspan, zspan, tol)

% analytic values pack
tic

fun1 = @(x,y,z) Ck_fun(x,y,z)./(sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2));

fun23 = @(x,y,z) Ck_fun(x,y,z).*(z-z0).*(z-z0)./(sqrt((x-x0).^2 + (y-y0).^2 + (z-z0).^2)).^3;

xmin = xspan(1); xmax = xspan(end);
ymin = yspan(1); ymax = yspan(end);
zmin = zspan(1); zmax = zspan(end);

q1 = integral3(fun1,xmin,xmax,ymin,ymax,zmin,zmax,'AbsTol',tol);


q23 = -integral3(fun23,xmin,xmax,ymin,ymax,zmin,zmax,'AbsTol',tol);

res = [0; 0; q23+q1];

matlab_Vtime = toc;

end
