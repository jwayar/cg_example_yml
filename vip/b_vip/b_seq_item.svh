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
// Filename           : b_seq_item.svh
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B sequence item class
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
// Agent sequence item or transaction
//
// -----------------------------------------------------------------------------
`ifndef B_SEQ_ITEM_SVH
`define B_SEQ_ITEM_SVH

class b_seq_item extends uvm_sequence_item;
  `uvm_object_utils(b_seq_item);
  // TODO: all variables and constraint del b_seq_item
  // ie:
  // rand int        delay_cycles;
  // rand max_data_t data;
  rand bit rst;

  // constraint delay_cycles_range {
  //   delay_cycles dist {
  //     0       := 90,
  //     [1 : 4] :/ 10
  //   };
  // }
  function new(string name = "b_seq_item");
    super.new(name);
  endfunction : new

  function void post_randomize();

  endfunction : post_randomize

  function void do_copy(uvm_object rhs);
    b_seq_item rhs_;

    if (!$cast(rhs_, rhs)) begin
      `uvm_error({this.get_name(), ".do_copy()"}, "Cast failed!");
      return;
    end

    /*  chain the copy with parent classes  */
    super.do_copy(rhs);

    // TODO: copy of variables
    // example
    /*  list of local properties to be copied  */
    //this.data = rhs_.data;
  endfunction : do_copy

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    b_seq_item rhs_;
    bit do_comp;

    if (!$cast(rhs_, rhs)) begin
      `uvm_error({this.get_name(), ".do_compare()"}, "Cast failed!");
      return 0;
    end

    /*  chain the compare with parent classes  */
    do_comp = super.do_compare(rhs, comparer);

    // TODO: comparation of variables
    // example
    //do_compare &= comparer.compare_field("data", this.data, rhs_.data, MAX_DATA_WIDTH);

    return do_comp;
  endfunction : do_compare

  function string convert2string();
    string s;

    /*  chain the convert2string with parent classes  */
    s = super.convert2string();

    // TODO: convert to string
    //example
    //s = {s, $sformatf("Payload data: 0x%0h", data)};

    return s;
  endfunction : convert2string

endclass : b_seq_item

`endif