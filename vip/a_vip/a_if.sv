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
// Filename           : a_if.sv
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : A interface
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente abstracto
//
// Detailed Description:
// Agent interface
//
// -----------------------------------------------------------------------------
`ifndef A_IF_SVH
`define A_IF_SVH

interface a_if #(
  //TODO: Possible parameters
  // int DATA_WIDTH = 32
) (
  input logic rst_n,
  input logic clk
);
  //TODO: Signals to DUT
  logic                      rst;
  // logic                      ready;
  // logic [DATA_WIDTH - 1 : 0] data;
  // logic                      valid = 1'b0;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import a_agent_pkg::*;

  class a_concrete_class #(
    //TODO: Possible parameters
    // parameter int DATA_WIDTH = 32
  ) extends a_abstract_class;
    `uvm_component_param_utils(a_concrete_class)//TODO: Possible parameters #(DATA_WIDTH));

    // Variables
    //max_data_t mask;

    function new(string name = "a_concrete_class", uvm_component parent = null);
      super.new(name, parent);
      //mask = (1 << DATA_WIDTH) - 1;
    endfunction : new

    //TODO: function to return the parameters
    // function int get_data_width();
    //   return DATA_WIDTH;
    // endfunction : get_data_width

    task wait_reset();
      @(posedge rst_n);
    endtask : wait_reset

    task wait_clocks(int cycles = 1);
      repeat (cycles) @(posedge clk);
    endtask : wait_clocks

    task do_drive(a_seq_item item);

      @(posedge clk);
      //TODO: drive

      // while (!(valid && ready)) begin
      //   @(posedge clk);
      // end
      rst = item.rst;
      // data  <= 'x;
      // valid <= 0;
    endtask : do_drive

    task do_monitor(a_seq_item item);
      @(posedge clk);

      //TODO: monitor

      // while (!(valid && ready)) begin
      //   @(posedge clk);
      // end
      // item.data = data & mask;
    endtask : do_monitor

  endclass : a_concrete_class

  function automatic void register_interface(string interface_name);
    string path_name;
    path_name = $sformatf("*.%s", interface_name);
    a_abstract_class::type_id::set_inst_override(a_concrete_class#()::get_type(), path_name, null);//TODO:#(DATA_WIDTH)::get_type(), path_name, null);
  endfunction

endinterface : a_if

`endif