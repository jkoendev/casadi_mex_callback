%
% MIT License
% Copyright (c) 2019 Jonas Koenemann
function testCasadiMex
  a = casadi.SX.sym('x');

  x = CasadiSym('x', [3,2])
  y = cos(x)

  new_var = CasadiSym.call(@callFun)

end

function r = callFun(v)
  disp('In callback function.');
  r = v;
  r = cos(r);
end
