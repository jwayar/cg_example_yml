//
// Detailed Description:
// Rudimentary functional coverage package.
//
// -----------------------------------------------------------------------------
package project_coverage_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import a_agent_pkg::*;
  import b_agent_pkg::*;

  //------------------------------------------------------------------------------
  // Class: project_coverage
  //------------------------------------------------------------------------------
  // This component subscribes to agent monitors and collects functional coverage.
  //------------------------------------------------------------------------------
  class project_coverage extends uvm_component;
    // UVM Factory Registration Macro
    `uvm_component_utils(project_coverage)

    // --- Analysis FIFOs and Item Handles for each instance ---
    // Fifo of the sequence item
    uvm_tlm_analysis_fifo #(a_seq_item) a_act_fifo;
    uvm_tlm_analysis_fifo #(a_seq_item) a_pas_fifo;
    uvm_tlm_analysis_fifo #(b_seq_item) b_act_fifo;
    uvm_tlm_analysis_fifo #(b_seq_item) b_pas_fifo;

    // Handlers
    a_seq_item a_act_seq_item_recv;
    a_seq_item a_pas_seq_item_recv;
    b_seq_item b_act_seq_item_recv;
    b_seq_item b_pas_seq_item_recv;

    // --- Covergroups for each instance ---
    covergroup a_act_covergroup;
      // TODO: Define coverpoints for a_seq_item
      // Example:
      // my_coverpoint: coverpoint a_act_seq_item_recv.my_signal {
      //   bins my_bins[] = {0, 1, 2};
      // }
    endgroup
    covergroup a_pas_covergroup;
      // TODO: Define coverpoints for a_seq_item
      // Example:
      // my_coverpoint: coverpoint a_pas_seq_item_recv.my_signal {
      //   bins my_bins[] = {0, 1, 2};
      // }
    endgroup
    covergroup b_act_covergroup;
      // TODO: Define coverpoints for b_seq_item
      // Example:
      // my_coverpoint: coverpoint b_act_seq_item_recv.my_signal {
      //   bins my_bins[] = {0, 1, 2};
      // }
    endgroup
    covergroup b_pas_covergroup;
      // TODO: Define coverpoints for b_seq_item
      // Example:
      // my_coverpoint: coverpoint b_pas_seq_item_recv.my_signal {
      //   bins my_bins[] = {0, 1, 2};
      // }
    endgroup

    // --- Component Constructor ---
    function new(string name = "project_coverage", uvm_component parent);
      super.new(name, parent);

      // Instantiate the covergroups for each instance
      a_act_covergroup = new();
      a_pas_covergroup = new();
      b_act_covergroup = new();
      b_pas_covergroup = new();
    endfunction

    // --- Build Phase ---
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Instantiate the analysis FIFOs for each instance
      a_act_fifo = new("a_act_fifo", this);
      a_pas_fifo = new("a_pas_fifo", this);
      b_act_fifo = new("b_act_fifo", this);
      b_pas_fifo = new("b_pas_fifo", this);
    endfunction : build_phase

    // --- Run Phase ---
    task run_phase(uvm_phase phase);
      fork
        // Fork a separate process for each instance's coverage collection
        begin: collect_a_act_coverage
          forever begin
            a_act_fifo.get(a_act_seq_item_recv);
            `uvm_info(get_name(), $sformatf("Sampling coverage for a_act transaction."), UVM_HIGH)
            a_act_covergroup.sample();
          end
        end
        begin: collect_a_pas_coverage
          forever begin
            a_pas_fifo.get(a_pas_seq_item_recv);
            `uvm_info(get_name(), $sformatf("Sampling coverage for a_pas transaction."), UVM_HIGH)
            a_pas_covergroup.sample();
          end
        end
        begin: collect_b_act_coverage
          forever begin
            b_act_fifo.get(b_act_seq_item_recv);
            `uvm_info(get_name(), $sformatf("Sampling coverage for b_act transaction."), UVM_HIGH)
            b_act_covergroup.sample();
          end
        end
        begin: collect_b_pas_coverage
          forever begin
            b_pas_fifo.get(b_pas_seq_item_recv);
            `uvm_info(get_name(), $sformatf("Sampling coverage for b_pas transaction."), UVM_HIGH)
            b_pas_covergroup.sample();
          end
        end
      join
    endtask : run_phase

  endclass : project_coverage

endpackage : project_coverage_pkg