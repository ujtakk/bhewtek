`timescale 1ns/1ps

module test_top_first();
`include "parameters.vh"

  /*AUTOREGINPUT*/
  // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
  reg			clk;			// To dut0 of top.v
  reg [LWIDTH-1:0]	fil_size;		// To dut0 of top.v
  reg [LWIDTH-1:0]	img_size;		// To dut0 of top.v
  reg [INSIZE-1:0]	input_addr;		// To dut0 of top.v
  reg			input_we;		// To dut0 of top.v
  reg [OUTSIZE-1:0]	output_addr;		// To dut0 of top.v
  reg [3:0]		output_re;		// To dut0 of top.v
  reg [LWIDTH-1:0]	pool_size;		// To dut0 of top.v
  reg			req;			// To dut0 of top.v
  reg [LWIDTH-1:0]	total_in;		// To dut0 of top.v
  reg [LWIDTH-1:0]	total_out;		// To dut0 of top.v
  reg [WSIZE-1:0]	weight_addr;		// To dut0 of top.v
  reg [3:0]		weight_we;		// To dut0 of top.v
  reg signed [DWIDTH-1:0] write_input;		// To dut0 of top.v
  reg signed [DWIDTH-1:0] write_weight;		// To dut0 of top.v
  reg			xrst;			// To dut0 of top.v
  // End of automatics

  /*AUTOWIRE*/
  // Beginning of automatic wires (for undeclared instantiated-module outputs)
  wire			ack;			// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output0_2;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output0_3;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output0_4;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output1_2;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output1_3;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output1_4;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output2_0;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output2_1;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output2_2;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output2_3;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output2_4;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output3_0;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output3_1;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output3_2;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output3_3;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output3_4;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output4_0;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output4_1;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output4_2;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output4_3;	// From dut0 of top.v
  wire signed [DWIDTH-1:0] buf_output4_4;	// From dut0 of top.v
  wire			out_conv_begin;		// From dut0 of top.v
  wire			out_conv_end;		// From dut0 of top.v
  wire			out_conv_valid;		// From dut0 of top.v
  wire			out_core_begin;		// From dut0 of top.v
  wire			out_core_end;		// From dut0 of top.v
  wire			out_core_valid;		// From dut0 of top.v
  wire			out_pool_begin;		// From dut0 of top.v
  wire			out_pool_end;		// From dut0 of top.v
  wire			out_pool_valid;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] read_output;		// From dut0 of top.v
  // End of automatics

  //clock
  always
  begin
    clk = 0;
    #(STEP/2);
    clk = 1;
    #(STEP/2);
  end

  reg [DWIDTH-1:0] mem_in [2**INSIZE-1:0];
  reg [DWIDTH-1:0] mem_w0 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w1 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w2 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w3 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w4 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w5 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w6 [2**WSIZE-1:0];
  reg [DWIDTH-1:0] mem_w7 [2**WSIZE-1:0];

  integer fp;
  integer i;
  initial
  begin
    // $set_toggle_region(test_top.dut0);

    // mem_clear;
    mem_clear_direct;

    xrst = 0;
    req = 0;

    input_we = 0;
    input_addr = 0;
    write_input = 0;

    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;

    output_re = 0;
    output_addr = 0;

    #(STEP);
    xrst = 1;

    read_input_direct;
    // read_input;
    // input_we = 1;
    // for (i=0; i<2**INSIZE; i=i+1)
    // begin
    //   input_addr = i;
    //   write_input = mem_in[i];
    //   #(STEP);
    // end
    // input_we = 0;
    // input_addr = 0;
    // write_input = 0;

    read_weight_direct;
    // read_weight;
    //     // weight_we = 4'd1;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w0[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd2;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w1[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd3;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w2[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd4;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w3[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd5;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w4[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd6;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w5[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd7;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w6[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    //     // weight_we = 4'd8;
    // for (i=0; i<2**WSIZE; i=i+1)
    // begin
    //  weight_addr = i;
    //  write_weight = mem_w7[i];
    //  #(STEP);
    // end
    // weight_we = 4'd0;
    // weight_addr = 0;
    // write_weight = 0;
    // 
    // $toggle_start();
    #(STEP);

    req           = 0;
    fil_size      = FSIZE;
    pool_size     = PSIZE;
    img_size      = 28;
    total_in      = 1;
    total_out     = N_F1;
    input_addr    = 0;
    weight_addr   = 0;
    input_we      = 0;
    write_input   = 0;
    write_weight  = 0;
    weight_we     = 4'd0;
    output_addr   = 0;
    output_re     = 0;

    #(STEP);

    req = 1;

    #(STEP);

    req = 0;

    while(!ack) #(STEP);
    #(STEP*10);

    // valid_memin;
    // valid_memw;
    write_output;
    //
    // $toggle_stop();
    // $toggle_report(
    //   "../saif_rtl/saif{CORE}/rtl_top{NUM}_{FILE}.saif",
    //   1.0e-9,
    //   "test_top"
    // );
    $finish();
  end

  top dut0(/*AUTOINST*/
	   // Outputs
	   .ack				(ack),
	   .buf_output0_2		(buf_output0_2[DWIDTH-1:0]),
	   .buf_output0_3		(buf_output0_3[DWIDTH-1:0]),
	   .buf_output0_4		(buf_output0_4[DWIDTH-1:0]),
	   .buf_output1_2		(buf_output1_2[DWIDTH-1:0]),
	   .buf_output1_3		(buf_output1_3[DWIDTH-1:0]),
	   .buf_output1_4		(buf_output1_4[DWIDTH-1:0]),
	   .buf_output2_0		(buf_output2_0[DWIDTH-1:0]),
	   .buf_output2_1		(buf_output2_1[DWIDTH-1:0]),
	   .buf_output2_2		(buf_output2_2[DWIDTH-1:0]),
	   .buf_output2_3		(buf_output2_3[DWIDTH-1:0]),
	   .buf_output2_4		(buf_output2_4[DWIDTH-1:0]),
	   .buf_output3_0		(buf_output3_0[DWIDTH-1:0]),
	   .buf_output3_1		(buf_output3_1[DWIDTH-1:0]),
	   .buf_output3_2		(buf_output3_2[DWIDTH-1:0]),
	   .buf_output3_3		(buf_output3_3[DWIDTH-1:0]),
	   .buf_output3_4		(buf_output3_4[DWIDTH-1:0]),
	   .buf_output4_0		(buf_output4_0[DWIDTH-1:0]),
	   .buf_output4_1		(buf_output4_1[DWIDTH-1:0]),
	   .buf_output4_2		(buf_output4_2[DWIDTH-1:0]),
	   .buf_output4_3		(buf_output4_3[DWIDTH-1:0]),
	   .buf_output4_4		(buf_output4_4[DWIDTH-1:0]),
	   .out_conv_begin		(out_conv_begin),
	   .out_conv_end		(out_conv_end),
	   .out_conv_valid		(out_conv_valid),
	   .out_core_begin		(out_core_begin),
	   .out_core_end		(out_core_end),
	   .out_core_valid		(out_core_valid),
	   .out_pool_begin		(out_pool_begin),
	   .out_pool_end		(out_pool_end),
	   .out_pool_valid		(out_pool_valid),
	   .read_output			(read_output[DWIDTH-1:0]),
	   // Inputs
	   .clk				(clk),
	   .fil_size			(fil_size[LWIDTH-1:0]),
	   .img_size			(img_size[LWIDTH-1:0]),
	   .input_addr			(input_addr[INSIZE-1:0]),
	   .input_we			(input_we),
	   .output_addr			(output_addr[OUTSIZE-1:0]),
	   .output_re			(output_re[3:0]),
	   .pool_size			(pool_size[LWIDTH-1:0]),
	   .req				(req),
	   .total_in			(total_in[LWIDTH-1:0]),
	   .total_out			(total_out[LWIDTH-1:0]),
	   .weight_addr			(weight_addr[WSIZE-1:0]),
	   .weight_we			(weight_we[3:0]),
	   .write_input			(write_input[DWIDTH-1:0]),
	   .write_weight		(write_weight[DWIDTH-1:0]),
	   .xrst			(xrst));

  task mem_clear;
    begin
      for (i=0; i<2**INSIZE; i=i+1)
      begin
        mem_in[i] = {DWIDTH{1'b0}};
      end

      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w0[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w1[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w2[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w3[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w4[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w5[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w6[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        mem_w7[i] = {DWIDTH{1'b0}};
      end
    end
  endtask

  task mem_clear_direct;
    begin
      for (i=0; i<2**INSIZE; i=i+1)
      begin
        dut0.mem_input.mem[i] = {DWIDTH{1'b0}};
      end

      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight0.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight1.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight2.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight3.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight4.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight5.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight6.mem[i] = {DWIDTH{1'b0}};
      end
      for (i=0; i<2**WSIZE; i=i+1)
      begin
        dut0.mem_weight7.mem[i] = {DWIDTH{1'b0}};
      end
    end
  endtask

  task read_input;
    begin
      $readmemb(
        "../data/mnist/binput/2/data4.bin",
        mem_in,
        0,
        783
      );
    end
  endtask

  task read_input_direct;
    begin
      $readmemb(
        "../data/mnist/binput/2/data4.bin",
        // "../data/binrand_input.dat",
        dut0.mem_input.mem,
        0,
        783
      );
    end
  endtask

  task read_weight;
    begin
      $readmemb(
        "../data/mnist/lenet/bwb_1/data0_0.bin",
        mem_w0,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data1_0.bin",
        mem_w1,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data2_0.bin",
        mem_w2,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data3_0.bin",
        mem_w3,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data4_0.bin",
        mem_w4,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data5_0.bin",
        mem_w5,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data6_0.bin",
        mem_w6,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data7_0.bin",
        mem_w7,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data8_0.bin",
        mem_w0,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data9_0.bin",
        mem_w1,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data10_0.bin",
        mem_w2,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data11_0.bin",
        mem_w3,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data12_0.bin",
        mem_w4,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data13_0.bin",
        mem_w5,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data14_0.bin",
        mem_w6,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data15_0.bin",
        mem_w7,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data16_0.bin",
        mem_w0,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data17_0.bin",
        mem_w1,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data18_0.bin",
        mem_w2,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data19_0.bin",
        mem_w3,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        mem_w4,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        mem_w5,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        mem_w6,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        mem_w7,
        50,
        74
      );
    end
  endtask

  task read_weight_direct;
    begin
      $readmemb(
        "../data/mnist/lenet/bwb_1/data0_0.bin",
        dut0.mem_weight0.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data1_0.bin",
        dut0.mem_weight1.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data2_0.bin",
        dut0.mem_weight2.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data3_0.bin",
        dut0.mem_weight3.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data4_0.bin",
        dut0.mem_weight4.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data5_0.bin",
        dut0.mem_weight5.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data6_0.bin",
        dut0.mem_weight6.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data7_0.bin",
        dut0.mem_weight7.mem,
        0,
        24
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data8_0.bin",
        dut0.mem_weight0.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data9_0.bin",
        dut0.mem_weight1.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data10_0.bin",
        dut0.mem_weight2.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data11_0.bin",
        dut0.mem_weight3.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data12_0.bin",
        dut0.mem_weight4.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data13_0.bin",
        dut0.mem_weight5.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data14_0.bin",
        dut0.mem_weight6.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data15_0.bin",
        dut0.mem_weight7.mem,
        25,
        49
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data16_0.bin",
        dut0.mem_weight0.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data17_0.bin",
        dut0.mem_weight1.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data18_0.bin",
        dut0.mem_weight2.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/data19_0.bin",
        dut0.mem_weight3.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        dut0.mem_weight4.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        dut0.mem_weight5.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        dut0.mem_weight6.mem,
        50,
        74
      );
      $readmemb(
        "../data/mnist/lenet/bwb_1/null.bin",
        dut0.mem_weight7.mem,
        50,
        74
      );
    end
  endtask

  task write_output;
    integer fd;
    integer i;
    integer out_size;
    integer o_unit;
    integer o_offset;
    integer o_index;
    begin
      fd = $fopen("test_top_first.dat", "w");
      out_size = 2880;
      o_unit = 144;
      for (i=0; i<out_size; i=i+1)
      begin
        o_offset = i % o_unit;
        o_index  = i / o_unit;
        if (o_offset == 0)
          output_re = o_index % 8 + 1;
        output_addr = o_offset + o_unit*(o_index/8);
        #(STEP*2);
        $fdisplay(fd, "%0d", read_output);
      end
      output_re = 0;
      $fclose(fd);
    end
  endtask

  task valid_memin;
    integer i;
    integer in_size;
    begin
      in_size = 784;
      for (i = 0; i < in_size; i = i + 1)
      begin
        #(STEP);
        input_addr = i;
        #(STEP);
        if (dut0.read_input != mem_in[i])
          $display("Fail: %d", i);
      end
      $display("valid_memin complete.");
    end
  endtask

  task valid_memw;
    integer i;
    integer w_size;
    begin
      w_size = 20*1*5*5;
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight0 != mem_w0[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight1 != mem_w1[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight2 != mem_w2[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight3 != mem_w3[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight4 != mem_w4[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight5 != mem_w5[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight6 != mem_w6[i])
          $display("Fail: %d", i);
      end
      for (i = 0; i < w_size; i = i + 1)
      begin
        #(STEP);
        weight_addr = i;
        #(STEP);
        if (dut0.read_weight7 != mem_w7[i])
          $display("Fail: %d", i);
      end
      $display("valid_memw complete.");
    end
  endtask

  always
  begin
    #(STEP/2-1);
    $display(
      "%5d: ", $time/STEP,
      "%d ", xrst,
      "%d ", req,
      "%d ", ack,
      "%d ", dut0.ctrl.ctrl_core.r_state,
      "| ",
      "%d ",  dut0.ctrl.ctrl_core.out_begin,
      "%d ",  dut0.ctrl.ctrl_core.out_valid,
      "%d: ", dut0.ctrl.ctrl_core.out_end,
      "%2d ", dut0.ctrl.ctrl_core.r_count_out,
      "%2d ", dut0.ctrl.ctrl_core.r_count_in,
      "%2d ", dut0.ctrl.ctrl_core.r_weight_x,
      "%2d ", dut0.ctrl.ctrl_core.r_weight_y,
      "%2d ", dut0.ctrl.ctrl_core.r_input_x,
      "%2d ", dut0.ctrl.ctrl_core.r_input_y,
      // "| ",
      // "%d: ", dut0.buf_pix.r_state,
      // "%d ", dut0.buf_pix.mem_linebuf_we,
      // "%4d ", dut0.read_input,
      // "%4d ", dut0.pixel0,
      // "| ",
      // "%d ",  dut0.ctrl.ctrl_conv.out_begin,
      // "%d ",  dut0.ctrl.ctrl_conv.out_valid,
      // "%d: ", dut0.ctrl.ctrl_conv.out_end,
      // "%d ", dut0.ctrl.ctrl_conv.conv_begin,
      // "%d ", dut0.ctrl.ctrl_conv.conv_valid,
      // "%d ", dut0.ctrl.ctrl_conv.conv_end,
      "| ",
      "%d: ", dut0.core0.buf_feat.r_state,
      "%d ", dut0.core0.buf_feat.mem_linebuf_we,
      "%4d ", dut0.core0.fmap,
      "%4d ", dut0.core0.pixel_feat0,
      "|@ ",
      "%d: ", dut0.core0.pool_we,
      "%4d ", dut0.core0.pool.max,
      "%4d ", dut0.core0.pool.r_pixel_feat0,
      "%4d ", dut0.core0.pool.r_pixel_feat1,
      "%4d ", dut0.core0.pool.r_pixel_feat2,
      "%4d ", dut0.core0.pool.r_pixel_feat3,
      "| ",
      "%d ", dut0.mem_output_we,
      "%d: ", dut0.mem_output_addr,
      "%d ", dut0.pmap0,
      "%d ", dut0.read_output0,
      "%d ", dut0.output_re,
      "%d ", dut0.read_output,
      "|"
    );
    #(STEP/2+1);
  end

endmodule
