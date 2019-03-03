#
# MIT License
# Copyright (c) 2019 Jonas Koenemann

CASADI = ../../Software/casadi-osx-matlabR2014b-v3.3.0/include/
CASADI_LIB = ../../Software/casadi-osx-matlabR2014b-v3.3.0/

CPPFLAGS += -isystem $(CASADI)
CXXFLAGS += -g -Wall -Wextra -std=c++14 -Wfatal-errors

INCLUDES = -I$(CASADI)

all : casadi_mex.o
clean:
	rm -f *.o	/*.dylib

casadi_mex.o : casadi_mex.cc
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(INCLUDES) -c $< -o $@

casadi_mex.dylib : casadi_mex.o
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -L$(CASADI_LIB) -lcasadi $^ -o $@
