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
// Filename           : b_seq.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B sequence classes
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
//Agent sequence
//
// -----------------------------------------------------------------------------
`ifndef B_SEQ_SVH
`define B_SEQ_SVH

//------------------------------------------------------------------------------
// CLASS: b_seq_base
//------------------------------------------------------------------------------
// This is the base class for all sequences that run on the B agent.
//------------------------------------------------------------------------------
class b_seq_base extends uvm_sequence #(b_seq_item);
  `uvm_object_utils(b_seq_base)

  // Macro to get a typed handle 'p_sequencer' to the agent's sequencer
  `uvm_declare_p_sequencer(b_sequencer)

  function new(string name = "b_seq_base");
    super.new(name);
  endfunction : new

  virtual task body();
    // This task is a placeholder and should be overridden by extended sequences.
  endtask
endclass : b_seq_base

//------------------------------------------------------------------------------
// CLASS: b_seq_random
//------------------------------------------------------------------------------
// An example sequence that sends a single, randomized transaction.
//------------------------------------------------------------------------------
class b_seq_random extends b_seq_base;
  `uvm_object_utils(b_seq_random)

  function new(string name = "b_seq_random");
    super.new(name);
  endfunction

  virtual task body();
    b_seq_item item;

    //TODOjw -> UVM macros to create, send, and randomize the item
    `uvm_do(item)

    //TODOjw The `uvm_do macro is equivalent to:
    // item = b_seq_item::type_id::create("item");
    // start_item(item);
    // if (!item.randomize()) begin
    //   `uvm_error("RND_FAIL", "Failed to randomize sequence item!")
    // end
    // finish_item(item);
  endtask

endclass : b_seq_random

`endif