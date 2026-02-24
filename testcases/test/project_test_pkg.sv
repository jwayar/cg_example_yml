//
// Detailed Description:
// Top-level test package for the project environment.
// This package imports all necessary dependencies and includes the test class files.
//
// -----------------------------------------------------------------------------
package project_test_pkg;

  // UVM and project-level package imports
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import project_defn_pkg::*;
  import project_env_pkg::*;
  import project_vseq_pkg::*;
  //TODO: import project_regs_pkg::*;

  // Agent package imports
  import a_agent_pkg::*;
  import b_agent_pkg::*;

  // Include the test class definitions
  `include "top_test_base.sv"
  `include "sanity_test.sv"
  `include "reset_test.sv"

endpackage : project_test_pkg