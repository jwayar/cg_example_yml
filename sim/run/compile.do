##
## Detailed Description:
## Compile designs, agents, and environments
##
## -----------------------------------------------------------------------------

# --- Path Setup ---
# This script assumes it is being run from the 'verif/run' directory.
set this_path        [file normalize .]
set lib_path         [file normalize ../../]
set root_path        [file normalize ../../../]
set enviroment_path  [file normalize ../../enviroments]
set scbd_path        [file normalize ../../enviroments/scbd]
set test_path        [file normalize ../../testcases/test]
set vseq_path        [file normalize ../../testcases/vseq]
set utils_path       [file normalize ../../utils]

# These variables should be passed from the simulation script (e.g., run.do)
# set project_dut "${dut_dir}"
# set post_synth_path   "${post_synth_dut_dir}"

# --- Library Setup ---
# Clean up and create the work library
cd $this_path
catch {file delete -force ./libraries/work}
vlib ./libraries/work
vmap work ./libraries/work

# --- DUT Compilation ---
# TODO: This logic depends on arguments passed from a higher-level script.
# if {$2 == "post_synth"} {
#   vcom -2008 -work project_ps_lib \
#     "${POST_SYNTH_DUT_ARG}"
# } else {
#   vcom -cover bcs -work project_lib \
#     "${DUT_ARG}"
# }

# --- VIP Compilation ---
# Compile all agent VIPs required for this environment
puts "INFO: Compiling agent VIPs..."
source "$lib_path/vip/a_vip/compile.do"
source "$lib_path/vip/a_vip/compile.do"
source "$lib_path/vip/b_vip/compile.do"
source "$lib_path/vip/b_vip/compile.do"

# --- Environment Compilation ---
puts "INFO: Compiling UVM environment..."
vlog -sv \
    -timescale 1ns/1ps \
    +incdir+$enviroment_path \
    +incdir+$scbd_path \
    +incdir+$test_path \
    +incdir+$vseq_path \
    +incdir+$utils_path \
    $enviroment_path/project_defn_pkg.sv \
    $utils_path/utils_pkg.sv \
    $enviroment_path/project_vseqr_pkg.sv \
    $vseq_path/project_vseq_pkg.sv \
    $scbd_path/project_scbd_pkg.sv \
    $enviroment_path/project_coverage_pkg.sv \
    $enviroment_path/project_env_pkg.sv \
    $test_path/project_test_pkg.sv \
    $enviroment_path/project_tb_top.sv

puts "INFO: Compilation finished successfully."