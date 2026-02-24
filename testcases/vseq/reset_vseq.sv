//------------------------------------------------------------------------------
// Class: reset_vseq
//------------------------------------------------------------------------------
// This virtual sequence sends a synchronized reset transaction to all active agents.
//------------------------------------------------------------------------------
class reset_vseq extends project_vseq_base;
  // UVM Factory Registration Macro
  `uvm_object_utils(reset_vseq)

  // This variable controls the reset value for all agents.
  rand bit m_reset = 1'b0;

  // Constructor
  function new(string name = "reset_vseq");
    super.new(name);
  endfunction : new

  // Main body of the sequence
  virtual task body();

    // Declare sequence items only for ACTIVE agents.
    a_seq_item m_a_act_item;
    b_seq_item m_b_act_item;

    super.body();

    // Fork a separate process to send a transaction to each ACTIVE agent.
    fork
      begin : send_reset_to_m_a_act
        m_a_act_item = a_seq_item::type_id::create("m_a_act_item");
        start_item(m_a_act_item, .sequencer(m_a_act_sqr));

        // Randomize the item, constraining its 'rst' field with this sequence's 'm_reset'
        if (!m_a_act_item.randomize() with {rst == m_reset;}) begin
          `uvm_error(get_name(), $sformatf("Failed to randomize reset item for agent %s!", "m_a_act"))
        end

        finish_item(m_a_act_item);
      end
      begin : send_reset_to_m_b_act
        m_b_act_item = b_seq_item::type_id::create("m_b_act_item");
        start_item(m_b_act_item, .sequencer(m_b_act_sqr));

        // Randomize the item, constraining its 'rst' field with this sequence's 'm_reset'
        if (!m_b_act_item.randomize() with {rst == m_reset;}) begin
          `uvm_error(get_name(), $sformatf("Failed to randomize reset item for agent %s!", "m_b_act"))
        end

        finish_item(m_b_act_item);
      end
    join

  endtask : body

endclass : reset_vseq