function xyz = make_grid(lev, Nx)

    %setup grid points
    xvec = repmat(lev, 1, Nx);
    yvec = [];

    for i = 1:Nx
        yvec = [yvec, repmat(lev(i), 1, Nx)];
    end
    xy = [xvec; yvec];
    xyz = [];
    for z = 1:Nx
        zlev = [xy; lev(z)*ones(1, Nx^2)];
        xyz = [xyz, zlev];
    end
    
end