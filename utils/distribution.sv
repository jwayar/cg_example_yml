`ifndef DISTRIBUTION_SV
`define DISTRIBUTION_SV

class normal_int_distribution;
  int value;
  int seed;
  int mean;
  int std;
  function new();
    seed = $urandom();
  endfunction : new
  function void pre_randomize();
    value = $dist_normal(seed, mean, std);
  endfunction

endclass

class d_exponencial_value #(
    parameter MEAN = 1
);
  int value;
  int seed;
  function new();
    seed = $urandom();
  endfunction : new

  function void pre_randomize();
    value = $dist_exponential(seed, MEAN);
  endfunction
endclass

class d_bathtub_value #(
    parameter REG_WITH = 8,
    parameter MEAN = 20
);
  logic [REG_WITH-1:0] value;
  int seed;
  function new();
    seed = $urandom();
  endfunction : new

  function void pre_randomize();
    value = $dist_exponential(seed, MEAN);
    if ($urandom_range(1)) begin
      value = (2 ** (REG_WITH) - 1) - value;
    end
  endfunction
endclass

// This class randomizes "value" so that the distribution of max(value) in a window
// of length "window_size" is uniform.
class d_max_uniform_unsigned #(parameter REG_WITH=8, parameter WINDOW_SIZE=128);
  parameter X_WIDTH = 30;
  logic unsigned [REG_WITH-1:0] value;

  function new();
  endfunction : new

  function void pre_randomize();
    logic unsigned [X_WIDTH-1:0] x;

    x = $urandom();
    value = real'($pow(real'(x)/real'((2**X_WIDTH)-1),WINDOW_SIZE)) * real'((2**REG_WITH)-1);

    `uvm_info("d_max_uniform", $sformatf("$pow %0g, x %0g, value %0g", $pow(real'(x)/real'((2**X_WIDTH)-1),WINDOW_SIZE), x, value), UVM_DEBUG)
  endfunction
endclass

// This class randomizes "value" so that the distribution of max(abs(value)) in a window
// of length "window_size" is uniform.
class d_max_uniform_signed #(parameter REG_WITH=8, parameter WINDOW_SIZE=128);
  parameter X_WIDTH = 30;
  logic signed [REG_WITH-1:0] value;

  function new();
  endfunction : new

  function void pre_randomize();
    logic unsigned [X_WIDTH-1:0] x;
    bit sign;

    x = $urandom();
    sign = $urandom();

    if(sign) begin
      value = real'($pow(real'(x)/real'((2**X_WIDTH)-1),WINDOW_SIZE)) * real'((2**(REG_WITH-1))-1);
      `uvm_info("d_max_uniform", $sformatf("value_re %0g, value %0d", real'($pow(real'(x)/real'((2**X_WIDTH)-1),WINDOW_SIZE)) * real'((2**(REG_WITH-1))-1), value), UVM_DEBUG)
    end else begin
      value = real'($pow(real'(x)/real'((2**X_WIDTH)-1),WINDOW_SIZE)) * real'((2**(REG_WITH-1))) * (-1.0);
      `uvm_info("d_max_uniform", $sformatf("value_re %0g, value %0d", real'($pow(real'(x)/real'((2**X_WIDTH)-1),WINDOW_SIZE)) * real'((2**(REG_WITH-1))) * (-1.0), value), UVM_DEBUG)
    end

  endfunction

endclass

`endif  // DISTRIBUTION_SV