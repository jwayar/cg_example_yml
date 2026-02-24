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
// Filename           : a_agent.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A agent class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
// Agent top
//
// -----------------------------------------------------------------------------
`ifndef A_AGENT_SVH
`define A_AGENT_SVH

class a_agent extends uvm_agent;
  `uvm_component_utils(a_agent)

  uvm_analysis_port #(a_seq_item) aport;

  a_agent_config m_config;
  a_sequencer m_sequencer;
  a_driver m_driver;
  a_monitor m_monitor;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (m_config == null) begin
      if (!uvm_config_db#(a_agent_config)::get(this, "", "m_config", m_config)) begin
        `uvm_fatal(this.get_full_name, "No a_agent config specified!")
      end
    end

    m_config.set_interface(this);

    if (m_config.active == UVM_ACTIVE) begin
      m_sequencer = a_sequencer::type_id::create("m_sequencer", this);
      m_driver = a_driver::type_id::create("m_driver", this);
      m_driver.m_config = m_config;
    end

    m_monitor = a_monitor::type_id::create("m_monitor", this);
    m_monitor.m_config = m_config;

    aport = new("aport", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (m_config.active == UVM_ACTIVE) begin
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end

    m_monitor.aport.connect(aport);
  endfunction

endclass : a_agent

`endif