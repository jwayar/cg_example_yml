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
// Filename           : a_abstract_class.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A abstract class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
// Agent abstract class
//
// -----------------------------------------------------------------------------
`ifndef A_ABSTRACT_CLASS_SVH
`define A_ABSTRACT_CLASS_SVH

class a_abstract_class extends uvm_component;
  `uvm_component_utils(a_abstract_class);

  function new(string name = "a_abstract_class", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  virtual function int get_data_width();
    `uvm_fatal(get_type_name(), "get_data_width not implemented");
    return 0;
  endfunction

  virtual task wait_reset();
    `uvm_fatal(get_type_name(), "wait_reset not implemented");
  endtask

  virtual task wait_clocks(int cycles);
    `uvm_fatal(get_type_name(), "wait_cycles not implemented");
  endtask

  virtual task do_drive(a_seq_item item);
    `uvm_fatal(get_name(), "do_drive not implemented");
  endtask

  virtual task do_monitor(a_seq_item item);
    `uvm_fatal(get_type_name(), "do_monitor not implemented")
  endtask

endclass : a_abstract_class

`endif