function xyz = make_grid(xlev, ylev, zlev)

% Best one - From ndgrid to FMM3D Package form 

    [X,Y,Z] = ndgrid(xlev, ylev, zlev);
    xyz = [X(:)'; Y(:)'; Z(:)'];
    
end