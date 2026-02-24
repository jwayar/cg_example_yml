//
// Detailed Description:
// Scoreboard (SCDB) package.
// This package includes the predictor and scoreboard components.
//
// -----------------------------------------------------------------------------
package project_scbd_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import utils_pkg::*;
  import project_defn_pkg::*;

  import a_agent_pkg::*;
  import b_agent_pkg::*;

  // This loop now iterates over all agent instances to create unique macros.
  `uvm_analysis_imp_decl(_A_ACT_SEQ_ITEM)
  `uvm_analysis_imp_decl(_A_PAS_SEQ_ITEM)
  `uvm_analysis_imp_decl(_B_ACT_SEQ_ITEM)
  `uvm_analysis_imp_decl(_B_PAS_SEQ_ITEM)

  `include "project_predictor.sv"
  `include "project_scbd.sv"

endpackage : project_scbd_pkg