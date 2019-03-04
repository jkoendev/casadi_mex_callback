# Casadi MEX callback
Creating casadi symbolics in c++ from matlab, and passing them to matlab through callback functions.

Visit [https://openocl.org](https://openocl.org) for more information.

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

Expected output: 

```
>> testCasadiMex

x = 


[[x_0, x_3], 
 [x_1, x_4], 
 [x_2, x_5]]


y = 


[[cos(x_0), cos(x_3)], 
 [cos(x_1), cos(x_4)], 
 [cos(x_2), cos(x_5)]]

In callback function.

new_var = 


[[cos(vv_0), cos(vv_5), cos(vv_10), cos(vv_15), cos(vv_20)], 
 [cos(vv_1), cos(vv_6), cos(vv_11), cos(vv_16), cos(vv_21)], 
 [cos(vv_2), cos(vv_7), cos(vv_12), cos(vv_17), cos(vv_22)], 
 [cos(vv_3), cos(vv_8), cos(vv_13), cos(vv_18), cos(vv_23)], 
 [cos(vv_4), cos(vv_9), cos(vv_14), cos(vv_19), cos(vv_24)]]

```

MIT License  
Copyright 2019 Jonas Koenemann  
