classdef CasadiSym < handle

  properties
    idx
  end

  methods
    function self = CasadiSym(id, shape)
      if nargin == 2
        id = casadi_mex('create', id, shape);
      end
      self.idx = id;
    end

    function disp(self)
      casadi_mex('disp', self.idx);
    end

    function r = cos(self)
      new_idx = casadi_mex('cos', self.idx);
      r = CasadiSym(new_idx);
    end

  end

end
