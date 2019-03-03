%
% MIT License
% Copyright (c) 2019 Jonas Koenemann

function idx = create_sym(id,shape)

idx = casadi_mex('create',id,shape);

end
