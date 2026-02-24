// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//                    ______          __            __                         :
//                   / ____/___ ___  / /____  _____/ /_                        :
//                  / __/ / __ `__ \/ __/ _ \/ ___/ __ \                       :
//                 / /___/ / / / / / /_/  __/ /__/ / / /                       :
//                /_____/_/ /_/ /_/\__/\___/\___/_/ /_/                        :
//                                                                             :
// This file contains confidential and proprietary information of Emtech SA.   :
// Any unauthorized copying, alteration, distribution, transmission,           :
// performance, display or other use of this material is prohibited.           :
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//
// Client             : emtech
// Version            : 1.0
// Application        : Generic
// Filename           : b_driver.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B driver class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
// Agent driver
//
// -----------------------------------------------------------------------------
`ifndef B_DRIVER_SVH
`define B_DRIVER_SVH

//------------------------------------------------------------------------------
// CLASS: b_driver
//------------------------------------------------------------------------------
// This driver gets transactions from the sequencer and drives them on the
// physical interface.
//------------------------------------------------------------------------------
class b_driver extends uvm_driver #(b_seq_item);
  `uvm_component_utils(b_driver)

  // Handle to the agent's configuration object
  b_agent_config m_config;

  // Handle to the virtual interface
  virtual b_if m_vif;

  // --- Constructor ---
  function new(string name = "b_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  // --- Build Phase ---
  // Get the virtual interface handle from the UVM config database.
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase

  // --- Connect Phase ---
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    m_vif = m_config.vif;
  endfunction : connect_phase

  // --- Run Phase ---
  // Get items from the sequencer and drive them on the interface.
  task run_phase(uvm_phase phase);
    // TODO: Add any initial reset or interface setup logic here.
    // Example:
    // m_vif.my_signal <= 0;
    // @(posedge m_vif.rst_n);

    forever begin
      b_seq_item item;
      seq_item_port.get_next_item(item);

      @(posedge m_vif.clk);

      // TODO: Implement the logic to drive the interface signals based on the
      //       'item' received from the sequencer.
      // Example:
      // m_vif.valid <= 1;
      // m_vif.data  <= item.data;
      // m_vif.addr  <= item.addr;
      // m_vif.valid <= 0;

      `uvm_info(this.get_full_name, item.convert2string(), UVM_HIGH);

      seq_item_port.item_done();
    end
  endtask : run_phase

endclass : b_driver

`endif