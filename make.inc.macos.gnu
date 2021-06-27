# makefile overrides
# OS:       macOS
# Compiler: gfortran 10.X
# OpenMP:   enabled
#

CC=gcc-10
CXX=g++-10
<<<<<<< HEAD
FC=gfortran-11
=======
FC=gfortran-10
>>>>>>> 23c1f07105bf60252b765fc738b5ec955577a767

ifeq ($(PREFIX),)
    FMM_INSTALL_DIR=/usr/local/lib
endif


CFLAGS += -I src 

# OpenMP with gcc on OSX needs the following
OMPFLAGS = -fopenmp
OMPLIBS = -lgomp

# MATLAB interface:
<<<<<<< HEAD
MFLAGS += -L/usr/local/lib/gcc/11
=======
MFLAGS += -L/usr/local/lib/gcc/10
>>>>>>> 23c1f07105bf60252b765fc738b5ec955577a767
MEX = $(shell ls -d /Applications/MATLAB_R202*.app)/bin/mex
#LIBS = -lm -lstdc++.6
#MEXLIBS= -lm -lstdc++.6 -lgfortran -ldl


