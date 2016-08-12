`timescale 1ns/1ps

module test_top();
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
  wire signed [DWIDTH-1:0] probe_in;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w0;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w1;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w2;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w3;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w4;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w5;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w6;		// From dut0 of top.v
  wire signed [DWIDTH-1:0] probe_w7;		// From dut0 of top.v
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
    //$set_toggle_region(test_top.dut0);

    mem_clear;

    fp = $fopen("log.txt");

    xrst = 0;

    input_addr = 0;
    write_input = 0;
    input_we = 0;

    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;

    output_addr = 0;
    output_re = 0;

    #(STEP);
    xrst = 1;

    read_input;
    input_we = 1;
    for (i=0; i<2**INSIZE; i=i+1)
    begin
      input_addr = i;
      write_input = mem_in[i];
      #(STEP*5);
    end
    input_we = 0;
    input_addr = 0;
    write_input = 0;

    read_weight;
    weight_we = 4'd1;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w0[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd2;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w1[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd3;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w2[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd4;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w3[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd5;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w4[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd6;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w5[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd7;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w6[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;
    weight_we = 4'd8;
    for (i=0; i<2**WSIZE; i=i+1)
    begin
      weight_addr = i;
      write_weight = mem_w7[i];
      #(STEP*2);
    end
    weight_we = 4'd0;
    weight_addr = 0;
    write_weight = 0;

    //$toggle_start();
    #(STEP);

    req           = 0;
    fil_size      = FSIZE;
    img_size      = INSIZE;
    total_in      = N_F1;
    total_out     = N_F2;
    input_addr    = 0;
    weight_addr   = 0;
    input_we      = 0;
    write_input   = 0;
    write_weight  = 0;
    weight_we     = 4'd0;
    output_addr   = 0;
    output_re     = 0;

    #(STEP*5);

    req = 1;

    #(STEP*5);

    req = 0;

    while(!ack) #(STEP);

    #(STEP*10);

    write_output;
    valid_memin;

    //$toggle_stop();
    //$toggle_report("/home/work/takau/bhewtek/saif_rtl/saif{CORE}/rtl_top{NUM}_{FILE}.saif", 1.0e-9, "test_top");
    $finish();
  end

  always
  begin
    #(STEP/2-1);
    if (dut0.mem_output_we)
      $display(
        "%5d: ", $time/STEP,
        "%d ", $signed(dut0.pmap0),
        "%d ", $signed(dut0.pmap1),
        "%d ", $signed(dut0.pmap2),
        "%d ", $signed(dut0.pmap3),
        "%d ", $signed(dut0.pmap4),
        "%d ", $signed(dut0.pmap5),
        "%d ", $signed(dut0.pmap6),
        "%d ", $signed(dut0.pmap7),
      );

    $fdisplay(fp,
      "%5d: ", $time/STEP,
      "%d ", xrst,
      "%d ", req,
      "%d ", ack,
      "| ",
      "%d ", dut0.core0.pixel_feat0,
      "%d ", dut0.core0.pixel_feat1,
      "%d ", dut0.core0.pixel_feat2,
      "%d ", dut0.core0.pixel_feat3,
      "%d ", dut0.core0.fmap,
      "%d ", dut0.core1.fmap,
      "%d ", dut0.core2.fmap,
      "%d ", dut0.core3.fmap,
      "%d ", dut0.core4.fmap,
      "%d ", dut0.core5.fmap,
      "%d ", dut0.core6.fmap,
      "%d ", dut0.core7.fmap,
      "| ",
      "%d ", dut0.read_output0,
      "%d ", dut0.read_output1,
      "%d ", dut0.read_output2,
      "%d ", dut0.read_output3,
      "%d ", dut0.read_output4,
      "%d ", dut0.read_output5,
      "%d ", dut0.read_output6,
      "%d ", dut0.read_output7,
      "%d ", read_output,
      //"| ",
      //"%d ", dut0.ctrl.r_state,
      //"%d ", dut0.ctrl.r_count_in,
      //"%d ", dut0.ctrl.r_count_out,
      //"| ",
      //"%d ", dut0.ctrl.r_wreg_x,
      //"%d ", dut0.ctrl.r_wreg_y,
      //"%d ", dut0.ctrl.wreg_valid,
      //"; ",
      //"%d ", dut0.ctrl.r_conv_x,
      //"%d ", dut0.ctrl.r_conv_y,
      //"%d ", dut0.ctrl.conv_valid,
      //"; ",
      //"%d ", dut0.ctrl.r_pool_x,
      //"%d ", dut0.ctrl.r_pool_y,
      //"%d ", dut0.ctrl.pool_valid,
      //"@@ ",
      //"%d ", dut0.ctrl.pool_end,
      //"%d ", dut0.ctrl.mem_output_we,
      //"%d ", dut0.ctrl.mem_output_addr,
      //"%d ", dut0.ctrl.ack,
    );
    #(STEP/2+1);
  end

  top dut0(/*AUTOINST*/
	   // Outputs
	   .ack				(ack),
	   .read_output			(read_output[DWIDTH-1:0]),
	   .probe_in			(probe_in[DWIDTH-1:0]),
	   .probe_w0			(probe_w0[DWIDTH-1:0]),
	   .probe_w1			(probe_w1[DWIDTH-1:0]),
	   .probe_w2			(probe_w2[DWIDTH-1:0]),
	   .probe_w3			(probe_w3[DWIDTH-1:0]),
	   .probe_w4			(probe_w4[DWIDTH-1:0]),
	   .probe_w5			(probe_w5[DWIDTH-1:0]),
	   .probe_w6			(probe_w6[DWIDTH-1:0]),
	   .probe_w7			(probe_w7[DWIDTH-1:0]),
	   // Inputs
	   .clk				(clk),
	   .fil_size			(fil_size[LWIDTH-1:0]),
	   .img_size			(img_size[LWIDTH-1:0]),
	   .input_addr			(input_addr[INSIZE-1:0]),
	   .input_we			(input_we),
	   .output_addr			(output_addr[OUTSIZE-1:0]),
	   .output_re			(output_re[3:0]),
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

  task read_input;
    begin
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_0.bin", mem_in, 0, 143);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_1.bin", mem_in, 144, 287);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_2.bin", mem_in, 288, 431);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_3.bin", mem_in, 432, 575);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_4.bin", mem_in, 576, 719);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_5.bin", mem_in, 720, 863);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_6.bin", mem_in, 864, 1007);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_7.bin", mem_in, 1008, 1151);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_8.bin", mem_in, 1152, 1295);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_9.bin", mem_in, 1296, 1439);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_10.bin", mem_in, 1440, 1583);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_11.bin", mem_in, 1584, 1727);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_12.bin", mem_in, 1728, 1871);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_13.bin", mem_in, 1872, 2015);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_14.bin", mem_in, 2016, 2159);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_15.bin", mem_in, 2160, 2303);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_16.bin", mem_in, 2304, 2447);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_17.bin", mem_in, 2448, 2591);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_18.bin", mem_in, 2592, 2735);
      $readmemb("/home/work/takau/bhewtek/data/mnist/bpmap1/2/data4_19.bin", mem_in, 2736, 2879);
    end
  endtask

  task read_weight;
    begin
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_0.bin", mem_w0, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_0.bin", mem_w1, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_0.bin", mem_w2, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_0.bin", mem_w3, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_0.bin", mem_w4, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_0.bin", mem_w5, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_0.bin", mem_w6, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_0.bin", mem_w7, 0, 24);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_1.bin", mem_w0, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_1.bin", mem_w1, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_1.bin", mem_w2, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_1.bin", mem_w3, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_1.bin", mem_w4, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_1.bin", mem_w5, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_1.bin", mem_w6, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_1.bin", mem_w7, 25, 49);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_2.bin", mem_w0, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_2.bin", mem_w1, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_2.bin", mem_w2, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_2.bin", mem_w3, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_2.bin", mem_w4, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_2.bin", mem_w5, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_2.bin", mem_w6, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_2.bin", mem_w7, 50, 74);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_3.bin", mem_w0, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_3.bin", mem_w1, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_3.bin", mem_w2, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_3.bin", mem_w3, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_3.bin", mem_w4, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_3.bin", mem_w5, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_3.bin", mem_w6, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_3.bin", mem_w7, 75, 99);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_4.bin", mem_w0, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_4.bin", mem_w1, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_4.bin", mem_w2, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_4.bin", mem_w3, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_4.bin", mem_w4, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_4.bin", mem_w5, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_4.bin", mem_w6, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_4.bin", mem_w7, 100, 124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_5.bin", mem_w0, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_5.bin", mem_w1, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_5.bin", mem_w2, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_5.bin", mem_w3, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_5.bin", mem_w4, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_5.bin", mem_w5, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_5.bin", mem_w6, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_5.bin", mem_w7, 125, 149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_6.bin", mem_w0, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_6.bin", mem_w1, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_6.bin", mem_w2, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_6.bin", mem_w3, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_6.bin", mem_w4, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_6.bin", mem_w5, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_6.bin", mem_w6, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_6.bin", mem_w7, 150, 174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_7.bin", mem_w0, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_7.bin", mem_w1, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_7.bin", mem_w2, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_7.bin", mem_w3, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_7.bin", mem_w4, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_7.bin", mem_w5, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_7.bin", mem_w6, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_7.bin", mem_w7, 175, 199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_8.bin", mem_w0, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_8.bin", mem_w1, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_8.bin", mem_w2, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_8.bin", mem_w3, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_8.bin", mem_w4, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_8.bin", mem_w5, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_8.bin", mem_w6, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_8.bin", mem_w7, 200, 224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_9.bin", mem_w0, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_9.bin", mem_w1, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_9.bin", mem_w2, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_9.bin", mem_w3, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_9.bin", mem_w4, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_9.bin", mem_w5, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_9.bin", mem_w6, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_9.bin", mem_w7, 225, 249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_10.bin", mem_w0, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_10.bin", mem_w1, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_10.bin", mem_w2, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_10.bin", mem_w3, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_10.bin", mem_w4, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_10.bin", mem_w5, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_10.bin", mem_w6, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_10.bin", mem_w7, 250, 274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_11.bin", mem_w0, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_11.bin", mem_w1, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_11.bin", mem_w2, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_11.bin", mem_w3, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_11.bin", mem_w4, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_11.bin", mem_w5, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_11.bin", mem_w6, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_11.bin", mem_w7, 275, 299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_12.bin", mem_w0, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_12.bin", mem_w1, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_12.bin", mem_w2, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_12.bin", mem_w3, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_12.bin", mem_w4, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_12.bin", mem_w5, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_12.bin", mem_w6, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_12.bin", mem_w7, 300, 324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_13.bin", mem_w0, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_13.bin", mem_w1, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_13.bin", mem_w2, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_13.bin", mem_w3, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_13.bin", mem_w4, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_13.bin", mem_w5, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_13.bin", mem_w6, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_13.bin", mem_w7, 325, 349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_14.bin", mem_w0, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_14.bin", mem_w1, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_14.bin", mem_w2, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_14.bin", mem_w3, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_14.bin", mem_w4, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_14.bin", mem_w5, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_14.bin", mem_w6, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_14.bin", mem_w7, 350, 374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_15.bin", mem_w0, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_15.bin", mem_w1, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_15.bin", mem_w2, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_15.bin", mem_w3, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_15.bin", mem_w4, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_15.bin", mem_w5, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_15.bin", mem_w6, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_15.bin", mem_w7, 375, 399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_16.bin", mem_w0, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_16.bin", mem_w1, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_16.bin", mem_w2, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_16.bin", mem_w3, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_16.bin", mem_w4, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_16.bin", mem_w5, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_16.bin", mem_w6, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_16.bin", mem_w7, 400, 424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_17.bin", mem_w0, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_17.bin", mem_w1, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_17.bin", mem_w2, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_17.bin", mem_w3, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_17.bin", mem_w4, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_17.bin", mem_w5, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_17.bin", mem_w6, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_17.bin", mem_w7, 425, 449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_18.bin", mem_w0, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_18.bin", mem_w1, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_18.bin", mem_w2, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_18.bin", mem_w3, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_18.bin", mem_w4, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_18.bin", mem_w5, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_18.bin", mem_w6, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_18.bin", mem_w7, 450, 474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data0_19.bin", mem_w0, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data1_19.bin", mem_w1, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data2_19.bin", mem_w2, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data3_19.bin", mem_w3, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data4_19.bin", mem_w4, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data5_19.bin", mem_w5, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data6_19.bin", mem_w6, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data7_19.bin", mem_w7, 475, 499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_0.bin", mem_w0, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_0.bin", mem_w1, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_0.bin", mem_w2, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_0.bin", mem_w3, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_0.bin", mem_w4, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_0.bin", mem_w5, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_0.bin", mem_w6, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_0.bin", mem_w7, 500, 524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_1.bin", mem_w0, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_1.bin", mem_w1, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_1.bin", mem_w2, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_1.bin", mem_w3, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_1.bin", mem_w4, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_1.bin", mem_w5, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_1.bin", mem_w6, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_1.bin", mem_w7, 525, 549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_2.bin", mem_w0, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_2.bin", mem_w1, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_2.bin", mem_w2, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_2.bin", mem_w3, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_2.bin", mem_w4, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_2.bin", mem_w5, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_2.bin", mem_w6, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_2.bin", mem_w7, 550, 574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_3.bin", mem_w0, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_3.bin", mem_w1, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_3.bin", mem_w2, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_3.bin", mem_w3, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_3.bin", mem_w4, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_3.bin", mem_w5, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_3.bin", mem_w6, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_3.bin", mem_w7, 575, 599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_4.bin", mem_w0, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_4.bin", mem_w1, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_4.bin", mem_w2, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_4.bin", mem_w3, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_4.bin", mem_w4, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_4.bin", mem_w5, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_4.bin", mem_w6, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_4.bin", mem_w7, 600, 624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_5.bin", mem_w0, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_5.bin", mem_w1, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_5.bin", mem_w2, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_5.bin", mem_w3, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_5.bin", mem_w4, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_5.bin", mem_w5, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_5.bin", mem_w6, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_5.bin", mem_w7, 625, 649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_6.bin", mem_w0, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_6.bin", mem_w1, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_6.bin", mem_w2, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_6.bin", mem_w3, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_6.bin", mem_w4, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_6.bin", mem_w5, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_6.bin", mem_w6, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_6.bin", mem_w7, 650, 674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_7.bin", mem_w0, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_7.bin", mem_w1, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_7.bin", mem_w2, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_7.bin", mem_w3, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_7.bin", mem_w4, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_7.bin", mem_w5, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_7.bin", mem_w6, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_7.bin", mem_w7, 675, 699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_8.bin", mem_w0, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_8.bin", mem_w1, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_8.bin", mem_w2, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_8.bin", mem_w3, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_8.bin", mem_w4, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_8.bin", mem_w5, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_8.bin", mem_w6, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_8.bin", mem_w7, 700, 724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_9.bin", mem_w0, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_9.bin", mem_w1, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_9.bin", mem_w2, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_9.bin", mem_w3, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_9.bin", mem_w4, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_9.bin", mem_w5, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_9.bin", mem_w6, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_9.bin", mem_w7, 725, 749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_10.bin", mem_w0, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_10.bin", mem_w1, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_10.bin", mem_w2, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_10.bin", mem_w3, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_10.bin", mem_w4, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_10.bin", mem_w5, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_10.bin", mem_w6, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_10.bin", mem_w7, 750, 774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_11.bin", mem_w0, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_11.bin", mem_w1, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_11.bin", mem_w2, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_11.bin", mem_w3, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_11.bin", mem_w4, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_11.bin", mem_w5, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_11.bin", mem_w6, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_11.bin", mem_w7, 775, 799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_12.bin", mem_w0, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_12.bin", mem_w1, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_12.bin", mem_w2, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_12.bin", mem_w3, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_12.bin", mem_w4, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_12.bin", mem_w5, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_12.bin", mem_w6, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_12.bin", mem_w7, 800, 824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_13.bin", mem_w0, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_13.bin", mem_w1, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_13.bin", mem_w2, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_13.bin", mem_w3, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_13.bin", mem_w4, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_13.bin", mem_w5, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_13.bin", mem_w6, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_13.bin", mem_w7, 825, 849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_14.bin", mem_w0, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_14.bin", mem_w1, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_14.bin", mem_w2, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_14.bin", mem_w3, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_14.bin", mem_w4, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_14.bin", mem_w5, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_14.bin", mem_w6, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_14.bin", mem_w7, 850, 874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_15.bin", mem_w0, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_15.bin", mem_w1, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_15.bin", mem_w2, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_15.bin", mem_w3, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_15.bin", mem_w4, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_15.bin", mem_w5, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_15.bin", mem_w6, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_15.bin", mem_w7, 875, 899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_16.bin", mem_w0, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_16.bin", mem_w1, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_16.bin", mem_w2, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_16.bin", mem_w3, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_16.bin", mem_w4, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_16.bin", mem_w5, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_16.bin", mem_w6, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_16.bin", mem_w7, 900, 924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_17.bin", mem_w0, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_17.bin", mem_w1, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_17.bin", mem_w2, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_17.bin", mem_w3, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_17.bin", mem_w4, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_17.bin", mem_w5, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_17.bin", mem_w6, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_17.bin", mem_w7, 925, 949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_18.bin", mem_w0, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_18.bin", mem_w1, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_18.bin", mem_w2, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_18.bin", mem_w3, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_18.bin", mem_w4, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_18.bin", mem_w5, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_18.bin", mem_w6, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_18.bin", mem_w7, 950, 974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data8_19.bin", mem_w0, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data9_19.bin", mem_w1, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data10_19.bin", mem_w2, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data11_19.bin", mem_w3, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data12_19.bin", mem_w4, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data13_19.bin", mem_w5, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data14_19.bin", mem_w6, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data15_19.bin", mem_w7, 975, 999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_0.bin", mem_w0, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_0.bin", mem_w1, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_0.bin", mem_w2, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_0.bin", mem_w3, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_0.bin", mem_w4, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_0.bin", mem_w5, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_0.bin", mem_w6, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_0.bin", mem_w7, 1000, 1024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_1.bin", mem_w0, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_1.bin", mem_w1, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_1.bin", mem_w2, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_1.bin", mem_w3, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_1.bin", mem_w4, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_1.bin", mem_w5, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_1.bin", mem_w6, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_1.bin", mem_w7, 1025, 1049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_2.bin", mem_w0, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_2.bin", mem_w1, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_2.bin", mem_w2, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_2.bin", mem_w3, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_2.bin", mem_w4, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_2.bin", mem_w5, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_2.bin", mem_w6, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_2.bin", mem_w7, 1050, 1074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_3.bin", mem_w0, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_3.bin", mem_w1, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_3.bin", mem_w2, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_3.bin", mem_w3, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_3.bin", mem_w4, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_3.bin", mem_w5, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_3.bin", mem_w6, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_3.bin", mem_w7, 1075, 1099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_4.bin", mem_w0, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_4.bin", mem_w1, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_4.bin", mem_w2, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_4.bin", mem_w3, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_4.bin", mem_w4, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_4.bin", mem_w5, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_4.bin", mem_w6, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_4.bin", mem_w7, 1100, 1124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_5.bin", mem_w0, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_5.bin", mem_w1, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_5.bin", mem_w2, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_5.bin", mem_w3, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_5.bin", mem_w4, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_5.bin", mem_w5, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_5.bin", mem_w6, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_5.bin", mem_w7, 1125, 1149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_6.bin", mem_w0, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_6.bin", mem_w1, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_6.bin", mem_w2, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_6.bin", mem_w3, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_6.bin", mem_w4, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_6.bin", mem_w5, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_6.bin", mem_w6, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_6.bin", mem_w7, 1150, 1174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_7.bin", mem_w0, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_7.bin", mem_w1, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_7.bin", mem_w2, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_7.bin", mem_w3, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_7.bin", mem_w4, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_7.bin", mem_w5, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_7.bin", mem_w6, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_7.bin", mem_w7, 1175, 1199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_8.bin", mem_w0, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_8.bin", mem_w1, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_8.bin", mem_w2, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_8.bin", mem_w3, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_8.bin", mem_w4, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_8.bin", mem_w5, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_8.bin", mem_w6, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_8.bin", mem_w7, 1200, 1224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_9.bin", mem_w0, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_9.bin", mem_w1, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_9.bin", mem_w2, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_9.bin", mem_w3, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_9.bin", mem_w4, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_9.bin", mem_w5, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_9.bin", mem_w6, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_9.bin", mem_w7, 1225, 1249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_10.bin", mem_w0, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_10.bin", mem_w1, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_10.bin", mem_w2, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_10.bin", mem_w3, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_10.bin", mem_w4, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_10.bin", mem_w5, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_10.bin", mem_w6, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_10.bin", mem_w7, 1250, 1274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_11.bin", mem_w0, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_11.bin", mem_w1, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_11.bin", mem_w2, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_11.bin", mem_w3, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_11.bin", mem_w4, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_11.bin", mem_w5, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_11.bin", mem_w6, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_11.bin", mem_w7, 1275, 1299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_12.bin", mem_w0, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_12.bin", mem_w1, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_12.bin", mem_w2, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_12.bin", mem_w3, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_12.bin", mem_w4, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_12.bin", mem_w5, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_12.bin", mem_w6, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_12.bin", mem_w7, 1300, 1324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_13.bin", mem_w0, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_13.bin", mem_w1, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_13.bin", mem_w2, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_13.bin", mem_w3, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_13.bin", mem_w4, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_13.bin", mem_w5, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_13.bin", mem_w6, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_13.bin", mem_w7, 1325, 1349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_14.bin", mem_w0, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_14.bin", mem_w1, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_14.bin", mem_w2, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_14.bin", mem_w3, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_14.bin", mem_w4, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_14.bin", mem_w5, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_14.bin", mem_w6, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_14.bin", mem_w7, 1350, 1374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_15.bin", mem_w0, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_15.bin", mem_w1, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_15.bin", mem_w2, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_15.bin", mem_w3, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_15.bin", mem_w4, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_15.bin", mem_w5, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_15.bin", mem_w6, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_15.bin", mem_w7, 1375, 1399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_16.bin", mem_w0, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_16.bin", mem_w1, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_16.bin", mem_w2, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_16.bin", mem_w3, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_16.bin", mem_w4, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_16.bin", mem_w5, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_16.bin", mem_w6, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_16.bin", mem_w7, 1400, 1424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_17.bin", mem_w0, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_17.bin", mem_w1, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_17.bin", mem_w2, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_17.bin", mem_w3, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_17.bin", mem_w4, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_17.bin", mem_w5, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_17.bin", mem_w6, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_17.bin", mem_w7, 1425, 1449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_18.bin", mem_w0, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_18.bin", mem_w1, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_18.bin", mem_w2, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_18.bin", mem_w3, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_18.bin", mem_w4, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_18.bin", mem_w5, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_18.bin", mem_w6, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_18.bin", mem_w7, 1450, 1474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data16_19.bin", mem_w0, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data17_19.bin", mem_w1, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data18_19.bin", mem_w2, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data19_19.bin", mem_w3, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data20_19.bin", mem_w4, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data21_19.bin", mem_w5, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data22_19.bin", mem_w6, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data23_19.bin", mem_w7, 1475, 1499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_0.bin", mem_w0, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_0.bin", mem_w1, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_0.bin", mem_w2, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_0.bin", mem_w3, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_0.bin", mem_w4, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_0.bin", mem_w5, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_0.bin", mem_w6, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_0.bin", mem_w7, 1500, 1524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_1.bin", mem_w0, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_1.bin", mem_w1, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_1.bin", mem_w2, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_1.bin", mem_w3, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_1.bin", mem_w4, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_1.bin", mem_w5, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_1.bin", mem_w6, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_1.bin", mem_w7, 1525, 1549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_2.bin", mem_w0, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_2.bin", mem_w1, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_2.bin", mem_w2, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_2.bin", mem_w3, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_2.bin", mem_w4, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_2.bin", mem_w5, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_2.bin", mem_w6, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_2.bin", mem_w7, 1550, 1574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_3.bin", mem_w0, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_3.bin", mem_w1, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_3.bin", mem_w2, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_3.bin", mem_w3, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_3.bin", mem_w4, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_3.bin", mem_w5, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_3.bin", mem_w6, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_3.bin", mem_w7, 1575, 1599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_4.bin", mem_w0, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_4.bin", mem_w1, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_4.bin", mem_w2, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_4.bin", mem_w3, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_4.bin", mem_w4, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_4.bin", mem_w5, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_4.bin", mem_w6, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_4.bin", mem_w7, 1600, 1624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_5.bin", mem_w0, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_5.bin", mem_w1, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_5.bin", mem_w2, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_5.bin", mem_w3, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_5.bin", mem_w4, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_5.bin", mem_w5, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_5.bin", mem_w6, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_5.bin", mem_w7, 1625, 1649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_6.bin", mem_w0, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_6.bin", mem_w1, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_6.bin", mem_w2, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_6.bin", mem_w3, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_6.bin", mem_w4, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_6.bin", mem_w5, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_6.bin", mem_w6, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_6.bin", mem_w7, 1650, 1674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_7.bin", mem_w0, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_7.bin", mem_w1, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_7.bin", mem_w2, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_7.bin", mem_w3, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_7.bin", mem_w4, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_7.bin", mem_w5, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_7.bin", mem_w6, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_7.bin", mem_w7, 1675, 1699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_8.bin", mem_w0, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_8.bin", mem_w1, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_8.bin", mem_w2, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_8.bin", mem_w3, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_8.bin", mem_w4, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_8.bin", mem_w5, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_8.bin", mem_w6, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_8.bin", mem_w7, 1700, 1724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_9.bin", mem_w0, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_9.bin", mem_w1, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_9.bin", mem_w2, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_9.bin", mem_w3, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_9.bin", mem_w4, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_9.bin", mem_w5, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_9.bin", mem_w6, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_9.bin", mem_w7, 1725, 1749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_10.bin", mem_w0, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_10.bin", mem_w1, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_10.bin", mem_w2, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_10.bin", mem_w3, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_10.bin", mem_w4, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_10.bin", mem_w5, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_10.bin", mem_w6, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_10.bin", mem_w7, 1750, 1774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_11.bin", mem_w0, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_11.bin", mem_w1, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_11.bin", mem_w2, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_11.bin", mem_w3, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_11.bin", mem_w4, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_11.bin", mem_w5, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_11.bin", mem_w6, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_11.bin", mem_w7, 1775, 1799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_12.bin", mem_w0, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_12.bin", mem_w1, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_12.bin", mem_w2, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_12.bin", mem_w3, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_12.bin", mem_w4, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_12.bin", mem_w5, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_12.bin", mem_w6, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_12.bin", mem_w7, 1800, 1824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_13.bin", mem_w0, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_13.bin", mem_w1, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_13.bin", mem_w2, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_13.bin", mem_w3, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_13.bin", mem_w4, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_13.bin", mem_w5, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_13.bin", mem_w6, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_13.bin", mem_w7, 1825, 1849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_14.bin", mem_w0, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_14.bin", mem_w1, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_14.bin", mem_w2, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_14.bin", mem_w3, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_14.bin", mem_w4, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_14.bin", mem_w5, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_14.bin", mem_w6, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_14.bin", mem_w7, 1850, 1874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_15.bin", mem_w0, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_15.bin", mem_w1, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_15.bin", mem_w2, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_15.bin", mem_w3, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_15.bin", mem_w4, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_15.bin", mem_w5, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_15.bin", mem_w6, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_15.bin", mem_w7, 1875, 1899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_16.bin", mem_w0, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_16.bin", mem_w1, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_16.bin", mem_w2, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_16.bin", mem_w3, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_16.bin", mem_w4, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_16.bin", mem_w5, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_16.bin", mem_w6, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_16.bin", mem_w7, 1900, 1924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_17.bin", mem_w0, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_17.bin", mem_w1, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_17.bin", mem_w2, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_17.bin", mem_w3, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_17.bin", mem_w4, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_17.bin", mem_w5, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_17.bin", mem_w6, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_17.bin", mem_w7, 1925, 1949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_18.bin", mem_w0, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_18.bin", mem_w1, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_18.bin", mem_w2, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_18.bin", mem_w3, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_18.bin", mem_w4, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_18.bin", mem_w5, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_18.bin", mem_w6, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_18.bin", mem_w7, 1950, 1974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data24_19.bin", mem_w0, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data25_19.bin", mem_w1, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data26_19.bin", mem_w2, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data27_19.bin", mem_w3, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data28_19.bin", mem_w4, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data29_19.bin", mem_w5, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data30_19.bin", mem_w6, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data31_19.bin", mem_w7, 1975, 1999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_0.bin", mem_w0, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_0.bin", mem_w1, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_0.bin", mem_w2, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_0.bin", mem_w3, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_0.bin", mem_w4, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_0.bin", mem_w5, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_0.bin", mem_w6, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_0.bin", mem_w7, 2000, 2024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_1.bin", mem_w0, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_1.bin", mem_w1, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_1.bin", mem_w2, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_1.bin", mem_w3, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_1.bin", mem_w4, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_1.bin", mem_w5, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_1.bin", mem_w6, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_1.bin", mem_w7, 2025, 2049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_2.bin", mem_w0, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_2.bin", mem_w1, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_2.bin", mem_w2, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_2.bin", mem_w3, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_2.bin", mem_w4, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_2.bin", mem_w5, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_2.bin", mem_w6, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_2.bin", mem_w7, 2050, 2074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_3.bin", mem_w0, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_3.bin", mem_w1, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_3.bin", mem_w2, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_3.bin", mem_w3, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_3.bin", mem_w4, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_3.bin", mem_w5, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_3.bin", mem_w6, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_3.bin", mem_w7, 2075, 2099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_4.bin", mem_w0, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_4.bin", mem_w1, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_4.bin", mem_w2, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_4.bin", mem_w3, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_4.bin", mem_w4, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_4.bin", mem_w5, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_4.bin", mem_w6, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_4.bin", mem_w7, 2100, 2124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_5.bin", mem_w0, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_5.bin", mem_w1, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_5.bin", mem_w2, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_5.bin", mem_w3, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_5.bin", mem_w4, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_5.bin", mem_w5, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_5.bin", mem_w6, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_5.bin", mem_w7, 2125, 2149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_6.bin", mem_w0, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_6.bin", mem_w1, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_6.bin", mem_w2, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_6.bin", mem_w3, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_6.bin", mem_w4, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_6.bin", mem_w5, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_6.bin", mem_w6, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_6.bin", mem_w7, 2150, 2174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_7.bin", mem_w0, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_7.bin", mem_w1, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_7.bin", mem_w2, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_7.bin", mem_w3, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_7.bin", mem_w4, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_7.bin", mem_w5, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_7.bin", mem_w6, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_7.bin", mem_w7, 2175, 2199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_8.bin", mem_w0, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_8.bin", mem_w1, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_8.bin", mem_w2, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_8.bin", mem_w3, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_8.bin", mem_w4, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_8.bin", mem_w5, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_8.bin", mem_w6, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_8.bin", mem_w7, 2200, 2224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_9.bin", mem_w0, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_9.bin", mem_w1, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_9.bin", mem_w2, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_9.bin", mem_w3, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_9.bin", mem_w4, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_9.bin", mem_w5, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_9.bin", mem_w6, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_9.bin", mem_w7, 2225, 2249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_10.bin", mem_w0, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_10.bin", mem_w1, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_10.bin", mem_w2, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_10.bin", mem_w3, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_10.bin", mem_w4, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_10.bin", mem_w5, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_10.bin", mem_w6, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_10.bin", mem_w7, 2250, 2274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_11.bin", mem_w0, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_11.bin", mem_w1, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_11.bin", mem_w2, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_11.bin", mem_w3, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_11.bin", mem_w4, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_11.bin", mem_w5, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_11.bin", mem_w6, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_11.bin", mem_w7, 2275, 2299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_12.bin", mem_w0, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_12.bin", mem_w1, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_12.bin", mem_w2, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_12.bin", mem_w3, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_12.bin", mem_w4, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_12.bin", mem_w5, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_12.bin", mem_w6, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_12.bin", mem_w7, 2300, 2324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_13.bin", mem_w0, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_13.bin", mem_w1, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_13.bin", mem_w2, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_13.bin", mem_w3, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_13.bin", mem_w4, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_13.bin", mem_w5, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_13.bin", mem_w6, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_13.bin", mem_w7, 2325, 2349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_14.bin", mem_w0, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_14.bin", mem_w1, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_14.bin", mem_w2, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_14.bin", mem_w3, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_14.bin", mem_w4, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_14.bin", mem_w5, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_14.bin", mem_w6, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_14.bin", mem_w7, 2350, 2374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_15.bin", mem_w0, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_15.bin", mem_w1, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_15.bin", mem_w2, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_15.bin", mem_w3, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_15.bin", mem_w4, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_15.bin", mem_w5, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_15.bin", mem_w6, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_15.bin", mem_w7, 2375, 2399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_16.bin", mem_w0, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_16.bin", mem_w1, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_16.bin", mem_w2, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_16.bin", mem_w3, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_16.bin", mem_w4, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_16.bin", mem_w5, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_16.bin", mem_w6, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_16.bin", mem_w7, 2400, 2424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_17.bin", mem_w0, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_17.bin", mem_w1, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_17.bin", mem_w2, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_17.bin", mem_w3, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_17.bin", mem_w4, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_17.bin", mem_w5, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_17.bin", mem_w6, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_17.bin", mem_w7, 2425, 2449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_18.bin", mem_w0, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_18.bin", mem_w1, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_18.bin", mem_w2, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_18.bin", mem_w3, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_18.bin", mem_w4, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_18.bin", mem_w5, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_18.bin", mem_w6, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_18.bin", mem_w7, 2450, 2474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data32_19.bin", mem_w0, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data33_19.bin", mem_w1, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data34_19.bin", mem_w2, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data35_19.bin", mem_w3, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data36_19.bin", mem_w4, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data37_19.bin", mem_w5, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data38_19.bin", mem_w6, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data39_19.bin", mem_w7, 2475, 2499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_0.bin", mem_w0, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_0.bin", mem_w1, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_0.bin", mem_w2, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_0.bin", mem_w3, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_0.bin", mem_w4, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_0.bin", mem_w5, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_0.bin", mem_w6, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_0.bin", mem_w7, 2500, 2524);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_1.bin", mem_w0, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_1.bin", mem_w1, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_1.bin", mem_w2, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_1.bin", mem_w3, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_1.bin", mem_w4, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_1.bin", mem_w5, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_1.bin", mem_w6, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_1.bin", mem_w7, 2525, 2549);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_2.bin", mem_w0, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_2.bin", mem_w1, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_2.bin", mem_w2, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_2.bin", mem_w3, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_2.bin", mem_w4, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_2.bin", mem_w5, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_2.bin", mem_w6, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_2.bin", mem_w7, 2550, 2574);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_3.bin", mem_w0, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_3.bin", mem_w1, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_3.bin", mem_w2, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_3.bin", mem_w3, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_3.bin", mem_w4, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_3.bin", mem_w5, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_3.bin", mem_w6, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_3.bin", mem_w7, 2575, 2599);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_4.bin", mem_w0, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_4.bin", mem_w1, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_4.bin", mem_w2, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_4.bin", mem_w3, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_4.bin", mem_w4, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_4.bin", mem_w5, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_4.bin", mem_w6, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_4.bin", mem_w7, 2600, 2624);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_5.bin", mem_w0, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_5.bin", mem_w1, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_5.bin", mem_w2, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_5.bin", mem_w3, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_5.bin", mem_w4, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_5.bin", mem_w5, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_5.bin", mem_w6, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_5.bin", mem_w7, 2625, 2649);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_6.bin", mem_w0, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_6.bin", mem_w1, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_6.bin", mem_w2, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_6.bin", mem_w3, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_6.bin", mem_w4, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_6.bin", mem_w5, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_6.bin", mem_w6, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_6.bin", mem_w7, 2650, 2674);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_7.bin", mem_w0, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_7.bin", mem_w1, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_7.bin", mem_w2, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_7.bin", mem_w3, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_7.bin", mem_w4, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_7.bin", mem_w5, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_7.bin", mem_w6, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_7.bin", mem_w7, 2675, 2699);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_8.bin", mem_w0, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_8.bin", mem_w1, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_8.bin", mem_w2, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_8.bin", mem_w3, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_8.bin", mem_w4, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_8.bin", mem_w5, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_8.bin", mem_w6, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_8.bin", mem_w7, 2700, 2724);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_9.bin", mem_w0, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_9.bin", mem_w1, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_9.bin", mem_w2, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_9.bin", mem_w3, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_9.bin", mem_w4, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_9.bin", mem_w5, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_9.bin", mem_w6, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_9.bin", mem_w7, 2725, 2749);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_10.bin", mem_w0, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_10.bin", mem_w1, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_10.bin", mem_w2, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_10.bin", mem_w3, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_10.bin", mem_w4, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_10.bin", mem_w5, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_10.bin", mem_w6, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_10.bin", mem_w7, 2750, 2774);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_11.bin", mem_w0, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_11.bin", mem_w1, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_11.bin", mem_w2, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_11.bin", mem_w3, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_11.bin", mem_w4, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_11.bin", mem_w5, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_11.bin", mem_w6, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_11.bin", mem_w7, 2775, 2799);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_12.bin", mem_w0, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_12.bin", mem_w1, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_12.bin", mem_w2, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_12.bin", mem_w3, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_12.bin", mem_w4, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_12.bin", mem_w5, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_12.bin", mem_w6, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_12.bin", mem_w7, 2800, 2824);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_13.bin", mem_w0, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_13.bin", mem_w1, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_13.bin", mem_w2, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_13.bin", mem_w3, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_13.bin", mem_w4, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_13.bin", mem_w5, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_13.bin", mem_w6, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_13.bin", mem_w7, 2825, 2849);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_14.bin", mem_w0, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_14.bin", mem_w1, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_14.bin", mem_w2, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_14.bin", mem_w3, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_14.bin", mem_w4, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_14.bin", mem_w5, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_14.bin", mem_w6, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_14.bin", mem_w7, 2850, 2874);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_15.bin", mem_w0, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_15.bin", mem_w1, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_15.bin", mem_w2, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_15.bin", mem_w3, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_15.bin", mem_w4, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_15.bin", mem_w5, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_15.bin", mem_w6, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_15.bin", mem_w7, 2875, 2899);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_16.bin", mem_w0, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_16.bin", mem_w1, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_16.bin", mem_w2, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_16.bin", mem_w3, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_16.bin", mem_w4, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_16.bin", mem_w5, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_16.bin", mem_w6, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_16.bin", mem_w7, 2900, 2924);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_17.bin", mem_w0, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_17.bin", mem_w1, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_17.bin", mem_w2, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_17.bin", mem_w3, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_17.bin", mem_w4, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_17.bin", mem_w5, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_17.bin", mem_w6, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_17.bin", mem_w7, 2925, 2949);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_18.bin", mem_w0, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_18.bin", mem_w1, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_18.bin", mem_w2, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_18.bin", mem_w3, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_18.bin", mem_w4, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_18.bin", mem_w5, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_18.bin", mem_w6, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_18.bin", mem_w7, 2950, 2974);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data40_19.bin", mem_w0, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data41_19.bin", mem_w1, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data42_19.bin", mem_w2, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data43_19.bin", mem_w3, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data44_19.bin", mem_w4, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data45_19.bin", mem_w5, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data46_19.bin", mem_w6, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data47_19.bin", mem_w7, 2975, 2999);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_0.bin", mem_w0, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_0.bin", mem_w1, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3000, 3024);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_1.bin", mem_w0, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_1.bin", mem_w1, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3025, 3049);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_2.bin", mem_w0, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_2.bin", mem_w1, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3050, 3074);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_3.bin", mem_w0, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_3.bin", mem_w1, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3075, 3099);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_4.bin", mem_w0, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_4.bin", mem_w1, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3100, 3124);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_5.bin", mem_w0, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_5.bin", mem_w1, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3125, 3149);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_6.bin", mem_w0, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_6.bin", mem_w1, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3150, 3174);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_7.bin", mem_w0, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_7.bin", mem_w1, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3175, 3199);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_8.bin", mem_w0, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_8.bin", mem_w1, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3200, 3224);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_9.bin", mem_w0, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_9.bin", mem_w1, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3225, 3249);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_10.bin", mem_w0, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_10.bin", mem_w1, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3250, 3274);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_11.bin", mem_w0, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_11.bin", mem_w1, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3275, 3299);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_12.bin", mem_w0, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_12.bin", mem_w1, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3300, 3324);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_13.bin", mem_w0, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_13.bin", mem_w1, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3325, 3349);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_14.bin", mem_w0, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_14.bin", mem_w1, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3350, 3374);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_15.bin", mem_w0, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_15.bin", mem_w1, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3375, 3399);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_16.bin", mem_w0, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_16.bin", mem_w1, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3400, 3424);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_17.bin", mem_w0, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_17.bin", mem_w1, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3425, 3449);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_18.bin", mem_w0, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_18.bin", mem_w1, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3450, 3474);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data48_19.bin", mem_w0, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/data49_19.bin", mem_w1, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w2, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w3, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w4, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w5, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w6, 3475, 3499);
      $readmemb("/home/work/takau/bhewtek/data/mnist/lenet/bwb_2/null.bin", mem_w7, 3475, 3499);
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
      fd = $fopen("test_top.dat", "w");
      $display("");
      $display("read_output");
      $display("====================");
      out_size = 800;
      o_unit = 16;
      for (i=0; i<out_size; i=i+1)
      begin
        o_offset = i % o_unit;
        o_index  = i / o_unit;
        if (o_offset == 0)
          output_re = o_index % 8 + 1;
        output_addr = o_offset + o_unit*(o_index/8);
        #(STEP*2);
        $display("%d : %d", i, read_output);
        $fdisplay(fd, "%4d", read_output);
      end
      output_re = 0;
      $fclose(fd);
    end
  endtask

  task valid_memin;
    integer i;
    integer in_size;
    begin
      in_size = 2880;
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

endmodule
