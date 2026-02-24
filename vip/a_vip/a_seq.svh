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
// Filename           : a_seq.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A sequence classes
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
//Agent sequence
//
// -----------------------------------------------------------------------------
`ifndef A_SEQ_SVH
`define A_SEQ_SVH

class a_seq_base extends uvm_sequence #(a_seq_item);
  `uvm_object_utils(a_seq_base);
  `uvm_declare_p_sequencer(a_sequencer);

  function new(string name = "a_seq_base");
    super.new(name);
  endfunction : new

  task body();

  endtask
endclass : a_seq_base

class a_seq_random extends a_seq_base;
  `uvm_object_utils(a_seq_random);

  function new(string name = "a_seq_random");
    super.new(name);
  endfunction

  task body;
    a_seq_item item;

    item = a_seq_item::type_id::create("item");
    start_item(item);

    if (!item.randomize()) begin
      `uvm_error("ARND", "Failed to randomize seq!");
    end

    finish_item(item);
  endtask

endclass : a_seq_random

`endif