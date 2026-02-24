//------------------------------------------------------------------------------
// Class: project_test_base
//------------------------------------------------------------------------------
// Verification test base for the project design. All other tests
// should extend from this class.
//------------------------------------------------------------------------------
class project_test_base extends uvm_test;
  // UVM Factory Registration Macro
  `uvm_component_utils(project_test_base)

  // Environment and configuration handles
  project_env m_env;
  project_env_config env_config;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // Test's build phase
  function void build_phase(uvm_phase phase);
    // Must always call parent method's build phase.
    super.build_phase(phase);

    // Create environment and its configuration object.
    m_env = project_env::type_id::create("m_env", this);
    env_config = project_env_config::type_id::create("env_config");

    // TODO: Register model logic can be added here

    // Create and configure all agent configuration objects
    // Set agent to ACTIVE or PASSIVE based on YAML config.
    env_config.m_a_act_config = a_agent_config::type_id::create("m_a_act_config");
    env_config.m_a_act_config.active = UVM_ACTIVE;
    env_config.m_a_act_config.interface_name = "a_act_if";
    env_config.m_a_pas_config = a_agent_config::type_id::create("m_a_pas_config");
    env_config.m_a_pas_config.active = UVM_PASSIVE;
    env_config.m_a_pas_config.interface_name = "a_pas_if";
    env_config.m_b_act_config = b_agent_config::type_id::create("m_b_act_config");
    env_config.m_b_act_config.active = UVM_ACTIVE;
    env_config.m_b_pas_config = b_agent_config::type_id::create("m_b_pas_config");
    env_config.m_b_pas_config.active = UVM_PASSIVE;

    // Allow specific tests to override the default configuration
    configure_env(env_config);

    // Set the final configuration object into the UVM database
    uvm_config_db#(project_env_config)::set(this, "*", "project_env_config", env_config);
  endfunction : build_phase

  // Convenience method used by test sub-classes to modify the environment.
  virtual function void configure_env(project_env_config env_config);
    // Environment post-config can be done here in extended classes.
  endfunction : configure_env

  // Utility function to set verbosity levels
  function void set_verbosity_level();
    m_env.m_a_act.m_monitor.set_report_verbosity_level(UVM_LOW);
    m_env.m_a_pas.m_monitor.set_report_verbosity_level(UVM_LOW);
    m_env.m_b_act.m_monitor.set_report_verbosity_level(UVM_LOW);
    m_env.m_b_pas.m_monitor.set_report_verbosity_level(UVM_LOW);
  endfunction

  // Utility function to print a formatted test name banner
  function void fn_print_testname(string msg);
    int line_width = 100;
    int msg_length = msg.len();
    int padding = (line_width - msg_length) / 2;
    string separator = "";
    string s = "";

    repeat (padding) separator = {separator, "-"};
    repeat (line_width) s = {s, "-"};

    $display("#%s#", s);
    $display("#%s%s%s#", separator, msg, separator);
    $display("#%s#", s);
  endfunction

  // Utility function to check if a file exists
  function bit file_exist(string file_name_s, bit print=1);
    bit stat = 1;
    int stat2 = 1;
    string os;
    void'($value$plusargs("OS=%0s", os));
    if (os == "windows*") begin
      stat2 = $system({ "if exist ", file_name_s, " (exit 1) else (exit 0)" });
    end else begin
      stat2 = $system({"if [ -e ", file_name_s ," ]; then exit 1; else exit 0; fi;"});
    end
    stat = (stat2 == 1);
    return stat;
  endfunction : file_exist

endclass : project_test_base