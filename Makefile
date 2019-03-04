#
# MIT License
# Copyright (c) 2019 Jonas Koenemann

# mex file extension depends on operation system
ifeq ($(OS),Windows_NT)
	MEX_EXT = mexw64
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		MEX_EXT = mexa64
	endif
	ifeq ($(UNAME_S),Darwin)
		MEX_EXT = mexmaci64
	endif
endif

# check for if MATLAB_DIR environment variable is set
ifeq ($(MATLAB_DIR),)
	MATLAB_PATH = /Applications/MATLAB_R2014b.app
	ifeq ($(wildcard $(MATLAB_DIR).*),)
		$(info Environment variable MATLAB_DIR not set!)
		$(error Use export MATLAB_DIR=/path/to/matlab/ on Unix.)
	endif
else
	MATLAB_PATH = ${MATLAB_DIR}
endif

# check for if CASADI_DIR environment variable is set
ifeq ($(CASADI_DIR),)
	CASADI_PATH = ../../Software/casadi-osx-matlabR2014b-v3.3.0/
	ifeq ($(wildcard $(CASADI_DIR).*),)
		$(info Environment variable CASADI_DIR not set!)
		$(error Use export CASADI_DIR=/path/to/casadi/ on Unix.)
	endif
else
	CASADI_PATH = ${MATLAB_DIR}
endif

# compiler arguments
CASADI = $(CASADI_PATH)/include/
CASADI_LIB = $(CASADI_PATH)

CPPFLAGS += -isystem $(CASADI)
CXXFLAGS += -g -Wall -Wextra -std=c++14 -Wfatal-errors

MEXINCLUDES = -I$(MATLAB_PATH)/extern/include
MEXFLAGS = -DMX_COMPAT_32 -DMATLAB_MEX_FILE -fno-common -arch x86_64 -fexceptions -fobjc-arc -DNDEBUG

INCLUDES = -I$(CASADI) $(MEXINCLUDES)
COMPILE_FLAGS = $(CPPFLAGS) $(CXXFLAGS) $(MEXFLAGS)

# linker arguments
MEX_LIBS = -L$(MATLAB_PATH)/bin/maci64
MEX_FLAGS = -arch x86_64 -bundle -lmx -lmex -lmat

LIBS = -L$(CASADI_LIB) $(MEX_LIBS)
LINK_FLAGS = -lcasadi -std=c++11 $(MEX_FLAGS)

all : casadi_mex.o casadi_mex.$(MEX_EXT)
clean:
	rm -f casadi_mex.o casadi_mex.mexmaci64 casadi_mex.mexa64 casadi_mex.mexw64

casadi_mex.o : casadi_mex.cc
	$(CXX) $(INCLUDES) $(COMPILE_FLAGS) -c $< -o $@

casadi_mex.$(MEX_EXT) : casadi_mex.o
	$(CXX) $(LIBS) $(LINK_FLAGS) $^ -o $@
