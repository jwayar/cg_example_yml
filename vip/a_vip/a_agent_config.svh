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
// Filename           : a_agent_config.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A agent config
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
// Agent configuration
//
// -----------------------------------------------------------------------------
`ifndef A_AGENT_CONFIG_SVH
`define A_AGENT_CONFIG_SVH

class a_agent_config extends uvm_object;
  `uvm_object_utils(a_agent_config)

  string interface_name;
  uvm_active_passive_enum active = UVM_ACTIVE;

  a_abstract_class iface;

  function new(string name = "");
    super.new(name);
  endfunction

  function automatic void set_interface(uvm_component parent);
    iface = a_abstract_class::type_id::create(interface_name, parent);
  endfunction

endclass

`endif