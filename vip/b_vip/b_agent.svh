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
// Filename           : b_agent.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B agent class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
// Agent top
//
// -----------------------------------------------------------------------------
`ifndef B_AGENT_SVH
`define B_AGENT_SVH

//------------------------------------------------------------------------------
// CLASS: b_agent
//------------------------------------------------------------------------------
// The top-level agent component. It instantiates and connects the driver,
// monitor, and sequencer.
//------------------------------------------------------------------------------
class b_agent extends uvm_agent;
  `uvm_component_utils(b_agent)

  // The analysis port through which the monitor broadcasts transactions.
  uvm_analysis_port #(b_seq_item) aport;

  // Agent's configuration object.
  b_agent_config m_config;

  // Agent sub-components
  b_sequencer m_sequencer;
  b_driver m_driver;
  b_monitor m_monitor;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Get configuration object from the UVM config database.
    if (m_config == null) begin
      if (!uvm_config_db#(b_agent_config)::get(this, "", "m_config", m_config)) begin
        `uvm_fatal(this.get_full_name(), "No agent config specified!")
      end
    end

    // The virtual interface is retrieved from the config DB inside the driver/monitor.
    // No need to set it here.

    // Create driver and sequencer only if the agent is ACTIVE.
    if (m_config.active == UVM_ACTIVE) begin
      m_sequencer = b_sequencer::type_id::create("m_sequencer", this);
      m_driver = b_driver::type_id::create("m_driver", this);
      m_driver.m_config = m_config;
    end

    // The monitor is always created.
    m_monitor = b_monitor::type_id::create("m_monitor", this);
    m_monitor.m_config = m_config;

    // Create the analysis port.
    aport = new("aport", this);
  endfunction : build_phase

  // Connect Phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Pass the configuration object to the sub-components.
    if (m_config.active == UVM_ACTIVE) begin
      // Connect the driver's sequence port to the sequencer.
      m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end

    // Connect the monitor's analysis port to the agent's analysis port.
    m_monitor.aport.connect(this.aport);
  endfunction

endclass : b_agent

`endif