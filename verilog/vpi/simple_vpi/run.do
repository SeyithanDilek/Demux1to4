#
# Copyright 1991-2015 Mentor Graphics Corporation
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
# OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
#
# To run this example, bring up the simulator and type the following at the prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -c -do run.do
# (omit the "-c" to see the GUI while running from the shell)
#

onerror {resume}
# Create the library.
if [file exists work] {
    vdel -all
}
vlib work

# Get the simulator installation directory.
quietly set INSTALL_HOME [file dirname [file nativename $::env(MODEL_TECH)]]

# Set the compiler and linker paths.
if {$tcl_platform(platform) eq "windows"} {
	source $INSTALL_HOME/examples/c_windows/setup/setup_compiler_and_linker_paths_mingwgcc.tcl
} else {
	source $INSTALL_HOME/examples/c_posix/setup/setup_compiler_and_linker_paths_gcc.tcl
}

# Compile the HDL source(s)
vlog prim.v dff.v top.v

# Compile the C source(s).
echo $CC vpi_test.c
eval $CC vpi_test.c
echo $LD vpi_test.$ext vpi_test.o $MTIPLILIB
eval $LD vpi_test.$ext vpi_test.o $MTIPLILIB

# Simulate the design.
vsim -c top -pli vpi_test.$ext
run -all
quit -f
