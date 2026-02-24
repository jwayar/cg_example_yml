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
// Filename           : a_monitor.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A monitor class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
// Agent monitor
//
// -----------------------------------------------------------------------------
`ifndef A_MONITOR_SVH
`define A_MONITOR_SVH

class a_monitor extends uvm_monitor;
  `uvm_component_utils(a_monitor);

  a_agent_config m_config;

  uvm_analysis_port #(a_seq_item) aport;

  function new(string name = "a_monitor", uvm_component parent = null);
    super.new(name, parent);
    aport = new("aport", this);
  endfunction : new

  function void build_phase(uvm_phase phase);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    m_config.iface.wait_reset();

    forever begin
      a_seq_item item;
      item = a_seq_item::type_id::create("item", this);
      m_config.iface.do_monitor(item);

      `uvm_info(this.get_full_name, item.convert2string(), UVM_HIGH)
      aport.write(item);
    end
  endtask : run_phase

endclass : a_monitor

`endif