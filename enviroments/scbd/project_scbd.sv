// //  possible subscriver
// class driver_subs extends uvm_subscriber #(driver_seq_item);
//   `uvm_component_utils(driver_subs)
//   uvm_analysis_port #(driver_seq_item) driver_0_export;
//   driver_seq_item driver_0_before;

//   function new(string name, uvm_component parent);
//     super.new(name, parent);
//   endfunction : new

//   // build phase.
//   function void build_phase(uvm_phase phase);

//     super.build_phase(phase);
//     // Create analysis exports/ports.
//     driver_0_export = new("driver_0_export", this);
//   endfunction : build_phase

//   //component's connect phase
//   function void connect_phase(uvm_phase phase);
//     super.connect_phase(phase);
//   endfunction : connect_phase

//   function void write(driver_seq_item t);
//     driver_0_export.write(t);
//     driver_0_before.do_copy(t);
//   endfunction

// endclass : driver_subs

//------------------------------------------------------------------------------
// Class: project_scbd
//------------------------------------------------------------------------------
// This scoreboard instantiates a predictor and a generic, in-order comparator
// for each agent. It receives transactions from agent monitors and routes
// them to the appropriate components.
//------------------------------------------------------------------------------
class project_scbd extends uvm_scoreboard;
  `uvm_component_utils(project_scbd)

  // --- Component Instantiations ---
  // A single, shared predictor for the environment
  project_predictor m_project_predictor;

  // A dedicated, parameterized comparator for each agent INSTANCE.
  in_order_comparator #(a_seq_item) m_a_act_comparator;
  in_order_comparator #(a_seq_item) m_a_pas_comparator;
  in_order_comparator #(b_seq_item) m_b_act_comparator;
  in_order_comparator #(b_seq_item) m_b_pas_comparator;

  // --- Analysis Exports ---
  // An analysis export for each agent INSTANCE.
  uvm_analysis_export #(a_seq_item) a_act_analysis_export;
  uvm_analysis_export #(a_seq_item) a_pas_analysis_export;
  uvm_analysis_export #(b_seq_item) b_act_analysis_export;
  uvm_analysis_export #(b_seq_item) b_pas_analysis_export;

  // --- Constructor ---
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // --- Build Phase ---
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the predictor
    m_project_predictor = project_predictor::type_id::create("m_project_predictor", this);

    // Create comparators and analysis exports for each agent INSTANCE
    m_a_act_comparator = new($sformatf("m_a_act_comparator"), this);
    a_act_analysis_export = new($sformatf("a_act_analysis_export"), this);
    m_a_pas_comparator = new($sformatf("m_a_pas_comparator"), this);
    a_pas_analysis_export = new($sformatf("a_pas_analysis_export"), this);
    m_b_act_comparator = new($sformatf("m_b_act_comparator"), this);
    b_act_analysis_export = new($sformatf("b_act_analysis_export"), this);
    m_b_pas_comparator = new($sformatf("m_b_pas_comparator"), this);
    b_pas_analysis_export = new($sformatf("b_pas_analysis_export"), this);
  endfunction : build_phase

  // --- Connect Phase ---
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connections are now made to instance-specific ports.
    // 1. Connect this scoreboard's export (from monitor) to the predictor's instance-specific input.
    this.a_act_analysis_export.connect(m_project_predictor.a_act_analysis_export);
    this.a_pas_analysis_export.connect(m_project_predictor.a_pas_analysis_export);
    this.b_act_analysis_export.connect(m_project_predictor.b_act_analysis_export);
    this.b_pas_analysis_export.connect(m_project_predictor.b_pas_analysis_export);

    // 2. Connect the predictor's instance-specific output to the comparator's 'before' port.
    m_project_predictor.predicted_a_act_aport.connect(m_a_act_comparator.before_export);
    m_project_predictor.predicted_a_pas_aport.connect(m_a_pas_comparator.before_export);
    m_project_predictor.predicted_b_act_aport.connect(m_b_act_comparator.before_export);
    m_project_predictor.predicted_b_pas_aport.connect(m_b_pas_comparator.before_export);

    // 3. Connect this scoreboard's export (actual items from DUT) to the comparator's 'after' port.
    this.a_act_analysis_export.connect(m_a_act_comparator.after_export);
    this.a_pas_analysis_export.connect(m_a_pas_comparator.after_export);
    this.b_act_analysis_export.connect(m_b_act_comparator.after_export);
    this.b_pas_analysis_export.connect(m_b_pas_comparator.after_export);

  endfunction

endclass : project_scbd