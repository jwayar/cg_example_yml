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
// Filename           : b_agent_config.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B agent config
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
// Agent configuration
//
// -----------------------------------------------------------------------------
`ifndef B_AGENT_CONFIG_SVH
`define B_AGENT_CONFIG_SVH

class b_agent_config extends uvm_object;
  `uvm_object_utils(b_agent_config)

  // This handle holds the virtual interface for the agent.
  // It is set by the testbench top.
  virtual b_if vif;

  // Variable to store the agent's activation status (ACTIVE or PASSIVE).
  uvm_active_passive_enum active = UVM_ACTIVE;

  // TODO: Add agent-specific configuration variables here.
  // Example:
  // int data_width = 8;

  function new(string name = "");
    super.new(name);
  endfunction

endclass : b_agent_config

`endif