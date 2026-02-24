// Detailed Description:
// Define pkg -order of defines- tbtop - test defs - scbd defs - others defs
//
// -----------------------------------------------------------------------------
package project_defn_pkg;

  // TODO: TB Top definitions.
  localparam int RESET_CLOCK_COUNT = 10;
  localparam int CLK_FREQ_HZ = 125e6;
  localparam time CLK_PERIOD = 1s / CLK_FREQ_HZ;

  // TODO: agent definitions.
  localparam time TIME_RESET = RESET_CLOCK_COUNT*CLK_PERIOD;

  // TODO: test definitions.

  // reset test (in periods of clock)
  localparam int RESET_REPEAT = 5;
  localparam int RESET_TIME_MIN = 10;
  localparam int RESET_TIME_MAX = 1100;
  localparam int RESET_SPACE = 100;

  // TODO: scbd definitions.

endpackage : project_defn_pkg