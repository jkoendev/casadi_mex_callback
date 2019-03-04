classdef CasadiSym < handle

  properties
    idx
  end

  methods (Static)
    function r = call(fh)
      
      function r_idx = fh_wrapper(idx)
        obj = CasadiSym(idx);
        r = fh(obj);
        r_idx = r.idx;
      end
      
      r_idx = casadi_mex('call', @fh_wrapper);
      r = CasadiSym(r_idx);
    end
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
