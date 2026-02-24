## Detailed Description:
## Start simulation and coordinate files
##
## -----------------------------------------------------------------------------
alias rfc "restart;clear"

# Function to generate a unique name for the transcript file with the current date in format YYYYY_MM_DD
proc get_unique_transcript_name {base_name seed} {
# Get the current date in YYYYY_MM_DD format
  set current_date [clock format [clock seconds] -format "%Y%m%d"]

  set i 1
  set file_name "${base_name}_${current_date}_${seed}.log"
  while {[file exists $file_name]} {
    incr i
    set file_name "${base_name}_seed_${seed}_${current_date}_${i}.log"
  }
  return $file_name
}

# Verificar si la carpeta logs existe, si no, crearla
if {![file isdirectory "logs"]} {
  file mkdir logs
}

# Verificar si la carpeta libraries existe, si no, crearla
if {![file isdirectory "libraries"]} {
  file mkdir libraries
}

# Clear old logs, excep preview. To comment if no need
foreach old_log [glob -nocomplain logs/*.log] {
  catch {file delete $old_log}
}

# Test names list
puts ""
puts [string repeat "-" 72]
puts "Available tests:"
set test_names {
  sanity_test
  reset_test
}

# If no test name is entered print test names and exit.
if {($argc < 1) || ($1 ni $test_names)} {
  puts "Usage: do sim.do \[test_name\]"
  puts "Please select one of the available tests."
  return
}

set uvm_testname $1
set sv_seed random

if {$argc > 1} {
  set sv_seed $2
}

# Define base_name transcript
set base_transcript_file "logs/${uvm_testname}"

#gen unic name transcript
set transcript_file [get_unique_transcript_name $base_transcript_file $sv_seed]

# Logic to see if test is post_synth
set post_synth "no_post_synth"

set search_str "post_synth"
# Check if the substring exists
set post_synth_test [string first $search_str $uvm_testname]

if {$post_synth_test != -1} {
  set post_synth "post_synth"
}

# open transcript
transcript file $transcript_file

# Quit previous simulation
quit -sim

# Compile
do prepare.do $uvm_testname $post_synth
do compile.do $uvm_testname
do run.do $uvm_testname $sv_seed

# Simulation time
simstats

# Delete waste from previous sims
foreach file [glob -nocomplain ./wlft*] {
  set objectFile [file tail [file rootname $file]]
  catch {file delete $objectFile}
}