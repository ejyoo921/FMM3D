function res = make_grid_inv(sol, Nx, Ny, Nz)

    X = reshape(sol(1,:), [Nx, Ny, Nz]);
    Y = reshape(sol(2,:), [Nx, Ny, Nz]);
    Z = reshape(sol(3,:), [Nx, Ny, Nz]);
        
    
end