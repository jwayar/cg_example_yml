//------------------------------------------------------------------------------
// Class: project_vseq_base
//------------------------------------------------------------------------------
// This is the base class for all virtual sequences in the environment.
// It provides handles to all agent sequencers.
//------------------------------------------------------------------------------
class project_vseq_base extends uvm_sequence #(uvm_sequence_item);
  // UVM Factory Registration Macro
  `uvm_object_utils(project_vseq_base)

  // Macro to get a typed handle 'p_sequencer' to the virtual sequencer
  `uvm_declare_p_sequencer(project_vseqr)

  // --- Sequencer Handles ---
  // A handle for each ACTIVE agent's sequencer
  a_sequencer m_a_act_sqr;
  b_sequencer m_b_act_sqr;

  // TODO: Add handle for register block if using UVM RAL
  // my_reg_block ral_model;

  // Constructor
  function new(string name = "project_vseq_base");
    super.new(name);
  endfunction : new

  // Main body of the sequence
  virtual task body();

    // Get the active agent sequencer handles from the virtual sequencer.
    if (p_sequencer.m_a_act_seqr == null)
      `uvm_fatal("VSEQ_BASE", $sformatf("Sequencer handle for active agent '%s' is null.", "m_a_act"))
    m_a_act_sqr = p_sequencer.m_a_act_seqr;
    if (p_sequencer.m_b_act_seqr == null)
      `uvm_fatal("VSEQ_BASE", $sformatf("Sequencer handle for active agent '%s' is null.", "m_b_act"))
    m_b_act_sqr = p_sequencer.m_b_act_seqr;
  endtask : body

endclass : project_vseq_base