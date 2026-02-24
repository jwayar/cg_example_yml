//------------------------------------------------------------------------------
// Class: sanity_vseq
//------------------------------------------------------------------------------
// A basic sanity virtual sequence that sends a single random transaction
// to each agent in the environment.
//------------------------------------------------------------------------------
class sanity_vseq extends project_vseq_base;
  // UVM Factory Registration Macro
  `uvm_object_utils(sanity_vseq)

  // Constructor
  function new(string name = "sanity_vseq");
    super.new(name);
  endfunction : new

  // Main body of the sequence
  virtual task body();
    // Declare all sequence items at the beginning of the task.
    a_seq_item m_a_act_item;
    b_seq_item m_b_act_item;

    super.body();

    // Fork a separate process to send a transaction to each agent in parallel.
    fork
      begin : send_sanity_to_m_a_act
        m_a_act_item = a_seq_item::type_id::create("m_a_act_item");
        start_item(m_a_act_item, .sequencer(m_a_act_sqr));

        if (!m_a_act_item.randomize()) begin
          `uvm_error(get_name(), $sformatf("Failed to randomize sanity item for agent %s!", "m_a_act"))
        end

        finish_item(m_a_act_item);
      end
      begin : send_sanity_to_m_b_act
        m_b_act_item = b_seq_item::type_id::create("m_b_act_item");
        start_item(m_b_act_item, .sequencer(m_b_act_sqr));

        if (!m_b_act_item.randomize()) begin
          `uvm_error(get_name(), $sformatf("Failed to randomize sanity item for agent %s!", "m_b_act"))
        end

        finish_item(m_b_act_item);
      end
    join

  endtask : body
endclass : sanity_vseq