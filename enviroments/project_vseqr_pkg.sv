//
// Detailed Description:
// Top-level virtual sequencer (vseqr) package.
//
// -----------------------------------------------------------------------------
package project_vseqr_pkg;

  // Package imports.
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import project_defn_pkg::*;

  // Agent package imports.
  import a_agent_pkg::*;
  import b_agent_pkg::*;

  //------------------------------------------------------------------------------
  // Class: project_vseqr
  //------------------------------------------------------------------------------
  // This virtual sequencer contains handles to all the agent sequencers in the
  // environment. Virtual sequences run on this sequencer to coordinate activity
  // across multiple agents.
  //------------------------------------------------------------------------------
  class project_vseqr extends uvm_sequencer;
    `uvm_component_utils(project_vseqr)

    // --- Agent Sequencer Handles ---
    // A handle for each agent's sequencer. These are connected by the environment.
    a_sequencer m_a_act_seqr;
    b_sequencer m_b_act_seqr;

    // --- Constructor ---
    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);

      if (!uvm_config_db#(a_sequencer)::get(this, "", "m_a_act_seqr", m_a_act_seqr))
        `uvm_fatal("VSQR/CFG/NOAHB", "No a_sequencer specified for this instance");
      if (!uvm_config_db#(b_sequencer)::get(this, "", "m_b_act_seqr", m_b_act_seqr))
        `uvm_fatal("VSQR/CFG/NOAHB", "No b_sequencer specified for this instance");

    endfunction

  endclass : project_vseqr

endpackage : project_vseqr_pkg