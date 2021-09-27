function [X,Y,Z] = make_grid_inv(sol, Nx, Ny, Nz)

%return to ndgrid shape 

    X = reshape(sol(1,:), [Nx, Ny, Nz]);
    Y = reshape(sol(2,:), [Nx, Ny, Nz]);
    Z = reshape(sol(3,:), [Nx, Ny, Nz]);
        
    
end