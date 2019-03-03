//
// MIT License
// Copyright (c) 2019 Jonas Koenemann

#include <vector>
#include <iostream>
#include <cassert>
#include <map>

#include "mex.h"
#include "matrix.h"

#include "casadi/casadi.hpp"

static std::map<int, casadi::SX> symbolics;
static int num_symbolics = 0;

bool isFunctionHandle(const mxArray* in_arr) {
  return mxIsClass(in_arr,"function_handle");
}

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

std::string mxToString(const mxArray* in_arr)
{
  mexAssert(mxIsChar(in_arr), "Argument must be string.");

  size_t n_chars = mxGetN(in_arr);
  char fcn_name[n_chars+1];
  mxGetString(in_arr, fcn_name, n_chars+1);
  return std::string(fcn_name);
}

// const std::string& callCallbackFunction(const std::string& sym_id)
// {
//   mxArray* in_arr = mxCreateString(sym_id.c_str());
//
//   mxArray* inputs[1];
//   inputs[0] = in_arr;
//
//   int status;
//   mxArray* outputs[];
//   status = mexCallMATLAB(1, outputs, 1, inputs, "mex_callback");
//
//   std::string output_id = mxToString(outputs[0])
//
//   // free allocated memory
//   mxDestroyArray(in_arr);
//   return output_id;
// }

std::vector<double> mxToNumericVec(const mxArray* in_arr)
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
  std::string fcn_name = mxToString(prhs[0]);

  if (fcn_name.compare("create") == 0) {

    // call args are:
    //  prhs[0] "create" : string
    //  prhs[1] id : string
    //  prhs[2] shape : numeric

    mexAssert(nrhs >= 3, "Not enough input arguments.");

    std::string id = mxToString(prhs[1]);
    std::vector<double> shape = mxToNumericVec(prhs[2]);

    mxAssert(shape.size() == 2, "Shape must be of length 2.");

    // create symbolic and insert to map of symbolics, remember index
    casadi::SX var = casadi::SX::sym(id, (int)shape[0], (int)shape[1]);
    symbolics[num_symbolics] = var;
    int idx = num_symbolics;
    num_symbolics++;

    // return index of symbolic
    mexAssert(nlhs >= 1, "Output argument for index required");
    plhs[0] = mxCreateDoubleScalar((double)idx);

  } else if (fcn_name.compare("cos") == 0)
  {
    // call args are:
    //  prhs[0] "cos" : string
    //  prhs[1] idx : int
    mexAssert(nrhs >= 2, "Not enough input arguments.");

    int idx = (int)mxGetScalar(prhs[1]);
    casadi::SX var = symbolics[idx];

    casadi::SX new_symbol = casadi::SX::cos(var);
    symbolics[num_symbolics] = new_symbol;
    int new_idx = num_symbolics;
    num_symbolics++;

    // return index of symbolic
    mexAssert(nlhs >= 1, "Output argument for index required");
    plhs[0] = mxCreateDoubleScalar((double)new_idx);

  } else if (fcn_name.compare("disp") == 0)
  {
    mexAssert(nrhs >= 2, "Not enough input arguments.");

    int idx = (int)mxGetScalar(prhs[1]);
    casadi::SX var = symbolics[idx];
    std::stringstream out_str;
    out_str << var << std::endl;
    display(out_str.str());

  } else
  {
    // call args are:
    //  prhs[0] "disp" : string
    //  prhs[1] idx : int
    mexError("Command not recognized.");
  }
}
