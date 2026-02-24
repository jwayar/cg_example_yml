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
// Filename           : b_if.sv
// Date Last Modified : 2025 AUG 13
// Date Created       : 2025 AUG 13
// Device             : Generic
// Design Name        : Generic
// Purpose            : B interface
// Author(s)          : Joel Wayar
// Email              : jwayar@emtech.com.ar
//
// :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// Agent description: Agente simple
//
// Detailed Description:
// Agent interface
//
// -----------------------------------------------------------------------------
`ifndef B_IF_SV
`define B_IF_SV

//------------------------------------------------------------------------------
// INTERFACE: b_if
//------------------------------------------------------------------------------
// The physical interface for the B protocol.
// It declares all the signals, clocking blocks, and modports.
//------------------------------------------------------------------------------
interface b_if (
  input logic clk,
  input logic rst_n
);

  import b_agent_pkg::*;
  // TODO: Declare all the signals that connect to the DUT.
  // Example:
  // logic        valid;

  // --- Clocking Blocks ---
  // A clocking block for the driver to drive signals.
  // clocking driver_cb @(posedge clk);
  //   default input #1step output #1ns;
  //   output valid;
  // endclocking : driver_cb

  // A clocking block for the monitor to sample signals.
  // clocking monitor_cb @(posedge clk);
  //   default input #1step output #1ns;
  //   input valid;
  // endclocking : monitor_cb

endinterface : b_if

`endif