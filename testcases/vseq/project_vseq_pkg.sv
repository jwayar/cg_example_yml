//
// Detailed Description:
// Top-level virtual sequence package for the project environment.
// This package imports all necessary dependencies and includes the vseq class files.
//
// -----------------------------------------------------------------------------
package project_vseq_pkg;

  // Package imports.
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import project_defn_pkg::*;
  import project_vseqr_pkg::*;
  //TODO: import project_regs_pkg::*;

  // Agent package imports.
  import a_agent_pkg::*;
  import b_agent_pkg::*;

  // Include the virtual sequence class definitions.
  `include "top_base_vseq.sv"
  `include "sanity_vseq.sv"
  `include "reset_vseq.sv"

endpackage : project_vseq_pkg