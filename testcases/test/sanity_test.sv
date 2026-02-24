//------------------------------------------------------------------------------
// Class: sanity_test
//------------------------------------------------------------------------------
// A basic sanity test to ensure the environment runs and can execute a simple
// virtual sequence.
//------------------------------------------------------------------------------
class sanity_test extends project_test_base;
  // UVM Factory Registration Macro
  `uvm_component_utils(sanity_test)

  // The virtual sequence to be run in this test
  sanity_vseq dummy_vseq;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    dummy_vseq = sanity_vseq::type_id::create("dummy_vseq");
  endfunction : build_phase

  // Environment configuration for this specific test
  function void configure_env(project_env_config env_config);
    // Enable all agents and the scoreboard for this test.
    env_config.has_scoreboard = 1'b0;
    env_config.has_a_act = 1'b1;
    env_config.has_a_pas = 1'b1;
    env_config.has_b_act = 1'b1;
    env_config.has_b_pas = 1'b1;
  endfunction : configure_env

  // Main task executed by the test
  task run_phase(uvm_phase phase);
    set_verbosity_level();
    uvm_test_done.raise_objection(this);

    fn_print_testname("SANITY_TEST");
    #TIME_RESET;

    fork
      begin
        dummy_vseq.start(m_env.v_sqr);
      end
    join

    uvm_test_done.drop_objection(this);
  endtask : run_phase

endclass : sanity_test