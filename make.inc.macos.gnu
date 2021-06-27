# makefile overrides
# OS:       macOS
# Compiler: gfortran 9.X
# OpenMP:   enabled
#

CC=gcc-10
CXX=g++-10
FC=gfortran-11

ifeq ($(PREFIX),)
    FMM_INSTALL_DIR=/usr/local/lib
endif


CFLAGS += -I src 

# OpenMP with gcc on OSX needs the following
OMPFLAGS = -fopenmp
OMPLIBS = -lgomp

# MATLAB interface:
MFLAGS += -L/usr/local/lib/gcc/11
MEX = $(shell ls -d /Applications/MATLAB_R202*.app)/bin/mex
#LIBS = -lm -lstdc++.6
#MEXLIBS= -lm -lstdc++.6 -lgfortran -ldl


