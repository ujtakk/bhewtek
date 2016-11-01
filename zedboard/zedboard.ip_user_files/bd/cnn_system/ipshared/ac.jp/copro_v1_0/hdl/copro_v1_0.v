
`timescale 1 ns / 1 ps

module copro_v1_0 #
  (
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line


    // Parameters of Axi Slave Bus Interface s_axi
    parameter integer C_s_axi_DATA_WIDTH  = 32,
    parameter integer C_s_axi_ADDR_WIDTH  = 10
  )
  (
    // Users to add ports here

    // User ports ends
    // Do not modify the ports beyond this line


    // Ports of Axi Slave Bus Interface s_axi
    input wire  s_axi_aclk,
    input wire  s_axi_aresetn,
    input wire [C_s_axi_ADDR_WIDTH-1 : 0] s_axi_awaddr,
    input wire [2 : 0] s_axi_awprot,
    input wire  s_axi_awvalid,
    output wire  s_axi_awready,
    input wire [C_s_axi_DATA_WIDTH-1 : 0] s_axi_wdata,
    input wire [(C_s_axi_DATA_WIDTH/8)-1 : 0] s_axi_wstrb,
    input wire  s_axi_wvalid,
    output wire  s_axi_wready,
    output wire [1 : 0] s_axi_bresp,
    output wire  s_axi_bvalid,
    input wire  s_axi_bready,
    input wire [C_s_axi_ADDR_WIDTH-1 : 0] s_axi_araddr,
    input wire [2 : 0] s_axi_arprot,
    input wire  s_axi_arvalid,
    output wire  s_axi_arready,
    output wire [C_s_axi_DATA_WIDTH-1 : 0] s_axi_rdata,
    output wire [1 : 0] s_axi_rresp,
    output wire  s_axi_rvalid,
    input wire  s_axi_rready
  );
// Instantiation of Axi Bus Interface s_axi
  wire [C_s_axi_DATA_WIDTH-1:0]	port0;
  wire [C_s_axi_DATA_WIDTH-1:0]	port1;
  wire [C_s_axi_DATA_WIDTH-1:0]	port2;
  wire [C_s_axi_DATA_WIDTH-1:0]	port3;
  wire [C_s_axi_DATA_WIDTH-1:0]	port4;
  wire [C_s_axi_DATA_WIDTH-1:0]	port5;
  wire [C_s_axi_DATA_WIDTH-1:0]	port6;
  wire [C_s_axi_DATA_WIDTH-1:0]	port7;
  wire [C_s_axi_DATA_WIDTH-1:0]	port8;
  wire [C_s_axi_DATA_WIDTH-1:0]	port9;
  wire [C_s_axi_DATA_WIDTH-1:0]	port10;
  wire [C_s_axi_DATA_WIDTH-1:0]	port11;
  wire [C_s_axi_DATA_WIDTH-1:0]	port12;
  wire [C_s_axi_DATA_WIDTH-1:0]	port13;
  wire [C_s_axi_DATA_WIDTH-1:0]	port14;
  wire [C_s_axi_DATA_WIDTH-1:0]	port15;
  wire [C_s_axi_DATA_WIDTH-1:0]	port16;
  wire [C_s_axi_DATA_WIDTH-1:0]	port17;
  wire [C_s_axi_DATA_WIDTH-1:0]	port18;
  wire [C_s_axi_DATA_WIDTH-1:0]	port19;
  wire [C_s_axi_DATA_WIDTH-1:0]	port20;
  wire [C_s_axi_DATA_WIDTH-1:0]	port21;
  wire [C_s_axi_DATA_WIDTH-1:0]	port22;
  wire [C_s_axi_DATA_WIDTH-1:0]	port23;
  wire [C_s_axi_DATA_WIDTH-1:0]	port24;
  wire [C_s_axi_DATA_WIDTH-1:0]	port25;
  wire [C_s_axi_DATA_WIDTH-1:0]	port26;
  wire [C_s_axi_DATA_WIDTH-1:0]	port27;
  wire [C_s_axi_DATA_WIDTH-1:0]	port28;
  wire [C_s_axi_DATA_WIDTH-1:0]	port29;
  wire [C_s_axi_DATA_WIDTH-1:0]	port30;
  wire [C_s_axi_DATA_WIDTH-1:0]	port31;
  wire [C_s_axi_DATA_WIDTH-1:0]	port32;
  wire [C_s_axi_DATA_WIDTH-1:0]	port33;
  wire [C_s_axi_DATA_WIDTH-1:0]	port34;
  wire [C_s_axi_DATA_WIDTH-1:0]	port35;
  wire [C_s_axi_DATA_WIDTH-1:0]	port36;
  wire [C_s_axi_DATA_WIDTH-1:0]	port37;
  wire [C_s_axi_DATA_WIDTH-1:0]	port38;
  wire [C_s_axi_DATA_WIDTH-1:0]	port39;
  wire [C_s_axi_DATA_WIDTH-1:0]	port40;
  wire [C_s_axi_DATA_WIDTH-1:0]	port41;
  wire [C_s_axi_DATA_WIDTH-1:0]	port42;
  wire [C_s_axi_DATA_WIDTH-1:0]	port43;
  wire [C_s_axi_DATA_WIDTH-1:0]	port44;
  wire [C_s_axi_DATA_WIDTH-1:0]	port45;
  wire [C_s_axi_DATA_WIDTH-1:0]	port46;
  wire [C_s_axi_DATA_WIDTH-1:0]	port47;
  wire [C_s_axi_DATA_WIDTH-1:0]	port48;
  wire [C_s_axi_DATA_WIDTH-1:0]	port49;
  wire [C_s_axi_DATA_WIDTH-1:0]	port50;
  wire [C_s_axi_DATA_WIDTH-1:0]	port51;
  wire [C_s_axi_DATA_WIDTH-1:0]	port52;
  wire [C_s_axi_DATA_WIDTH-1:0]	port53;
  wire [C_s_axi_DATA_WIDTH-1:0]	port54;
  wire [C_s_axi_DATA_WIDTH-1:0]	port55;
  wire [C_s_axi_DATA_WIDTH-1:0]	port56;
  wire [C_s_axi_DATA_WIDTH-1:0]	port57;
  wire [C_s_axi_DATA_WIDTH-1:0]	port58;
  wire [C_s_axi_DATA_WIDTH-1:0]	port59;
  wire [C_s_axi_DATA_WIDTH-1:0]	port60;
  wire [C_s_axi_DATA_WIDTH-1:0]	port61;
  wire [C_s_axi_DATA_WIDTH-1:0]	port62;
  wire [C_s_axi_DATA_WIDTH-1:0]	port63;
  wire [C_s_axi_DATA_WIDTH-1:0]	port64;
  wire [C_s_axi_DATA_WIDTH-1:0]	port65;
  wire [C_s_axi_DATA_WIDTH-1:0]	port66;
  wire [C_s_axi_DATA_WIDTH-1:0]	port67;
  wire [C_s_axi_DATA_WIDTH-1:0]	port68;
  wire [C_s_axi_DATA_WIDTH-1:0]	port69;
  wire [C_s_axi_DATA_WIDTH-1:0]	port70;
  wire [C_s_axi_DATA_WIDTH-1:0]	port71;
  wire [C_s_axi_DATA_WIDTH-1:0]	port72;
  wire [C_s_axi_DATA_WIDTH-1:0]	port73;
  wire [C_s_axi_DATA_WIDTH-1:0]	port74;
  wire [C_s_axi_DATA_WIDTH-1:0]	port75;
  wire [C_s_axi_DATA_WIDTH-1:0]	port76;
  wire [C_s_axi_DATA_WIDTH-1:0]	port77;
  wire [C_s_axi_DATA_WIDTH-1:0]	port78;
  wire [C_s_axi_DATA_WIDTH-1:0]	port79;
  wire [C_s_axi_DATA_WIDTH-1:0]	port80;
  wire [C_s_axi_DATA_WIDTH-1:0]	port81;
  wire [C_s_axi_DATA_WIDTH-1:0]	port82;
  wire [C_s_axi_DATA_WIDTH-1:0]	port83;
  wire [C_s_axi_DATA_WIDTH-1:0]	port84;
  wire [C_s_axi_DATA_WIDTH-1:0]	port85;
  wire [C_s_axi_DATA_WIDTH-1:0]	port86;
  wire [C_s_axi_DATA_WIDTH-1:0]	port87;
  wire [C_s_axi_DATA_WIDTH-1:0]	port88;
  wire [C_s_axi_DATA_WIDTH-1:0]	port89;
  wire [C_s_axi_DATA_WIDTH-1:0]	port90;
  wire [C_s_axi_DATA_WIDTH-1:0]	port91;
  wire [C_s_axi_DATA_WIDTH-1:0]	port92;
  wire [C_s_axi_DATA_WIDTH-1:0]	port93;
  wire [C_s_axi_DATA_WIDTH-1:0]	port94;
  wire [C_s_axi_DATA_WIDTH-1:0]	port95;
  wire [C_s_axi_DATA_WIDTH-1:0]	port96;
  wire [C_s_axi_DATA_WIDTH-1:0]	port97;
  wire [C_s_axi_DATA_WIDTH-1:0]	port98;
  wire [C_s_axi_DATA_WIDTH-1:0]	port99;
  wire [C_s_axi_DATA_WIDTH-1:0]	port100;
  wire [C_s_axi_DATA_WIDTH-1:0]	port101;
  wire [C_s_axi_DATA_WIDTH-1:0]	port102;
  wire [C_s_axi_DATA_WIDTH-1:0]	port103;
  wire [C_s_axi_DATA_WIDTH-1:0]	port104;
  wire [C_s_axi_DATA_WIDTH-1:0]	port105;
  wire [C_s_axi_DATA_WIDTH-1:0]	port106;
  wire [C_s_axi_DATA_WIDTH-1:0]	port107;
  wire [C_s_axi_DATA_WIDTH-1:0]	port108;
  wire [C_s_axi_DATA_WIDTH-1:0]	port109;
  wire [C_s_axi_DATA_WIDTH-1:0]	port110;
  wire [C_s_axi_DATA_WIDTH-1:0]	port111;
  wire [C_s_axi_DATA_WIDTH-1:0]	port112;
  wire [C_s_axi_DATA_WIDTH-1:0]	port113;
  wire [C_s_axi_DATA_WIDTH-1:0]	port114;
  wire [C_s_axi_DATA_WIDTH-1:0]	port115;
  wire [C_s_axi_DATA_WIDTH-1:0]	port116;
  wire [C_s_axi_DATA_WIDTH-1:0]	port117;
  wire [C_s_axi_DATA_WIDTH-1:0]	port118;
  wire [C_s_axi_DATA_WIDTH-1:0]	port119;
  wire [C_s_axi_DATA_WIDTH-1:0]	port120;
  wire [C_s_axi_DATA_WIDTH-1:0]	port121;
  wire [C_s_axi_DATA_WIDTH-1:0]	port122;
  wire [C_s_axi_DATA_WIDTH-1:0]	port123;
  wire [C_s_axi_DATA_WIDTH-1:0]	port124;
  wire [C_s_axi_DATA_WIDTH-1:0]	port125;
  wire [C_s_axi_DATA_WIDTH-1:0]	port126;
  wire [C_s_axi_DATA_WIDTH-1:0]	port127;
  wire [C_s_axi_DATA_WIDTH-1:0]	port128;
  wire [C_s_axi_DATA_WIDTH-1:0]	port129;
  wire [C_s_axi_DATA_WIDTH-1:0]	port130;
  wire [C_s_axi_DATA_WIDTH-1:0]	port131;
  wire [C_s_axi_DATA_WIDTH-1:0]	port132;
  wire [C_s_axi_DATA_WIDTH-1:0]	port133;
  wire [C_s_axi_DATA_WIDTH-1:0]	port134;
  wire [C_s_axi_DATA_WIDTH-1:0]	port135;
  wire [C_s_axi_DATA_WIDTH-1:0]	port136;
  wire [C_s_axi_DATA_WIDTH-1:0]	port137;
  wire [C_s_axi_DATA_WIDTH-1:0]	port138;
  wire [C_s_axi_DATA_WIDTH-1:0]	port139;
  wire [C_s_axi_DATA_WIDTH-1:0]	port140;
  wire [C_s_axi_DATA_WIDTH-1:0]	port141;
  wire [C_s_axi_DATA_WIDTH-1:0]	port142;
  wire [C_s_axi_DATA_WIDTH-1:0]	port143;
  wire [C_s_axi_DATA_WIDTH-1:0]	port144;
  wire [C_s_axi_DATA_WIDTH-1:0]	port145;
  wire [C_s_axi_DATA_WIDTH-1:0]	port146;
  wire [C_s_axi_DATA_WIDTH-1:0]	port147;
  wire [C_s_axi_DATA_WIDTH-1:0]	port148;
  wire [C_s_axi_DATA_WIDTH-1:0]	port149;
  wire [C_s_axi_DATA_WIDTH-1:0]	port150;
  wire [C_s_axi_DATA_WIDTH-1:0]	port151;
  wire [C_s_axi_DATA_WIDTH-1:0]	port152;
  wire [C_s_axi_DATA_WIDTH-1:0]	port153;
  wire [C_s_axi_DATA_WIDTH-1:0]	port154;
  wire [C_s_axi_DATA_WIDTH-1:0]	port155;
  wire [C_s_axi_DATA_WIDTH-1:0]	port156;
  wire [C_s_axi_DATA_WIDTH-1:0]	port157;
  wire [C_s_axi_DATA_WIDTH-1:0]	port158;
  wire [C_s_axi_DATA_WIDTH-1:0]	port159;
  wire [C_s_axi_DATA_WIDTH-1:0]	port160;
  wire [C_s_axi_DATA_WIDTH-1:0]	port161;
  wire [C_s_axi_DATA_WIDTH-1:0]	port162;
  wire [C_s_axi_DATA_WIDTH-1:0]	port163;
  wire [C_s_axi_DATA_WIDTH-1:0]	port164;
  wire [C_s_axi_DATA_WIDTH-1:0]	port165;
  wire [C_s_axi_DATA_WIDTH-1:0]	port166;
  wire [C_s_axi_DATA_WIDTH-1:0]	port167;
  wire [C_s_axi_DATA_WIDTH-1:0]	port168;
  wire [C_s_axi_DATA_WIDTH-1:0]	port169;
  wire [C_s_axi_DATA_WIDTH-1:0]	port170;
  wire [C_s_axi_DATA_WIDTH-1:0]	port171;
  wire [C_s_axi_DATA_WIDTH-1:0]	port172;
  wire [C_s_axi_DATA_WIDTH-1:0]	port173;
  wire [C_s_axi_DATA_WIDTH-1:0]	port174;
  wire [C_s_axi_DATA_WIDTH-1:0]	port175;
  wire [C_s_axi_DATA_WIDTH-1:0]	port176;
  wire [C_s_axi_DATA_WIDTH-1:0]	port177;
  wire [C_s_axi_DATA_WIDTH-1:0]	port178;
  wire [C_s_axi_DATA_WIDTH-1:0]	port179;
  wire [C_s_axi_DATA_WIDTH-1:0]	port180;
  wire [C_s_axi_DATA_WIDTH-1:0]	port181;
  wire [C_s_axi_DATA_WIDTH-1:0]	port182;
  wire [C_s_axi_DATA_WIDTH-1:0]	port183;
  wire [C_s_axi_DATA_WIDTH-1:0]	port184;
  wire [C_s_axi_DATA_WIDTH-1:0]	port185;
  wire [C_s_axi_DATA_WIDTH-1:0]	port186;
  wire [C_s_axi_DATA_WIDTH-1:0]	port187;
  wire [C_s_axi_DATA_WIDTH-1:0]	port188;
  wire [C_s_axi_DATA_WIDTH-1:0]	port189;
  wire [C_s_axi_DATA_WIDTH-1:0]	port190;
  wire [C_s_axi_DATA_WIDTH-1:0]	port191;
  wire [C_s_axi_DATA_WIDTH-1:0]	port192;
  wire [C_s_axi_DATA_WIDTH-1:0]	port193;
  wire [C_s_axi_DATA_WIDTH-1:0]	port194;
  wire [C_s_axi_DATA_WIDTH-1:0]	port195;
  wire [C_s_axi_DATA_WIDTH-1:0]	port196;
  wire [C_s_axi_DATA_WIDTH-1:0]	port197;
  wire [C_s_axi_DATA_WIDTH-1:0]	port198;
  wire [C_s_axi_DATA_WIDTH-1:0]	port199;
  wire [C_s_axi_DATA_WIDTH-1:0]	port200;
  wire [C_s_axi_DATA_WIDTH-1:0]	port201;
  wire [C_s_axi_DATA_WIDTH-1:0]	port202;
  wire [C_s_axi_DATA_WIDTH-1:0]	port203;
  wire [C_s_axi_DATA_WIDTH-1:0]	port204;
  wire [C_s_axi_DATA_WIDTH-1:0]	port205;
  wire [C_s_axi_DATA_WIDTH-1:0]	port206;
  wire [C_s_axi_DATA_WIDTH-1:0]	port207;
  wire [C_s_axi_DATA_WIDTH-1:0]	port208;
  wire [C_s_axi_DATA_WIDTH-1:0]	port209;
  wire [C_s_axi_DATA_WIDTH-1:0]	port210;
  wire [C_s_axi_DATA_WIDTH-1:0]	port211;
  wire [C_s_axi_DATA_WIDTH-1:0]	port212;
  wire [C_s_axi_DATA_WIDTH-1:0]	port213;
  wire [C_s_axi_DATA_WIDTH-1:0]	port214;
  wire [C_s_axi_DATA_WIDTH-1:0]	port215;
  wire [C_s_axi_DATA_WIDTH-1:0]	port216;
  wire [C_s_axi_DATA_WIDTH-1:0]	port217;
  wire [C_s_axi_DATA_WIDTH-1:0]	port218;
  wire [C_s_axi_DATA_WIDTH-1:0]	port219;
  wire [C_s_axi_DATA_WIDTH-1:0]	port220;
  wire [C_s_axi_DATA_WIDTH-1:0]	port221;
  wire [C_s_axi_DATA_WIDTH-1:0]	port222;
  wire [C_s_axi_DATA_WIDTH-1:0]	port223;
  wire [C_s_axi_DATA_WIDTH-1:0]	port224;
  wire [C_s_axi_DATA_WIDTH-1:0]	port225;
  wire [C_s_axi_DATA_WIDTH-1:0]	port226;
  wire [C_s_axi_DATA_WIDTH-1:0]	port227;
  wire [C_s_axi_DATA_WIDTH-1:0]	port228;
  wire [C_s_axi_DATA_WIDTH-1:0]	port229;
  wire [C_s_axi_DATA_WIDTH-1:0]	port230;
  wire [C_s_axi_DATA_WIDTH-1:0]	port231;
  wire [C_s_axi_DATA_WIDTH-1:0]	port232;
  wire [C_s_axi_DATA_WIDTH-1:0]	port233;
  wire [C_s_axi_DATA_WIDTH-1:0]	port234;
  wire [C_s_axi_DATA_WIDTH-1:0]	port235;
  wire [C_s_axi_DATA_WIDTH-1:0]	port236;
  wire [C_s_axi_DATA_WIDTH-1:0]	port237;
  wire [C_s_axi_DATA_WIDTH-1:0]	port238;
  wire [C_s_axi_DATA_WIDTH-1:0]	port239;
  wire [C_s_axi_DATA_WIDTH-1:0]	port240;
  wire [C_s_axi_DATA_WIDTH-1:0]	port241;
  wire [C_s_axi_DATA_WIDTH-1:0]	port242;
  wire [C_s_axi_DATA_WIDTH-1:0]	port243;
  wire [C_s_axi_DATA_WIDTH-1:0]	port244;
  wire [C_s_axi_DATA_WIDTH-1:0]	port245;
  wire [C_s_axi_DATA_WIDTH-1:0]	port246;
  wire [C_s_axi_DATA_WIDTH-1:0]	port247;
  wire [C_s_axi_DATA_WIDTH-1:0]	port248;
  wire [C_s_axi_DATA_WIDTH-1:0]	port249;
  wire [C_s_axi_DATA_WIDTH-1:0]	port250;
  wire [C_s_axi_DATA_WIDTH-1:0]	port251;
  wire [C_s_axi_DATA_WIDTH-1:0]	port252;
  wire [C_s_axi_DATA_WIDTH-1:0]	port253;
  wire [C_s_axi_DATA_WIDTH-1:0]	port254;
  wire [C_s_axi_DATA_WIDTH-1:0]	port255;

  copro_v1_0_s_axi # (
    .C_S_AXI_DATA_WIDTH(C_s_axi_DATA_WIDTH),
    .C_S_AXI_ADDR_WIDTH(C_s_axi_ADDR_WIDTH)
  ) copro_v1_0_s_axi_inst (
    .port0(port0),
    .port1(port1),
    .port2(port2),
    .port3(port3),
    .port4(port4),
    .port5(port5),
    .port6(port6),
    .port7(port7),
    .port8(port8),
    .port9(port9),
    .port10(port10),
    .port11(port11),
    .port12(port12),
    .port13(port13),
    .port14(port14),
    .port15(port15),
    .port16(port16),
    .port17(port17),
    .port18(port18),
    .port19(port19),
    .port20(port20),
    .port21(port21),
    .port22(port22),
    .port23(port23),
    .port24(port24),
    .port25(port25),
    .port26(port26),
    .port27(port27),
    .port28(port28),
    .port29(port29),
    .port30(port30),
    .port31(port31),
    .port32(port32),
    .port33(port33),
    .port34(port34),
    .port35(port35),
    .port36(port36),
    .port37(port37),
    .port38(port38),
    .port39(port39),
    .port40(port40),
    .port41(port41),
    .port42(port42),
    .port43(port43),
    .port44(port44),
    .port45(port45),
    .port46(port46),
    .port47(port47),
    .port48(port48),
    .port49(port49),
    .port50(port50),
    .port51(port51),
    .port52(port52),
    .port53(port53),
    .port54(port54),
    .port55(port55),
    .port56(port56),
    .port57(port57),
    .port58(port58),
    .port59(port59),
    .port60(port60),
    .port61(port61),
    .port62(port62),
    .port63(port63),
    .port64(port64),
    .port65(port65),
    .port66(port66),
    .port67(port67),
    .port68(port68),
    .port69(port69),
    .port70(port70),
    .port71(port71),
    .port72(port72),
    .port73(port73),
    .port74(port74),
    .port75(port75),
    .port76(port76),
    .port77(port77),
    .port78(port78),
    .port79(port79),
    .port80(port80),
    .port81(port81),
    .port82(port82),
    .port83(port83),
    .port84(port84),
    .port85(port85),
    .port86(port86),
    .port87(port87),
    .port88(port88),
    .port89(port89),
    .port90(port90),
    .port91(port91),
    .port92(port92),
    .port93(port93),
    .port94(port94),
    .port95(port95),
    .port96(port96),
    .port97(port97),
    .port98(port98),
    .port99(port99),
    .port100(port100),
    .port101(port101),
    .port102(port102),
    .port103(port103),
    .port104(port104),
    .port105(port105),
    .port106(port106),
    .port107(port107),
    .port108(port108),
    .port109(port109),
    .port110(port110),
    .port111(port111),
    .port112(port112),
    .port113(port113),
    .port114(port114),
    .port115(port115),
    .port116(port116),
    .port117(port117),
    .port118(port118),
    .port119(port119),
    .port120(port120),
    .port121(port121),
    .port122(port122),
    .port123(port123),
    .port124(port124),
    .port125(port125),
    .port126(port126),
    .port127(port127),
    .port128(port128),
    .port129(port129),
    .port130(port130),
    .port131(port131),
    .port132(port132),
    .port133(port133),
    .port134(port134),
    .port135(port135),
    .port136(port136),
    .port137(port137),
    .port138(port138),
    .port139(port139),
    .port140(port140),
    .port141(port141),
    .port142(port142),
    .port143(port143),
    .port144(port144),
    .port145(port145),
    .port146(port146),
    .port147(port147),
    .port148(port148),
    .port149(port149),
    .port150(port150),
    .port151(port151),
    .port152(port152),
    .port153(port153),
    .port154(port154),
    .port155(port155),
    .port156(port156),
    .port157(port157),
    .port158(port158),
    .port159(port159),
    .port160(port160),
    .port161(port161),
    .port162(port162),
    .port163(port163),
    .port164(port164),
    .port165(port165),
    .port166(port166),
    .port167(port167),
    .port168(port168),
    .port169(port169),
    .port170(port170),
    .port171(port171),
    .port172(port172),
    .port173(port173),
    .port174(port174),
    .port175(port175),
    .port176(port176),
    .port177(port177),
    .port178(port178),
    .port179(port179),
    .port180(port180),
    .port181(port181),
    .port182(port182),
    .port183(port183),
    .port184(port184),
    .port185(port185),
    .port186(port186),
    .port187(port187),
    .port188(port188),
    .port189(port189),
    .port190(port190),
    .port191(port191),
    .port192(port192),
    .port193(port193),
    .port194(port194),
    .port195(port195),
    .port196(port196),
    .port197(port197),
    .port198(port198),
    .port199(port199),
    .port200(port200),
    .port201(port201),
    .port202(port202),
    .port203(port203),
    .port204(port204),
    .port205(port205),
    .port206(port206),
    .port207(port207),
    .port208(port208),
    .port209(port209),
    .port210(port210),
    .port211(port211),
    .port212(port212),
    .port213(port213),
    .port214(port214),
    .port215(port215),
    .port216(port216),
    .port217(port217),
    .port218(port218),
    .port219(port219),
    .port220(port220),
    .port221(port221),
    .port222(port222),
    .port223(port223),
    .port224(port224),
    .port225(port225),
    .port226(port226),
    .port227(port227),
    .port228(port228),
    .port229(port229),
    .port230(port230),
    .port231(port231),
    .port232(port232),
    .port233(port233),
    .port234(port234),
    .port235(port235),
    .port236(port236),
    .port237(port237),
    .port238(port238),
    .port239(port239),
    .port240(port240),
    .port241(port241),
    .port242(port242),
    .port243(port243),
    .port244(port244),
    .port245(port245),
    .port246(port246),
    .port247(port247),
    .port248(port248),
    .port249(port249),
    .port250(port250),
    .port251(port251),
    .port252(port252),
    .port253(port253),
    .port254(port254),
    .port255(port255),
    .S_AXI_ACLK(s_axi_aclk),
    .S_AXI_ARESETN(s_axi_aresetn),
    .S_AXI_AWADDR(s_axi_awaddr),
    .S_AXI_AWPROT(s_axi_awprot),
    .S_AXI_AWVALID(s_axi_awvalid),
    .S_AXI_AWREADY(s_axi_awready),
    .S_AXI_WDATA(s_axi_wdata),
    .S_AXI_WSTRB(s_axi_wstrb),
    .S_AXI_WVALID(s_axi_wvalid),
    .S_AXI_WREADY(s_axi_wready),
    .S_AXI_BRESP(s_axi_bresp),
    .S_AXI_BVALID(s_axi_bvalid),
    .S_AXI_BREADY(s_axi_bready),
    .S_AXI_ARADDR(s_axi_araddr),
    .S_AXI_ARPROT(s_axi_arprot),
    .S_AXI_ARVALID(s_axi_arvalid),
    .S_AXI_ARREADY(s_axi_arready),
    .S_AXI_RDATA(s_axi_rdata),
    .S_AXI_RRESP(s_axi_rresp),
    .S_AXI_RVALID(s_axi_rvalid),
    .S_AXI_RREADY(s_axi_rready)
  );

  // Add user logic here

`include "parameters.vh"

  wire                      clk;
  wire                      xrst;
  wire                      req;
  wire [LWIDTH-1:0]         total_out;
  wire [LWIDTH-1:0]         total_in;
  wire [LWIDTH-1:0]         img_size;
  wire [LWIDTH-1:0]         fil_size;
  wire [LWIDTH-1:0]         pool_size;
  wire                      input_we;
  wire [INSIZE-1:0]         input_addr;
  wire signed [DWIDTH-1:0]  write_input;
  wire [CORELOG:0]          weight_we;
  wire [WSIZE-1:0]          weight_addr;
  wire signed [DWIDTH-1:0]  write_weight;
  wire [CORELOG:0]          bias_we;
  wire [BSIZE-1:0]          bias_addr;
  wire signed [DWIDTH-1:0]  write_bias;
  wire [CORELOG:0]          output_re;
  wire [OUTSIZE-1:0]        output_addr;

  wire                      ack;
  wire signed [DWIDTH-1:0]  read_output;

  assign clk          = s_axi_aclk;
  assign xrst         = s_axi_aresetn;
  assign req          = port0[0];
  assign total_out    = port1[LWIDTH-1:0];
  assign total_in     = port2[LWIDTH-1:0];
  assign img_size     = port3[LWIDTH-1:0];
  assign fil_size     = port4[LWIDTH-1:0];
  assign pool_size    = port5[LWIDTH-1:0];
  assign input_we     = port6[0];
  assign input_addr   = port7[INSIZE-1:0];
  assign write_input  = port8[DWIDTH-1:0];
  assign weight_we    = port9[CORELOG:0];
  assign weight_addr  = port10[WSIZE-1:0];
  assign write_weight = port11[DWIDTH-1:0];
  assign bias_we      = port12[CORELOG:0];
  assign bias_addr    = port13[BSIZE-1:0];
  assign write_bias   = port14[DWIDTH-1:0];
  assign output_re    = port15[CORELOG:0];
  assign output_addr  = port16[OUTSIZE-1:0];

  assign port255 = {31'b0, ack};
  assign port254 = {{DWIDTH{read_output[DWIDTH-1]}}, read_output};

  top top0(/*AUTOINST*/
    // Outputs
    .ack          (ack),
    .read_output  (read_output[DWIDTH-1:0]),
    // Inputs
    .clk          (clk),
    .xrst         (xrst),
    .req          (req),
    .total_out    (total_out[LWIDTH-1:0]),
    .total_in     (total_in[LWIDTH-1:0]),
    .img_size     (img_size[LWIDTH-1:0]),
    .fil_size     (fil_size[LWIDTH-1:0]),
    .pool_size    (pool_size[LWIDTH-1:0]),
    .input_we     (input_we),
    .input_addr   (input_addr[INSIZE-1:0]),
    .write_input  (write_input[DWIDTH-1:0]),
    .weight_we    (weight_we[CORELOG:0]),
    .weight_addr  (weight_addr[WSIZE-1:0]),
    .write_weight (write_weight[DWIDTH-1:0]),
    .bias_we      (bias_we[CORELOG:0]),
    .bias_addr    (bias_addr[BSIZE-1:0]),
    .write_bias   (write_bias[DWIDTH-1:0]),
    .output_re    (output_re[CORELOG:0]),
    .output_addr  (output_addr[OUTSIZE-1:0])
  );

  // User logic ends

endmodule
