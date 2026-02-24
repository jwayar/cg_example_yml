//
// Detailed Description:
// Top level of the testbench environment. This is where the DUT is instantiated.
//
// -----------------------------------------------------------------------------
module project_tb_top;

  // Imports.
  import uvm_pkg::*;
  import project_defn_pkg::*;
  import project_test_pkg::*;

  `include "uvm_macros.svh"

  // Clock and reset signals.
  logic clk;
  logic rst_n;

  // Clock and reset initial block.
  initial begin
    // Initialize clock to 0 and reset_n to TRUE.
    clk   = 0;
    rst_n = 0;

    // Wait for reset completion (RESET_CLOCK_COUNT is defined in defn_pkg).
    repeat (RESET_CLOCK_COUNT) begin
      #(CLK_PERIOD / 2) clk = 0;
      #(CLK_PERIOD - CLK_PERIOD / 2) clk = 1;
    end

    rst_n = 1;
    forever begin
      #(CLK_PERIOD / 2) clk = 0;
      #(CLK_PERIOD - CLK_PERIOD / 2) clk = 1;
    end
  end

  //TODO: Instantiate DUT here
  //project_top DUT (
  //    .sys_clk_i   (clk),
  //    .sys_rst_ni  (rst_n),
  //    ...
  //);

  // --- Agent Interfaces ---
  a_if #(
    //TODO: Add interface parameters here if needed
    //.DATA_WIDTH(32)
  ) a_act_inst (
    .clk(clk),
    .rst_n(rst_n)
  );
  a_if #(
    //TODO: Add interface parameters here if needed
    //.DATA_WIDTH(32)
  ) a_pas_inst (
    .clk(clk),
    .rst_n(rst_n)
  );
  b_if #(
    //TODO: Add interface parameters here if needed
    //.DATA_WIDTH(32)
  ) b_act_inst (
    .clk(clk),
    .rst_n(rst_n)
  );
  b_if #(
    //TODO: Add interface parameters here if needed
    //.DATA_WIDTH(32)
  ) b_pas_inst (
    .clk(clk),
    .rst_n(rst_n)
  );

  initial begin
    // Set default UVM verbosity.
    uvm_top.set_report_verbosity_level(UVM_LOW);

    // Set time format for simulation logs.
    $timeformat(-12, 1, " ps", 1);

    // Configure other simulation options.
    uvm_top.enable_print_topology = 1;
    uvm_top.finish_on_completion  = 0;

    // Set time format for simulation logs.
    $timeformat(-12, 1, " ps", 1);

    // --- Interface Registration ---
    // The method of registration depends on the agent's architecture.
    a_act_inst.register_interface("a_act_if");
    a_pas_inst.register_interface("a_pas_if");
    uvm_config_db#(virtual b_if)::set(null, "*", "b_act_vif", b_act_inst);
    uvm_config_db#(virtual b_if)::set(null, "*", "b_pas_vif", b_pas_inst);

    // Start the UVM test.
    run_test();

    $stop();
  end

endmodule : project_tb_top