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
// Filename           : a_driver.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A driver class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
// Agent driver
//
// -----------------------------------------------------------------------------
`ifndef A_DRIVER_SVH
`define A_DRIVER_SVH

class a_driver extends uvm_driver #(a_seq_item);
  `uvm_component_utils(a_driver);

  a_agent_config m_config;

  function new(string name = "a_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction : connect_phase

  task run_phase(uvm_phase phase);
    m_config.iface.wait_reset();
    m_config.iface.wait_clocks(1);

    forever begin
      a_seq_item item;

      seq_item_port.get_next_item(item);
      `uvm_info(this.get_full_name, item.convert2string(), UVM_HIGH);

      m_config.iface.do_drive(item);

      seq_item_port.item_done();
    end
  endtask : run_phase
endclass : a_driver

`endif