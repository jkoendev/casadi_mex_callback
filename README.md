# Casadi MEX callback
Creating casadi symbolics in c++ from matlab, and passing them to matlab through callback functions.

This program is only tested on my personal computer:  
Matlab 2014b, Mac OS X El Capitan, Casadi 3.3

You might have to adapt the makefile for your configuration.

Specify your Matlab and CasADi installations using the MATLAB_DIR and CASADI_DIR environment variables.
Then use GNU ```make``` to compile the MEX source:
```
export MATLAB_DIR=/path/to/matlab
export CASADI_DIR=/path/to/casadi
make
```

Run ```testCasadiMex.m```in MATLAB.

MIT License  
Copyright 2019 Jonas Koenemann  
