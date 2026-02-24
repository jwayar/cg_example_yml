//
// Detailed Description:
// Environment package, containing the environment configuration and class.
//
// -----------------------------------------------------------------------------
package project_env_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Import agent packages
  import a_agent_pkg::*;
  import b_agent_pkg::*;

  // Import project-level packages
  import project_defn_pkg::*;
  import project_vseqr_pkg::*;
  import project_scbd_pkg::*;
  import project_coverage_pkg::*;
  //import project_regs_pkg::*;

  //------------------------------------------------------------------------------
  // Class: project_env_config
  //------------------------------------------------------------------------------
  class project_env_config extends uvm_object;
    `uvm_object_utils(project_env_config)

    // Agent usage flags per instance
    bit has_a_act = 1'b0;
    bit has_a_pas = 1'b0;
    bit has_b_act = 1'b0;
    bit has_b_pas = 1'b0;

    // Component usage flags
    bit has_scoreboard = 1'b0;
    bit has_coverage = 1'b0;

    // Configuration objects per instance
    a_agent_config m_a_act_config;
    a_agent_config m_a_pas_config;
    b_agent_config m_b_act_config;
    b_agent_config m_b_pas_config;

    function new(string name = "project_env_config");
      super.new(name);
    endfunction
  endclass

  //------------------------------------------------------------------------------
  // Class: project_env
  //------------------------------------------------------------------------------
  class project_env extends uvm_env;
    `uvm_component_utils(project_env)

    project_env_config m_config;

    // Agent instantiations per instance
    a_agent m_a_act;
    a_agent m_a_pas;
    b_agent m_b_act;
    b_agent m_b_pas;

    // Other components
    project_scbd m_scoreboard;
    project_coverage m_coverage;
    project_vseqr v_sqr;

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if (!uvm_config_db#(project_env_config)::get(this, "", "project_env_config", m_config))
        `uvm_fatal("Project Env", "No configuration object found")

      // Get virtual interfaces for simple agents and assign them to their configs
      if (m_config.has_b_act) begin
        if (!uvm_config_db#(virtual b_if)::get(this, "", "b_act_vif", m_config.m_b_act_config.vif))
          `uvm_fatal("ENV/VIF", "Could not get virtual interface for b_act")
      end
      if (m_config.has_b_pas) begin
        if (!uvm_config_db#(virtual b_if)::get(this, "", "b_pas_vif", m_config.m_b_pas_config.vif))
          `uvm_fatal("ENV/VIF", "Could not get virtual interface for b_pas")
      end

      // Create agents based on config flags per instance
      if (m_config.has_a_act) begin
        m_a_act = a_agent::type_id::create("m_a_act", this);
        uvm_config_db#(a_agent_config)::set(this, "m_a_act", "m_config", m_config.m_a_act_config);
      end
      if (m_config.has_a_pas) begin
        m_a_pas = a_agent::type_id::create("m_a_pas", this);
        uvm_config_db#(a_agent_config)::set(this, "m_a_pas", "m_config", m_config.m_a_pas_config);
      end
      if (m_config.has_b_act) begin
        m_b_act = b_agent::type_id::create("m_b_act", this);
        uvm_config_db#(b_agent_config)::set(this, "m_b_act", "m_config", m_config.m_b_act_config);
      end
      if (m_config.has_b_pas) begin
        m_b_pas = b_agent::type_id::create("m_b_pas", this);
        uvm_config_db#(b_agent_config)::set(this, "m_b_pas", "m_config", m_config.m_b_pas_config);
      end

      // Create other components based on config flags
      if (m_config.has_scoreboard) begin
        m_scoreboard = project_scbd::type_id::create("m_scoreboard", this);
      end

      if (m_config.has_coverage) begin
        m_coverage = project_coverage::type_id::create("m_coverage", this);
      end

      v_sqr = project_vseqr::type_id::create("v_sqr", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // Connect agent monitors to scoreboard and coverage components per instance
      if (m_config.has_a_act) begin
        if (m_config.has_scoreboard) begin
          m_a_act.m_monitor.aport.connect(m_scoreboard.a_act_analysis_export);
        end

        if (m_config.has_coverage) begin
          m_a_act.m_monitor.aport.connect(m_coverage.a_act_fifo.analysis_export);
        end

        uvm_config_db#(a_sequencer)::set(this, "*", "m_a_act_seqr", m_a_act.m_sequencer);
        v_sqr.m_a_act_seqr = m_a_act.m_sequencer;
      end

      if (m_config.has_a_pas) begin
        if (m_config.has_scoreboard) begin
          m_a_pas.m_monitor.aport.connect(m_scoreboard.a_pas_analysis_export);
        end

        if (m_config.has_coverage) begin
          m_a_pas.m_monitor.aport.connect(m_coverage.a_pas_fifo.analysis_export);
        end

      end

      if (m_config.has_b_act) begin
        if (m_config.has_scoreboard) begin
          m_b_act.m_monitor.aport.connect(m_scoreboard.b_act_analysis_export);
        end

        if (m_config.has_coverage) begin
          m_b_act.m_monitor.aport.connect(m_coverage.b_act_fifo.analysis_export);
        end

        uvm_config_db#(b_sequencer)::set(this, "*", "m_b_act_seqr", m_b_act.m_sequencer);
        v_sqr.m_b_act_seqr = m_b_act.m_sequencer;
      end

      if (m_config.has_b_pas) begin
        if (m_config.has_scoreboard) begin
          m_b_pas.m_monitor.aport.connect(m_scoreboard.b_pas_analysis_export);
        end

        if (m_config.has_coverage) begin
          m_b_pas.m_monitor.aport.connect(m_coverage.b_pas_fifo.analysis_export);
        end

      end

    endfunction : connect_phase

  endclass : project_env

endpackage : project_env_pkg