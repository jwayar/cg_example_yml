//------------------------------------------------------------------------------
// Class: reset_test
//------------------------------------------------------------------------------
// This test verifies the DUT's reset functionality by toggling the reset
// signal at random intervals.
//------------------------------------------------------------------------------
class reset_test extends project_test_base;
  // UVM Factory Registration Macro
  `uvm_component_utils(reset_test)

  // Test-specific sequences
  reset_vseq m_reset_vseq;
  sanity_vseq dummy_vseq;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_reset_vseq = reset_vseq::type_id::create("reset_vseq");
    dummy_vseq = sanity_vseq::type_id::create("dummy_vseq");
  endfunction : build_phase

  // Environment configuration for this specific test
  function void configure_env(project_env_config env_config);
    // Enable all agents for this test, but disable the scoreboard
    // as we are only concerned with reset functionality.
    env_config.has_scoreboard = 1'b0;
    env_config.has_a_act = 1'b1;
    env_config.has_a_pas = 1'b1;
    env_config.has_b_act = 1'b1;
    env_config.has_b_pas = 1'b1;
  endfunction : configure_env

  // Main task executed by the test
  task run_phase(uvm_phase phase);
    int random_time = 1100;
    set_verbosity_level();

    phase.raise_objection(this);
    fn_print_testname("RESET_TEST");
    #TIME_RESET;

    repeat (RESET_REPEAT) begin
      fork
      begin
        if (!m_reset_vseq.randomize() with {m_reset == 1'b0;}) begin
          `uvm_error(get_name(), "Failed to randomize reset_vseq error!");
        end
        m_reset_vseq.start(m_env.v_sqr);

        // Wait for a random time
        random_time = $urandom_range(RESET_TIME_MIN, RESET_TIME_MAX);
        `uvm_info("RESET", $sformatf("TIME_WIDTH : %0t", random_time), UVM_DEBUG);
        #(random_time*CLK_PERIOD);

        if (!m_reset_vseq.randomize() with {m_reset == 1'b1;}) begin
          `uvm_error(get_name(), "Failed to randomize reset_vseq error!");
        end
        m_reset_vseq.start(m_env.v_sqr);
        `uvm_info("RESET", $sformatf("RESET ON : %0t", $realtime), UVM_DEBUG);

        // Wait for a random time while reset is asserted
        random_time = $urandom_range(1, RESET_SPACE);
        $display("TIME_RESET_ON_WIDTH %d", random_time);
        #(random_time*CLK_PERIOD);

        if (!m_reset_vseq.randomize() with {m_reset == 1'b0;}) begin
          `uvm_error(get_name(), "Failed to randomize reset_vseq error!");
        end
        m_reset_vseq.start(m_env.v_sqr);
      end
      join_any
    end

    phase.drop_objection(this);
  endtask : run_phase

endclass : reset_test