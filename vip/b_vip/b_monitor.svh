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
// Filename           : b_monitor.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B monitor class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
// Agent monitor
//
// -----------------------------------------------------------------------------
`ifndef B_MONITOR_SVH
`define B_MONITOR_SVH

//------------------------------------------------------------------------------
// CLASS: b_monitor
//------------------------------------------------------------------------------
// This monitor observes the physical interface signals, captures transactions,
// and broadcasts them through its analysis port.
//------------------------------------------------------------------------------
class b_monitor extends uvm_monitor;
  `uvm_component_utils(b_monitor)

  // Handle to the agent's configuration object
  b_agent_config m_config;

  // Handle to the virtual interface
  virtual b_if m_vif;

  // The analysis port used to broadcast captured transactions
  uvm_analysis_port #(b_seq_item) aport;

  // --- Constructor ---
  function new(string name = "b_monitor", uvm_component parent = null);
    super.new(name, parent);
    aport = new("aport", this);
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
  // Observe the interface and capture transactions.
  task run_phase(uvm_phase phase);
    // TODO: Add any initial reset or interface setup logic here.
    // Example:
    // @(posedge m_vif.rst_n);

    forever begin
      b_seq_item item;
      item = b_seq_item::type_id::create("item", this);

      @(posedge m_vif.clk);

      // TODO: Implement the logic to monitor the interface signals.

      // Example:
      // wait (m_vif.valid == 1);
      // item.data = m_vif.data;
      // item.addr = m_vif.addr;

      `uvm_info(this.get_full_name, item.convert2string(), UVM_HIGH)
      aport.write(item);
    end
  endtask : run_phase

endclass : b_monitor

`endif