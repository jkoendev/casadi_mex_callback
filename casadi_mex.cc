//
// MIT License
// Copyright (c) 2019 Jonas Koenemann

#include <vector>
#include <iostream>
#include <cassert>

#include "mex.h"
#include "matrix.h"

#include "casadi/casadi.hpp"

void display(const std::string str)
{
  mexPrintf("%s\n", str.c_str());
}

void mexError(std::string str)
{
  mexErrMsgIdAndTxt("casadi_mex:mexError", str.c_str());
}

void mexAssert(bool cond, std::string str)
{
  if (!cond)
  {
    mexError(str);
  }
}

std::string to_string(const mxArray* in_arr)
{
  mexAssert(mxIsChar(in_arr), "Argument must be string.");

  size_t n_chars = mxGetN(in_arr);
  char fcn_name[n_chars+1];
  mxGetString(in_arr, fcn_name, n_chars+1);
  return std::string(fcn_name);
}

std::vector<double> to_numeric_vec(const mxArray* in_arr)
{
  mexAssert(mxIsDouble(in_arr) && !mxIsComplex(in_arr), "Invalid convertion from mx type to vector.");

  int nv = (int) mxGetNumberOfElements(in_arr);
  std::vector<double> vec(nv);

  double* data = mxGetPr(in_arr);
  for(unsigned int i=0; i<nv; i++)
  {
    vec[i] = *data++;
  }
  return vec;
}

// Main entry point of mex program
// Args:
//  nlhs: Number of outputs (left hand side)
//  plhs: Outputs
//  nrhs: Number of inputs (right hand side)
//  prhs: Inputs
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{

  mexAssert(nrhs >=  1, "Not enough input arguments.");

  // First input is always the function identifier as string
  std::string fcn_name = to_string(prhs[0]);

  if (fcn_name.compare("create") == 0) {

    // call args are:
    //  prhs[0] "create" : string
    //  prhs[1] name : string
    //  prhs[2] shape : numeric

    mexAssert(nrhs >= 3, "Not enough input arguments.");

    std::string name = to_string(prhs[1]);
    std::vector<double> shape = to_numeric_vec(prhs[2]);

    mexAssert(shape.size() == 2, "Shape must be of length 2.");
    casadi::SX var = casadi::SX::sym(name, (int)shape[0], (int)shape[1]);

    std::stringstream out_str;

    out_str << name << std::endl;
    out_str << var << std::endl;

    display(out_str.str());


  } else if (fcn_name.compare("call") == 0) {

  } else {
    mexError("Command not recognized.");
  }
}
