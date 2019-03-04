#
# MIT License
# Copyright (c) 2019 Jonas Koenemann

# compiler arguments
MATLAB_DIR = /Applications/MATLAB_R2014b.app

CASADI = ../../Software/casadi-osx-matlabR2014b-v3.3.0/include/
CASADI_LIB = ../../Software/casadi-osx-matlabR2014b-v3.3.0/

CPPFLAGS += -isystem $(CASADI)
CXXFLAGS += -g -Wall -Wextra -std=c++14 -Wfatal-errors

MEXINCLUDES = -I$(MATLAB_DIR)/extern/include
MEXFLAGS = -DMX_COMPAT_32 -DMATLAB_MEX_FILE -fno-common -arch x86_64 -fexceptions -fobjc-arc -DNDEBUG

INCLUDES = -I$(CASADI) $(MEXINCLUDES)
COMPILE_FLAGS = $(CPPFLAGS) $(CXXFLAGS) $(MEXFLAGS)

# linker arguments
MEX_LIBS = -L$(MATLAB_DIR)/bin/maci64
MEX_FLAGS = -arch x86_64 -bundle -lmx -lmex -lmat

LIBS = -L$(CASADI_LIB) $(MEX_LIBS)
LINK_FLAGS = -lcasadi -std=c++11 $(MEX_FLAGS)

all : casadi_mex.o casadi_mex.mexmaci64
clean:
	rm -f *.o	*.dylib *.mex*

casadi_mex.o : casadi_mex.cc
	$(CXX) $(INCLUDES) $(COMPILE_FLAGS) -c $< -o $@

casadi_mex.mexmaci64 : casadi_mex.o
	$(CXX) $(LIBS) $(LINK_FLAGS) $^ -o $@
