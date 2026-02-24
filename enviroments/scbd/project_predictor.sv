//
// Detailed Description:
// Predictor class for the project environment.
// This predictor receives sequence items from agents and predicts expected outputs.
// It communicates with the scoreboard and comparator components.
//
// -----------------------------------------------------------------------------
class project_predictor extends uvm_component;
  `uvm_component_utils(project_predictor)
  //Analysis export to receive seq items from monitors
  //uvm_analysis_imp_CLOCK_SEQ_ITEM #(clock_seq_item, project_predictor) clock_analysis_export;

  uvm_analysis_imp_A_ACT_SEQ_ITEM #(a_seq_item, project_predictor) a_act_analysis_export;
  uvm_analysis_port #(a_seq_item) predicted_a_act_aport;
  uvm_analysis_imp_A_PAS_SEQ_ITEM #(a_seq_item, project_predictor) a_pas_analysis_export;
  uvm_analysis_port #(a_seq_item) predicted_a_pas_aport;
  uvm_analysis_imp_B_ACT_SEQ_ITEM #(b_seq_item, project_predictor) b_act_analysis_export;
  uvm_analysis_port #(b_seq_item) predicted_b_act_aport;
  uvm_analysis_imp_B_PAS_SEQ_ITEM #(b_seq_item, project_predictor) b_pas_analysis_export;
  uvm_analysis_port #(b_seq_item) predicted_b_pas_aport;

  a_seq_item pred_a_act_seq_item;
  a_seq_item pred_a_pas_seq_item;
  b_seq_item pred_b_act_seq_item;
  b_seq_item pred_b_pas_seq_item;

  bit reset_a_act = 1'b0;
  bit reset_a_pas = 1'b0;
  bit reset_b_act = 1'b0;
  bit reset_b_pas = 1'b0;

  // --- Global/Utility Variables ---
  logic stop_clock = 1'b0;
  bit reset_scbd_1 = 1'b0;
  string test_name = "";

  // --- Constructor ---
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

  // --- Build Phase ---
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Create analysis exports/ports for each INSTANCE.
    a_act_analysis_export = new("a_act_analysis_export", this);
    predicted_a_act_aport = new("predicted_a_act_aport", this);
    a_pas_analysis_export = new("a_pas_analysis_export", this);
    predicted_a_pas_aport = new("predicted_a_pas_aport", this);
    b_act_analysis_export = new("b_act_analysis_export", this);
    predicted_b_act_aport = new("predicted_b_act_aport", this);
    b_pas_analysis_export = new("b_pas_analysis_export", this);
    predicted_b_pas_aport = new("predicted_b_pas_aport", this);
  endfunction: build_phase

  // --- Connect Phase ---
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  //function void write_CLOCK_SEQ_ITEM(clock_seq_item t);
  //  stop_clock = (t.stop_clock) ? 1'b1 : 1'b0;
  //endfunction : write_CLOCK_SEQ_ITEM

  function void write_A_ACT_SEQ_ITEM(a_seq_item t);
    //set to capture write
    reset_a_act = t.rst;
    // TODO: Add prediction logic here based on transaction 't' for this specific instance.
  endfunction: write_A_ACT_SEQ_ITEM
  function void write_A_PAS_SEQ_ITEM(a_seq_item t);
    //set to capture write
    reset_a_pas = t.rst;
    // TODO: Add prediction logic here based on transaction 't' for this specific instance.
  endfunction: write_A_PAS_SEQ_ITEM
  function void write_B_ACT_SEQ_ITEM(b_seq_item t);
    //set to capture write
    reset_b_act = t.rst;
    // TODO: Add prediction logic here based on transaction 't' for this specific instance.
  endfunction: write_B_ACT_SEQ_ITEM
  function void write_B_PAS_SEQ_ITEM(b_seq_item t);
    //set to capture write
    reset_b_pas = t.rst;
    // TODO: Add prediction logic here based on transaction 't' for this specific instance.
  endfunction: write_B_PAS_SEQ_ITEM

  // --- Run Phase ---
  task run_phase(uvm_phase phase);
    forever begin
      fork : fork_clk_predicciones
        begin
          //@(posedge stop_clock) or reset;
          reset_scbd_1 = 1'b1;
        end
        begin
          //wait(stop_clock == 1'b0);
          void'($value$plusargs("UVM_TESTNAME=%0s", test_name));
          init_vars();
        end
      join_any
      disable fork_clk_predicciones;
    end
  endtask: run_phase

  function void init_vars();
    // utility variables
    reset_scbd_1 = 1'b0;
  endfunction: init_vars

endclass: project_predictor