
## Detailed Description:
## Run design and enviroment
##
## -----------------------------------------------------------------------------
if {$argc < 2} {
    error "not enough arguments"
}
#lappend auto_path $tcl_pkgs_path

set uvm_testname $1
set sv_seed $2

# Check os
set os [string tolower $::tcl_platform(os)]
cd $working_dir
vsim +UVM_TESTNAME=$uvm_testname +OS=$os\
    -sv_seed $sv_seed \
    -t 1ps \
    -warning 3009 \
    -voptargs=+acc \
    project_tb_top

#    -coverage \

# load wave
do wave.do

# run test
run -all