
## Detailed Description:
##Prepare and set fuctions and libraries
##
## -----------------------------------------------------------------------------
if {$argc < 1 || $argc > 3} {
    error "wrong number of arguments"
}

# set path variables
set this_path          [file normalize .]
set root_path          [file normalize "../../../"]
set enviroments_path   [file normalize "../../enviroments"]
#set project_path [file normalize "$root_path/CORE_project_path"]
#set tcl_pkgs_path     file normalize "$root_path/fpga_ci_tools/tcl/pkgs"  // TODO issue#123
set QSYS_SIMDIR        "$root_path/rtl/qsys_top/sim"

#lappend auto_path $tcl_pkgs_path

# remove work directory
catch {file delete -force ./work}

set working_dir $this_path

set working_lib_path $working_dir/work

# quit previous sim and cleanup work directory
cd $working_dir
quit -sim

set uvm_testname $1

# create dir libs
vlib $this_path/libraries/work
#vmap project_lib work

# Initialize variables
set TOP_LEVEL_NAME "project.project"
set USER_DEFINED_COMPILE_OPTIONS ""
set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
set USER_DEFINED_ELAB_OPTIONS ""
set SILENCE "false"
set FORCE_MODELSIM_AE_SELECTION "false"

# ----------------------------------------
# Source Common Tcl File
## source $QSYS_SIMDIR/common/modelsim_files.tcl  // TODO issue#123

# ----------------------------------------
# Create compilation libraries

set logical_libraries [list "work" "work_lib" "lpm_ver" "sgate_ver" "altera_ver" "altera_mf_ver" "altera_lnsim_ver" "fourteennm_ver" "fourteennm_hssi_ver" "lpm" "sgate" "altera" "altera_mf" "altera_lnsim" "fourteennm" "fourteennm_hssi"]

proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/
ensure_lib          ./libraries/work/
vmap       project_work     ./libraries/work/
vmap       project_work_lib ./libraries/work/

# ----------------------------------------
# setup shared libraries

#set design_libraries [dict create]
#set design_libraries [dict merge $design_libraries [qsys_top::get_design_libraries]]
#set libraries [dict keys $design_libraries]
#foreach library $libraries {
#  ensure_lib ./libraries/$library/
#  vmap $library  ./libraries/$library/
#  lappend logical_libraries $library
#}  // TODO issue#123

# ----------------------------------------
# Compile the design files in correct order
alias com {
  if [string is false -strict $SILENCE] {
    echo "\[exec\] com"
  }
  set design_files [dict create]
  set design_files [dict merge [qsys_top::get_common_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR"]]
  set common_design_files [dict values $design_files]
  foreach file $common_design_files {
    eval $file
  }
  set design_files [list]
  set design_files [concat $design_files [qsys_top::get_design_files $USER_DEFINED_COMPILE_OPTIONS $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_VHDL_COMPILE_OPTIONS "$QSYS_SIMDIR"]]
  foreach file $design_files {
    eval $file
  }
}

# ----------------------------------------
# Elaborate the top level design with -voptargs=+acc option
alias elab_debug {
  if [string is false -strict $SILENCE] {
    echo "\[exec\] elab_debug"
  }
  set elabcommand ""
  foreach library $logical_libraries { append elabcommand " -L $library" }
  append elabcommand " $TOP_LEVEL_VERIF_NAME "
  eval vsim -voptargs=+acc $elabcommand
}

# ----------------------------------------

# Call command to compile the Quartus-generated IP simulation files.
# com

# vlog <compilation options> <design and testbench files>
#vlog "$QSYS_SIMDIR/qsys_top.v"  // TODO issue#123