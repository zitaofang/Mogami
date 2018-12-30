// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sun Aug 26 16:57:28 2018
// Host        : DESKTOP-LPQOCV2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               E:/Mogami/workspace/Mogami/Mogami.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0_sim_netlist.v
// Design      : dist_mem_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "dist_mem_gen_0,dist_mem_gen_v8_0_12,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2017.4" *) 
(* NotValidForBitStream *)
module dist_mem_gen_0
   (a,
    spo);
  input [9:0]a;
  output [63:0]spo;

  wire [9:0]a;
  wire [63:0]spo;
  wire [63:0]NLW_U0_dpo_UNCONNECTED;
  wire [63:0]NLW_U0_qdpo_UNCONNECTED;
  wire [63:0]NLW_U0_qspo_UNCONNECTED;

  (* C_FAMILY = "artix7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "10" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1024" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "dist_mem_gen_0.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "64" *) 
  dist_mem_gen_0_dist_mem_gen_v8_0_12 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[63:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[63:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[63:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(spo),
        .we(1'b0));
endmodule

(* C_ADDR_WIDTH = "10" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "1024" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "artix7" *) (* C_HAS_CLK = "0" *) 
(* C_HAS_D = "0" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "0" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "0" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "1" *) (* C_HAS_WE = "0" *) 
(* C_MEM_INIT_FILE = "dist_mem_gen_0.mif" *) (* C_MEM_TYPE = "0" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "1" *) (* C_REG_A_D_INPUTS = "0" *) (* C_REG_DPRA_INPUT = "0" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "64" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_12" *) 
module dist_mem_gen_0_dist_mem_gen_v8_0_12
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [9:0]a;
  input [63:0]d;
  input [9:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [63:0]spo;
  output [63:0]dpo;
  output [63:0]qspo;
  output [63:0]qdpo;

  wire \<const0> ;
  wire \<const1> ;
  wire [9:0]a;
  wire g0_b0_n_0;
  wire g0_b10_n_0;
  wire g0_b11_n_0;
  wire g0_b12_n_0;
  wire g0_b13_n_0;
  wire g0_b14_n_0;
  wire g0_b15_n_0;
  wire g0_b16_n_0;
  wire g0_b17_n_0;
  wire g0_b18_n_0;
  wire g0_b19_n_0;
  wire g0_b1_n_0;
  wire g0_b20_n_0;
  wire g0_b21_n_0;
  wire g0_b22_n_0;
  wire g0_b23_n_0;
  wire g0_b24_n_0;
  wire g0_b25_n_0;
  wire g0_b26_n_0;
  wire g0_b28_n_0;
  wire g0_b2_n_0;
  wire g0_b30_n_0;
  wire g0_b31_n_0;
  wire g0_b32_n_0;
  wire g0_b33_n_0;
  wire g0_b34_n_0;
  wire g0_b35_n_0;
  wire g0_b36_n_0;
  wire g0_b37_n_0;
  wire g0_b38_n_0;
  wire g0_b39_n_0;
  wire g0_b3_n_0;
  wire g0_b40_n_0;
  wire g0_b41_n_0;
  wire g0_b42_n_0;
  wire g0_b43_n_0;
  wire g0_b44_n_0;
  wire g0_b45_n_0;
  wire g0_b46_n_0;
  wire g0_b4_n_0;
  wire g0_b50_n_0;
  wire g0_b51_n_0;
  wire g0_b52_n_0;
  wire g0_b53_n_0;
  wire g0_b54_n_0;
  wire g0_b55_n_0;
  wire g0_b56_n_0;
  wire g0_b57_n_0;
  wire g0_b58_n_0;
  wire g0_b59_n_0;
  wire g0_b5_n_0;
  wire g0_b60_n_0;
  wire g0_b6_n_0;
  wire g0_b7_n_0;
  wire g0_b8_n_0;
  wire g0_b9_n_0;
  wire g10_b0_n_0;
  wire g10_b10_n_0;
  wire g10_b11_n_0;
  wire g10_b12_n_0;
  wire g10_b13_n_0;
  wire g10_b14_n_0;
  wire g10_b15_n_0;
  wire g10_b16_n_0;
  wire g10_b17_n_0;
  wire g10_b18_n_0;
  wire g10_b19_n_0;
  wire g10_b1_n_0;
  wire g10_b20_n_0;
  wire g10_b21_n_0;
  wire g10_b22_n_0;
  wire g10_b23_n_0;
  wire g10_b24_n_0;
  wire g10_b26_n_0;
  wire g10_b27_n_0;
  wire g10_b2_n_0;
  wire g10_b30_n_0;
  wire g10_b31_n_0;
  wire g10_b32_n_0;
  wire g10_b33_n_0;
  wire g10_b34_n_0;
  wire g10_b35_n_0;
  wire g10_b36_n_0;
  wire g10_b37_n_0;
  wire g10_b38_n_0;
  wire g10_b39_n_0;
  wire g10_b3_n_0;
  wire g10_b40_n_0;
  wire g10_b41_n_0;
  wire g10_b42_n_0;
  wire g10_b43_n_0;
  wire g10_b44_n_0;
  wire g10_b45_n_0;
  wire g10_b46_n_0;
  wire g10_b47_n_0;
  wire g10_b4_n_0;
  wire g10_b50_n_0;
  wire g10_b51_n_0;
  wire g10_b52_n_0;
  wire g10_b53_n_0;
  wire g10_b54_n_0;
  wire g10_b55_n_0;
  wire g10_b56_n_0;
  wire g10_b57_n_0;
  wire g10_b58_n_0;
  wire g10_b59_n_0;
  wire g10_b5_n_0;
  wire g10_b60_n_0;
  wire g10_b6_n_0;
  wire g10_b7_n_0;
  wire g10_b8_n_0;
  wire g10_b9_n_0;
  wire g11_b0_n_0;
  wire g11_b10_n_0;
  wire g11_b11_n_0;
  wire g11_b12_n_0;
  wire g11_b13_n_0;
  wire g11_b14_n_0;
  wire g11_b15_n_0;
  wire g11_b16_n_0;
  wire g11_b17_n_0;
  wire g11_b18_n_0;
  wire g11_b19_n_0;
  wire g11_b1_n_0;
  wire g11_b20_n_0;
  wire g11_b21_n_0;
  wire g11_b22_n_0;
  wire g11_b23_n_0;
  wire g11_b24_n_0;
  wire g11_b2_n_0;
  wire g11_b30_n_0;
  wire g11_b31_n_0;
  wire g11_b32_n_0;
  wire g11_b33_n_0;
  wire g11_b34_n_0;
  wire g11_b35_n_0;
  wire g11_b36_n_0;
  wire g11_b37_n_0;
  wire g11_b38_n_0;
  wire g11_b39_n_0;
  wire g11_b3_n_0;
  wire g11_b40_n_0;
  wire g11_b41_n_0;
  wire g11_b42_n_0;
  wire g11_b43_n_0;
  wire g11_b44_n_0;
  wire g11_b45_n_0;
  wire g11_b4_n_0;
  wire g11_b50_n_0;
  wire g11_b51_n_0;
  wire g11_b52_n_0;
  wire g11_b53_n_0;
  wire g11_b54_n_0;
  wire g11_b55_n_0;
  wire g11_b56_n_0;
  wire g11_b57_n_0;
  wire g11_b58_n_0;
  wire g11_b5_n_0;
  wire g11_b6_n_0;
  wire g11_b7_n_0;
  wire g11_b8_n_0;
  wire g11_b9_n_0;
  wire g12_b0_n_0;
  wire g12_b10_n_0;
  wire g12_b11_n_0;
  wire g12_b12_n_0;
  wire g12_b13_n_0;
  wire g12_b14_n_0;
  wire g12_b15_n_0;
  wire g12_b16_n_0;
  wire g12_b17_n_0;
  wire g12_b18_n_0;
  wire g12_b19_n_0;
  wire g12_b1_n_0;
  wire g12_b20_n_0;
  wire g12_b21_n_0;
  wire g12_b22_n_0;
  wire g12_b23_n_0;
  wire g12_b24_n_0;
  wire g12_b25_n_0;
  wire g12_b2_n_0;
  wire g12_b30_n_0;
  wire g12_b31_n_0;
  wire g12_b32_n_0;
  wire g12_b33_n_0;
  wire g12_b34_n_0;
  wire g12_b35_n_0;
  wire g12_b36_n_0;
  wire g12_b37_n_0;
  wire g12_b38_n_0;
  wire g12_b39_n_0;
  wire g12_b3_n_0;
  wire g12_b40_n_0;
  wire g12_b41_n_0;
  wire g12_b42_n_0;
  wire g12_b43_n_0;
  wire g12_b44_n_0;
  wire g12_b45_n_0;
  wire g12_b4_n_0;
  wire g12_b50_n_0;
  wire g12_b51_n_0;
  wire g12_b52_n_0;
  wire g12_b53_n_0;
  wire g12_b54_n_0;
  wire g12_b55_n_0;
  wire g12_b56_n_0;
  wire g12_b57_n_0;
  wire g12_b58_n_0;
  wire g12_b5_n_0;
  wire g12_b62_n_0;
  wire g12_b63_n_0;
  wire g12_b6_n_0;
  wire g12_b7_n_0;
  wire g12_b8_n_0;
  wire g12_b9_n_0;
  wire g13_b0_n_0;
  wire g13_b10_n_0;
  wire g13_b11_n_0;
  wire g13_b12_n_0;
  wire g13_b13_n_0;
  wire g13_b14_n_0;
  wire g13_b15_n_0;
  wire g13_b16_n_0;
  wire g13_b17_n_0;
  wire g13_b18_n_0;
  wire g13_b19_n_0;
  wire g13_b1_n_0;
  wire g13_b20_n_0;
  wire g13_b21_n_0;
  wire g13_b22_n_0;
  wire g13_b23_n_0;
  wire g13_b24_n_0;
  wire g13_b2_n_0;
  wire g13_b30_n_0;
  wire g13_b31_n_0;
  wire g13_b32_n_0;
  wire g13_b33_n_0;
  wire g13_b34_n_0;
  wire g13_b35_n_0;
  wire g13_b36_n_0;
  wire g13_b37_n_0;
  wire g13_b38_n_0;
  wire g13_b39_n_0;
  wire g13_b3_n_0;
  wire g13_b40_n_0;
  wire g13_b41_n_0;
  wire g13_b42_n_0;
  wire g13_b43_n_0;
  wire g13_b44_n_0;
  wire g13_b45_n_0;
  wire g13_b46_n_0;
  wire g13_b47_n_0;
  wire g13_b4_n_0;
  wire g13_b50_n_0;
  wire g13_b51_n_0;
  wire g13_b52_n_0;
  wire g13_b53_n_0;
  wire g13_b54_n_0;
  wire g13_b55_n_0;
  wire g13_b56_n_0;
  wire g13_b57_n_0;
  wire g13_b58_n_0;
  wire g13_b59_n_0;
  wire g13_b5_n_0;
  wire g13_b60_n_0;
  wire g13_b6_n_0;
  wire g13_b7_n_0;
  wire g13_b8_n_0;
  wire g13_b9_n_0;
  wire g14_b0_n_0;
  wire g14_b10_n_0;
  wire g14_b11_n_0;
  wire g14_b12_n_0;
  wire g14_b13_n_0;
  wire g14_b14_n_0;
  wire g14_b15_n_0;
  wire g14_b16_n_0;
  wire g14_b17_n_0;
  wire g14_b18_n_0;
  wire g14_b19_n_0;
  wire g14_b1_n_0;
  wire g14_b20_n_0;
  wire g14_b21_n_0;
  wire g14_b22_n_0;
  wire g14_b23_n_0;
  wire g14_b24_n_0;
  wire g14_b27_n_0;
  wire g14_b28_n_0;
  wire g14_b2_n_0;
  wire g14_b30_n_0;
  wire g14_b31_n_0;
  wire g14_b32_n_0;
  wire g14_b33_n_0;
  wire g14_b34_n_0;
  wire g14_b35_n_0;
  wire g14_b36_n_0;
  wire g14_b37_n_0;
  wire g14_b38_n_0;
  wire g14_b39_n_0;
  wire g14_b3_n_0;
  wire g14_b40_n_0;
  wire g14_b41_n_0;
  wire g14_b42_n_0;
  wire g14_b43_n_0;
  wire g14_b44_n_0;
  wire g14_b45_n_0;
  wire g14_b46_n_0;
  wire g14_b4_n_0;
  wire g14_b50_n_0;
  wire g14_b51_n_0;
  wire g14_b52_n_0;
  wire g14_b53_n_0;
  wire g14_b54_n_0;
  wire g14_b55_n_0;
  wire g14_b56_n_0;
  wire g14_b57_n_0;
  wire g14_b58_n_0;
  wire g14_b5_n_0;
  wire g14_b6_n_0;
  wire g14_b7_n_0;
  wire g14_b8_n_0;
  wire g14_b9_n_0;
  wire g15_b0_n_0;
  wire g15_b10_n_0;
  wire g15_b11_n_0;
  wire g15_b12_n_0;
  wire g15_b13_n_0;
  wire g15_b14_n_0;
  wire g15_b15_n_0;
  wire g15_b16_n_0;
  wire g15_b17_n_0;
  wire g15_b18_n_0;
  wire g15_b19_n_0;
  wire g15_b1_n_0;
  wire g15_b20_n_0;
  wire g15_b21_n_0;
  wire g15_b22_n_0;
  wire g15_b23_n_0;
  wire g15_b25_n_0;
  wire g15_b2_n_0;
  wire g15_b30_n_0;
  wire g15_b31_n_0;
  wire g15_b32_n_0;
  wire g15_b33_n_0;
  wire g15_b34_n_0;
  wire g15_b35_n_0;
  wire g15_b36_n_0;
  wire g15_b37_n_0;
  wire g15_b38_n_0;
  wire g15_b39_n_0;
  wire g15_b3_n_0;
  wire g15_b40_n_0;
  wire g15_b41_n_0;
  wire g15_b42_n_0;
  wire g15_b43_n_0;
  wire g15_b44_n_0;
  wire g15_b45_n_0;
  wire g15_b47_n_0;
  wire g15_b4_n_0;
  wire g15_b50_n_0;
  wire g15_b51_n_0;
  wire g15_b52_n_0;
  wire g15_b53_n_0;
  wire g15_b54_n_0;
  wire g15_b55_n_0;
  wire g15_b56_n_0;
  wire g15_b57_n_0;
  wire g15_b58_n_0;
  wire g15_b5_n_0;
  wire g15_b6_n_0;
  wire g15_b7_n_0;
  wire g15_b8_n_0;
  wire g15_b9_n_0;
  wire g1_b0_n_0;
  wire g1_b10_n_0;
  wire g1_b11_n_0;
  wire g1_b12_n_0;
  wire g1_b13_n_0;
  wire g1_b14_n_0;
  wire g1_b15_n_0;
  wire g1_b16_n_0;
  wire g1_b17_n_0;
  wire g1_b18_n_0;
  wire g1_b19_n_0;
  wire g1_b1_n_0;
  wire g1_b20_n_0;
  wire g1_b21_n_0;
  wire g1_b22_n_0;
  wire g1_b23_n_0;
  wire g1_b24_n_0;
  wire g1_b25_n_0;
  wire g1_b26_n_0;
  wire g1_b27_n_0;
  wire g1_b2_n_0;
  wire g1_b30_n_0;
  wire g1_b31_n_0;
  wire g1_b32_n_0;
  wire g1_b33_n_0;
  wire g1_b34_n_0;
  wire g1_b35_n_0;
  wire g1_b36_n_0;
  wire g1_b37_n_0;
  wire g1_b38_n_0;
  wire g1_b39_n_0;
  wire g1_b3_n_0;
  wire g1_b40_n_0;
  wire g1_b41_n_0;
  wire g1_b42_n_0;
  wire g1_b43_n_0;
  wire g1_b44_n_0;
  wire g1_b45_n_0;
  wire g1_b46_n_0;
  wire g1_b47_n_0;
  wire g1_b48_n_0;
  wire g1_b4_n_0;
  wire g1_b50_n_0;
  wire g1_b51_n_0;
  wire g1_b52_n_0;
  wire g1_b53_n_0;
  wire g1_b54_n_0;
  wire g1_b55_n_0;
  wire g1_b56_n_0;
  wire g1_b57_n_0;
  wire g1_b58_n_0;
  wire g1_b59_n_0;
  wire g1_b5_n_0;
  wire g1_b6_n_0;
  wire g1_b7_n_0;
  wire g1_b8_n_0;
  wire g1_b9_n_0;
  wire g2_b0_n_0;
  wire g2_b10_n_0;
  wire g2_b11_n_0;
  wire g2_b12_n_0;
  wire g2_b13_n_0;
  wire g2_b14_n_0;
  wire g2_b15_n_0;
  wire g2_b16_n_0;
  wire g2_b17_n_0;
  wire g2_b18_n_0;
  wire g2_b19_n_0;
  wire g2_b1_n_0;
  wire g2_b20_n_0;
  wire g2_b21_n_0;
  wire g2_b22_n_0;
  wire g2_b23_n_0;
  wire g2_b24_n_0;
  wire g2_b25_n_0;
  wire g2_b27_n_0;
  wire g2_b28_n_0;
  wire g2_b2_n_0;
  wire g2_b30_n_0;
  wire g2_b31_n_0;
  wire g2_b32_n_0;
  wire g2_b33_n_0;
  wire g2_b34_n_0;
  wire g2_b35_n_0;
  wire g2_b36_n_0;
  wire g2_b37_n_0;
  wire g2_b38_n_0;
  wire g2_b39_n_0;
  wire g2_b3_n_0;
  wire g2_b40_n_0;
  wire g2_b41_n_0;
  wire g2_b42_n_0;
  wire g2_b43_n_0;
  wire g2_b44_n_0;
  wire g2_b45_n_0;
  wire g2_b46_n_0;
  wire g2_b47_n_0;
  wire g2_b4_n_0;
  wire g2_b50_n_0;
  wire g2_b51_n_0;
  wire g2_b52_n_0;
  wire g2_b53_n_0;
  wire g2_b54_n_0;
  wire g2_b55_n_0;
  wire g2_b56_n_0;
  wire g2_b57_n_0;
  wire g2_b58_n_0;
  wire g2_b59_n_0;
  wire g2_b5_n_0;
  wire g2_b62_n_0;
  wire g2_b6_n_0;
  wire g2_b7_n_0;
  wire g2_b8_n_0;
  wire g2_b9_n_0;
  wire g3_b0_n_0;
  wire g3_b10_n_0;
  wire g3_b11_n_0;
  wire g3_b12_n_0;
  wire g3_b13_n_0;
  wire g3_b14_n_0;
  wire g3_b15_n_0;
  wire g3_b16_n_0;
  wire g3_b17_n_0;
  wire g3_b18_n_0;
  wire g3_b19_n_0;
  wire g3_b1_n_0;
  wire g3_b20_n_0;
  wire g3_b21_n_0;
  wire g3_b22_n_0;
  wire g3_b23_n_0;
  wire g3_b24_n_0;
  wire g3_b25_n_0;
  wire g3_b26_n_0;
  wire g3_b2_n_0;
  wire g3_b30_n_0;
  wire g3_b31_n_0;
  wire g3_b32_n_0;
  wire g3_b33_n_0;
  wire g3_b34_n_0;
  wire g3_b35_n_0;
  wire g3_b36_n_0;
  wire g3_b37_n_0;
  wire g3_b38_n_0;
  wire g3_b39_n_0;
  wire g3_b3_n_0;
  wire g3_b40_n_0;
  wire g3_b41_n_0;
  wire g3_b42_n_0;
  wire g3_b43_n_0;
  wire g3_b44_n_0;
  wire g3_b45_n_0;
  wire g3_b46_n_0;
  wire g3_b4_n_0;
  wire g3_b50_n_0;
  wire g3_b51_n_0;
  wire g3_b52_n_0;
  wire g3_b53_n_0;
  wire g3_b54_n_0;
  wire g3_b55_n_0;
  wire g3_b56_n_0;
  wire g3_b57_n_0;
  wire g3_b58_n_0;
  wire g3_b59_n_0;
  wire g3_b5_n_0;
  wire g3_b60_n_0;
  wire g3_b62_n_0;
  wire g3_b63_n_0;
  wire g3_b6_n_0;
  wire g3_b7_n_0;
  wire g3_b8_n_0;
  wire g3_b9_n_0;
  wire g4_b0_n_0;
  wire g4_b10_n_0;
  wire g4_b11_n_0;
  wire g4_b12_n_0;
  wire g4_b13_n_0;
  wire g4_b14_n_0;
  wire g4_b15_n_0;
  wire g4_b16_n_0;
  wire g4_b17_n_0;
  wire g4_b18_n_0;
  wire g4_b19_n_0;
  wire g4_b1_n_0;
  wire g4_b20_n_0;
  wire g4_b21_n_0;
  wire g4_b22_n_0;
  wire g4_b23_n_0;
  wire g4_b24_n_0;
  wire g4_b25_n_0;
  wire g4_b26_n_0;
  wire g4_b2_n_0;
  wire g4_b30_n_0;
  wire g4_b31_n_0;
  wire g4_b32_n_0;
  wire g4_b33_n_0;
  wire g4_b34_n_0;
  wire g4_b35_n_0;
  wire g4_b36_n_0;
  wire g4_b37_n_0;
  wire g4_b38_n_0;
  wire g4_b39_n_0;
  wire g4_b3_n_0;
  wire g4_b40_n_0;
  wire g4_b41_n_0;
  wire g4_b42_n_0;
  wire g4_b43_n_0;
  wire g4_b44_n_0;
  wire g4_b45_n_0;
  wire g4_b46_n_0;
  wire g4_b47_n_0;
  wire g4_b4_n_0;
  wire g4_b50_n_0;
  wire g4_b51_n_0;
  wire g4_b52_n_0;
  wire g4_b53_n_0;
  wire g4_b54_n_0;
  wire g4_b55_n_0;
  wire g4_b56_n_0;
  wire g4_b57_n_0;
  wire g4_b58_n_0;
  wire g4_b5_n_0;
  wire g4_b62_n_0;
  wire g4_b6_n_0;
  wire g4_b7_n_0;
  wire g4_b8_n_0;
  wire g4_b9_n_0;
  wire g5_b0_n_0;
  wire g5_b10_n_0;
  wire g5_b11_n_0;
  wire g5_b12_n_0;
  wire g5_b13_n_0;
  wire g5_b14_n_0;
  wire g5_b15_n_0;
  wire g5_b16_n_0;
  wire g5_b17_n_0;
  wire g5_b18_n_0;
  wire g5_b19_n_0;
  wire g5_b1_n_0;
  wire g5_b20_n_0;
  wire g5_b21_n_0;
  wire g5_b22_n_0;
  wire g5_b23_n_0;
  wire g5_b24_n_0;
  wire g5_b25_n_0;
  wire g5_b2_n_0;
  wire g5_b30_n_0;
  wire g5_b31_n_0;
  wire g5_b32_n_0;
  wire g5_b33_n_0;
  wire g5_b34_n_0;
  wire g5_b35_n_0;
  wire g5_b36_n_0;
  wire g5_b37_n_0;
  wire g5_b38_n_0;
  wire g5_b39_n_0;
  wire g5_b3_n_0;
  wire g5_b40_n_0;
  wire g5_b41_n_0;
  wire g5_b42_n_0;
  wire g5_b43_n_0;
  wire g5_b44_n_0;
  wire g5_b45_n_0;
  wire g5_b46_n_0;
  wire g5_b48_n_0;
  wire g5_b4_n_0;
  wire g5_b50_n_0;
  wire g5_b51_n_0;
  wire g5_b52_n_0;
  wire g5_b53_n_0;
  wire g5_b54_n_0;
  wire g5_b55_n_0;
  wire g5_b56_n_0;
  wire g5_b57_n_0;
  wire g5_b58_n_0;
  wire g5_b59_n_0;
  wire g5_b5_n_0;
  wire g5_b60_n_0;
  wire g5_b6_n_0;
  wire g5_b7_n_0;
  wire g5_b8_n_0;
  wire g5_b9_n_0;
  wire g6_b0_n_0;
  wire g6_b10_n_0;
  wire g6_b11_n_0;
  wire g6_b12_n_0;
  wire g6_b13_n_0;
  wire g6_b14_n_0;
  wire g6_b15_n_0;
  wire g6_b16_n_0;
  wire g6_b17_n_0;
  wire g6_b18_n_0;
  wire g6_b19_n_0;
  wire g6_b1_n_0;
  wire g6_b20_n_0;
  wire g6_b21_n_0;
  wire g6_b22_n_0;
  wire g6_b23_n_0;
  wire g6_b24_n_0;
  wire g6_b2_n_0;
  wire g6_b30_n_0;
  wire g6_b31_n_0;
  wire g6_b32_n_0;
  wire g6_b33_n_0;
  wire g6_b34_n_0;
  wire g6_b35_n_0;
  wire g6_b36_n_0;
  wire g6_b37_n_0;
  wire g6_b38_n_0;
  wire g6_b39_n_0;
  wire g6_b3_n_0;
  wire g6_b40_n_0;
  wire g6_b41_n_0;
  wire g6_b42_n_0;
  wire g6_b43_n_0;
  wire g6_b44_n_0;
  wire g6_b45_n_0;
  wire g6_b46_n_0;
  wire g6_b47_n_0;
  wire g6_b4_n_0;
  wire g6_b50_n_0;
  wire g6_b51_n_0;
  wire g6_b52_n_0;
  wire g6_b53_n_0;
  wire g6_b54_n_0;
  wire g6_b55_n_0;
  wire g6_b56_n_0;
  wire g6_b57_n_0;
  wire g6_b58_n_0;
  wire g6_b59_n_0;
  wire g6_b5_n_0;
  wire g6_b6_n_0;
  wire g6_b7_n_0;
  wire g6_b8_n_0;
  wire g6_b9_n_0;
  wire g7_b0_n_0;
  wire g7_b10_n_0;
  wire g7_b11_n_0;
  wire g7_b12_n_0;
  wire g7_b13_n_0;
  wire g7_b14_n_0;
  wire g7_b15_n_0;
  wire g7_b16_n_0;
  wire g7_b17_n_0;
  wire g7_b18_n_0;
  wire g7_b19_n_0;
  wire g7_b1_n_0;
  wire g7_b20_n_0;
  wire g7_b21_n_0;
  wire g7_b22_n_0;
  wire g7_b23_n_0;
  wire g7_b24_n_0;
  wire g7_b25_n_0;
  wire g7_b2_n_0;
  wire g7_b30_n_0;
  wire g7_b31_n_0;
  wire g7_b32_n_0;
  wire g7_b33_n_0;
  wire g7_b34_n_0;
  wire g7_b35_n_0;
  wire g7_b36_n_0;
  wire g7_b37_n_0;
  wire g7_b38_n_0;
  wire g7_b39_n_0;
  wire g7_b3_n_0;
  wire g7_b40_n_0;
  wire g7_b41_n_0;
  wire g7_b42_n_0;
  wire g7_b43_n_0;
  wire g7_b44_n_0;
  wire g7_b45_n_0;
  wire g7_b4_n_0;
  wire g7_b50_n_0;
  wire g7_b51_n_0;
  wire g7_b52_n_0;
  wire g7_b53_n_0;
  wire g7_b54_n_0;
  wire g7_b55_n_0;
  wire g7_b56_n_0;
  wire g7_b57_n_0;
  wire g7_b58_n_0;
  wire g7_b5_n_0;
  wire g7_b6_n_0;
  wire g7_b7_n_0;
  wire g7_b8_n_0;
  wire g7_b9_n_0;
  wire g8_b0_n_0;
  wire g8_b10_n_0;
  wire g8_b11_n_0;
  wire g8_b12_n_0;
  wire g8_b13_n_0;
  wire g8_b14_n_0;
  wire g8_b15_n_0;
  wire g8_b16_n_0;
  wire g8_b17_n_0;
  wire g8_b18_n_0;
  wire g8_b19_n_0;
  wire g8_b1_n_0;
  wire g8_b20_n_0;
  wire g8_b21_n_0;
  wire g8_b22_n_0;
  wire g8_b23_n_0;
  wire g8_b24_n_0;
  wire g8_b25_n_0;
  wire g8_b2_n_0;
  wire g8_b30_n_0;
  wire g8_b31_n_0;
  wire g8_b32_n_0;
  wire g8_b33_n_0;
  wire g8_b34_n_0;
  wire g8_b35_n_0;
  wire g8_b36_n_0;
  wire g8_b37_n_0;
  wire g8_b38_n_0;
  wire g8_b39_n_0;
  wire g8_b3_n_0;
  wire g8_b40_n_0;
  wire g8_b41_n_0;
  wire g8_b42_n_0;
  wire g8_b43_n_0;
  wire g8_b44_n_0;
  wire g8_b45_n_0;
  wire g8_b46_n_0;
  wire g8_b47_n_0;
  wire g8_b4_n_0;
  wire g8_b50_n_0;
  wire g8_b51_n_0;
  wire g8_b52_n_0;
  wire g8_b53_n_0;
  wire g8_b54_n_0;
  wire g8_b55_n_0;
  wire g8_b56_n_0;
  wire g8_b57_n_0;
  wire g8_b58_n_0;
  wire g8_b59_n_0;
  wire g8_b5_n_0;
  wire g8_b6_n_0;
  wire g8_b7_n_0;
  wire g8_b8_n_0;
  wire g8_b9_n_0;
  wire g9_b0_n_0;
  wire g9_b10_n_0;
  wire g9_b11_n_0;
  wire g9_b12_n_0;
  wire g9_b13_n_0;
  wire g9_b14_n_0;
  wire g9_b15_n_0;
  wire g9_b16_n_0;
  wire g9_b17_n_0;
  wire g9_b18_n_0;
  wire g9_b19_n_0;
  wire g9_b1_n_0;
  wire g9_b20_n_0;
  wire g9_b21_n_0;
  wire g9_b22_n_0;
  wire g9_b23_n_0;
  wire g9_b24_n_0;
  wire g9_b25_n_0;
  wire g9_b2_n_0;
  wire g9_b30_n_0;
  wire g9_b31_n_0;
  wire g9_b32_n_0;
  wire g9_b33_n_0;
  wire g9_b34_n_0;
  wire g9_b35_n_0;
  wire g9_b36_n_0;
  wire g9_b37_n_0;
  wire g9_b38_n_0;
  wire g9_b39_n_0;
  wire g9_b3_n_0;
  wire g9_b40_n_0;
  wire g9_b41_n_0;
  wire g9_b42_n_0;
  wire g9_b43_n_0;
  wire g9_b44_n_0;
  wire g9_b45_n_0;
  wire g9_b46_n_0;
  wire g9_b48_n_0;
  wire g9_b4_n_0;
  wire g9_b50_n_0;
  wire g9_b51_n_0;
  wire g9_b52_n_0;
  wire g9_b53_n_0;
  wire g9_b54_n_0;
  wire g9_b55_n_0;
  wire g9_b56_n_0;
  wire g9_b57_n_0;
  wire g9_b58_n_0;
  wire g9_b59_n_0;
  wire g9_b5_n_0;
  wire g9_b62_n_0;
  wire g9_b6_n_0;
  wire g9_b7_n_0;
  wire g9_b8_n_0;
  wire g9_b9_n_0;
  wire [63:0]\^spo ;
  wire \spo[0]_INST_0_i_10_n_0 ;
  wire \spo[0]_INST_0_i_1_n_0 ;
  wire \spo[0]_INST_0_i_2_n_0 ;
  wire \spo[0]_INST_0_i_3_n_0 ;
  wire \spo[0]_INST_0_i_4_n_0 ;
  wire \spo[0]_INST_0_i_5_n_0 ;
  wire \spo[0]_INST_0_i_6_n_0 ;
  wire \spo[0]_INST_0_i_7_n_0 ;
  wire \spo[0]_INST_0_i_8_n_0 ;
  wire \spo[0]_INST_0_i_9_n_0 ;
  wire \spo[10]_INST_0_i_10_n_0 ;
  wire \spo[10]_INST_0_i_1_n_0 ;
  wire \spo[10]_INST_0_i_2_n_0 ;
  wire \spo[10]_INST_0_i_3_n_0 ;
  wire \spo[10]_INST_0_i_4_n_0 ;
  wire \spo[10]_INST_0_i_5_n_0 ;
  wire \spo[10]_INST_0_i_6_n_0 ;
  wire \spo[10]_INST_0_i_7_n_0 ;
  wire \spo[10]_INST_0_i_8_n_0 ;
  wire \spo[10]_INST_0_i_9_n_0 ;
  wire \spo[11]_INST_0_i_10_n_0 ;
  wire \spo[11]_INST_0_i_1_n_0 ;
  wire \spo[11]_INST_0_i_2_n_0 ;
  wire \spo[11]_INST_0_i_3_n_0 ;
  wire \spo[11]_INST_0_i_4_n_0 ;
  wire \spo[11]_INST_0_i_5_n_0 ;
  wire \spo[11]_INST_0_i_6_n_0 ;
  wire \spo[11]_INST_0_i_7_n_0 ;
  wire \spo[11]_INST_0_i_8_n_0 ;
  wire \spo[11]_INST_0_i_9_n_0 ;
  wire \spo[12]_INST_0_i_10_n_0 ;
  wire \spo[12]_INST_0_i_1_n_0 ;
  wire \spo[12]_INST_0_i_2_n_0 ;
  wire \spo[12]_INST_0_i_3_n_0 ;
  wire \spo[12]_INST_0_i_4_n_0 ;
  wire \spo[12]_INST_0_i_5_n_0 ;
  wire \spo[12]_INST_0_i_6_n_0 ;
  wire \spo[12]_INST_0_i_7_n_0 ;
  wire \spo[12]_INST_0_i_8_n_0 ;
  wire \spo[12]_INST_0_i_9_n_0 ;
  wire \spo[13]_INST_0_i_10_n_0 ;
  wire \spo[13]_INST_0_i_1_n_0 ;
  wire \spo[13]_INST_0_i_2_n_0 ;
  wire \spo[13]_INST_0_i_3_n_0 ;
  wire \spo[13]_INST_0_i_4_n_0 ;
  wire \spo[13]_INST_0_i_5_n_0 ;
  wire \spo[13]_INST_0_i_6_n_0 ;
  wire \spo[13]_INST_0_i_7_n_0 ;
  wire \spo[13]_INST_0_i_8_n_0 ;
  wire \spo[13]_INST_0_i_9_n_0 ;
  wire \spo[14]_INST_0_i_10_n_0 ;
  wire \spo[14]_INST_0_i_1_n_0 ;
  wire \spo[14]_INST_0_i_2_n_0 ;
  wire \spo[14]_INST_0_i_3_n_0 ;
  wire \spo[14]_INST_0_i_4_n_0 ;
  wire \spo[14]_INST_0_i_5_n_0 ;
  wire \spo[14]_INST_0_i_6_n_0 ;
  wire \spo[14]_INST_0_i_7_n_0 ;
  wire \spo[14]_INST_0_i_8_n_0 ;
  wire \spo[14]_INST_0_i_9_n_0 ;
  wire \spo[15]_INST_0_i_10_n_0 ;
  wire \spo[15]_INST_0_i_1_n_0 ;
  wire \spo[15]_INST_0_i_2_n_0 ;
  wire \spo[15]_INST_0_i_3_n_0 ;
  wire \spo[15]_INST_0_i_4_n_0 ;
  wire \spo[15]_INST_0_i_5_n_0 ;
  wire \spo[15]_INST_0_i_6_n_0 ;
  wire \spo[15]_INST_0_i_7_n_0 ;
  wire \spo[15]_INST_0_i_8_n_0 ;
  wire \spo[15]_INST_0_i_9_n_0 ;
  wire \spo[16]_INST_0_i_10_n_0 ;
  wire \spo[16]_INST_0_i_1_n_0 ;
  wire \spo[16]_INST_0_i_2_n_0 ;
  wire \spo[16]_INST_0_i_3_n_0 ;
  wire \spo[16]_INST_0_i_4_n_0 ;
  wire \spo[16]_INST_0_i_5_n_0 ;
  wire \spo[16]_INST_0_i_6_n_0 ;
  wire \spo[16]_INST_0_i_7_n_0 ;
  wire \spo[16]_INST_0_i_8_n_0 ;
  wire \spo[16]_INST_0_i_9_n_0 ;
  wire \spo[17]_INST_0_i_10_n_0 ;
  wire \spo[17]_INST_0_i_1_n_0 ;
  wire \spo[17]_INST_0_i_2_n_0 ;
  wire \spo[17]_INST_0_i_3_n_0 ;
  wire \spo[17]_INST_0_i_4_n_0 ;
  wire \spo[17]_INST_0_i_5_n_0 ;
  wire \spo[17]_INST_0_i_6_n_0 ;
  wire \spo[17]_INST_0_i_7_n_0 ;
  wire \spo[17]_INST_0_i_8_n_0 ;
  wire \spo[17]_INST_0_i_9_n_0 ;
  wire \spo[18]_INST_0_i_10_n_0 ;
  wire \spo[18]_INST_0_i_1_n_0 ;
  wire \spo[18]_INST_0_i_2_n_0 ;
  wire \spo[18]_INST_0_i_3_n_0 ;
  wire \spo[18]_INST_0_i_4_n_0 ;
  wire \spo[18]_INST_0_i_5_n_0 ;
  wire \spo[18]_INST_0_i_6_n_0 ;
  wire \spo[18]_INST_0_i_7_n_0 ;
  wire \spo[18]_INST_0_i_8_n_0 ;
  wire \spo[18]_INST_0_i_9_n_0 ;
  wire \spo[19]_INST_0_i_10_n_0 ;
  wire \spo[19]_INST_0_i_1_n_0 ;
  wire \spo[19]_INST_0_i_2_n_0 ;
  wire \spo[19]_INST_0_i_3_n_0 ;
  wire \spo[19]_INST_0_i_4_n_0 ;
  wire \spo[19]_INST_0_i_5_n_0 ;
  wire \spo[19]_INST_0_i_6_n_0 ;
  wire \spo[19]_INST_0_i_7_n_0 ;
  wire \spo[19]_INST_0_i_8_n_0 ;
  wire \spo[19]_INST_0_i_9_n_0 ;
  wire \spo[1]_INST_0_i_10_n_0 ;
  wire \spo[1]_INST_0_i_1_n_0 ;
  wire \spo[1]_INST_0_i_2_n_0 ;
  wire \spo[1]_INST_0_i_3_n_0 ;
  wire \spo[1]_INST_0_i_4_n_0 ;
  wire \spo[1]_INST_0_i_5_n_0 ;
  wire \spo[1]_INST_0_i_6_n_0 ;
  wire \spo[1]_INST_0_i_7_n_0 ;
  wire \spo[1]_INST_0_i_8_n_0 ;
  wire \spo[1]_INST_0_i_9_n_0 ;
  wire \spo[20]_INST_0_i_10_n_0 ;
  wire \spo[20]_INST_0_i_1_n_0 ;
  wire \spo[20]_INST_0_i_2_n_0 ;
  wire \spo[20]_INST_0_i_3_n_0 ;
  wire \spo[20]_INST_0_i_4_n_0 ;
  wire \spo[20]_INST_0_i_5_n_0 ;
  wire \spo[20]_INST_0_i_6_n_0 ;
  wire \spo[20]_INST_0_i_7_n_0 ;
  wire \spo[20]_INST_0_i_8_n_0 ;
  wire \spo[20]_INST_0_i_9_n_0 ;
  wire \spo[21]_INST_0_i_10_n_0 ;
  wire \spo[21]_INST_0_i_1_n_0 ;
  wire \spo[21]_INST_0_i_2_n_0 ;
  wire \spo[21]_INST_0_i_3_n_0 ;
  wire \spo[21]_INST_0_i_4_n_0 ;
  wire \spo[21]_INST_0_i_5_n_0 ;
  wire \spo[21]_INST_0_i_6_n_0 ;
  wire \spo[21]_INST_0_i_7_n_0 ;
  wire \spo[21]_INST_0_i_8_n_0 ;
  wire \spo[21]_INST_0_i_9_n_0 ;
  wire \spo[22]_INST_0_i_10_n_0 ;
  wire \spo[22]_INST_0_i_1_n_0 ;
  wire \spo[22]_INST_0_i_2_n_0 ;
  wire \spo[22]_INST_0_i_3_n_0 ;
  wire \spo[22]_INST_0_i_4_n_0 ;
  wire \spo[22]_INST_0_i_5_n_0 ;
  wire \spo[22]_INST_0_i_6_n_0 ;
  wire \spo[22]_INST_0_i_7_n_0 ;
  wire \spo[22]_INST_0_i_8_n_0 ;
  wire \spo[22]_INST_0_i_9_n_0 ;
  wire \spo[23]_INST_0_i_10_n_0 ;
  wire \spo[23]_INST_0_i_1_n_0 ;
  wire \spo[23]_INST_0_i_2_n_0 ;
  wire \spo[23]_INST_0_i_3_n_0 ;
  wire \spo[23]_INST_0_i_4_n_0 ;
  wire \spo[23]_INST_0_i_5_n_0 ;
  wire \spo[23]_INST_0_i_6_n_0 ;
  wire \spo[23]_INST_0_i_7_n_0 ;
  wire \spo[23]_INST_0_i_8_n_0 ;
  wire \spo[23]_INST_0_i_9_n_0 ;
  wire \spo[24]_INST_0_i_1_n_0 ;
  wire \spo[24]_INST_0_i_2_n_0 ;
  wire \spo[24]_INST_0_i_3_n_0 ;
  wire \spo[24]_INST_0_i_4_n_0 ;
  wire \spo[25]_INST_0_i_1_n_0 ;
  wire \spo[25]_INST_0_i_2_n_0 ;
  wire \spo[25]_INST_0_i_3_n_0 ;
  wire \spo[25]_INST_0_i_4_n_0 ;
  wire \spo[25]_INST_0_i_5_n_0 ;
  wire \spo[26]_INST_0_i_1_n_0 ;
  wire \spo[26]_INST_0_i_2_n_0 ;
  wire \spo[26]_INST_0_i_3_n_0 ;
  wire \spo[26]_INST_0_i_4_n_0 ;
  wire \spo[26]_INST_0_i_5_n_0 ;
  wire \spo[26]_INST_0_i_6_n_0 ;
  wire \spo[27]_INST_0_i_1_n_0 ;
  wire \spo[27]_INST_0_i_2_n_0 ;
  wire \spo[27]_INST_0_i_3_n_0 ;
  wire \spo[28]_INST_0_i_1_n_0 ;
  wire \spo[28]_INST_0_i_2_n_0 ;
  wire \spo[2]_INST_0_i_10_n_0 ;
  wire \spo[2]_INST_0_i_1_n_0 ;
  wire \spo[2]_INST_0_i_2_n_0 ;
  wire \spo[2]_INST_0_i_3_n_0 ;
  wire \spo[2]_INST_0_i_4_n_0 ;
  wire \spo[2]_INST_0_i_5_n_0 ;
  wire \spo[2]_INST_0_i_6_n_0 ;
  wire \spo[2]_INST_0_i_7_n_0 ;
  wire \spo[2]_INST_0_i_8_n_0 ;
  wire \spo[2]_INST_0_i_9_n_0 ;
  wire \spo[30]_INST_0_i_10_n_0 ;
  wire \spo[30]_INST_0_i_1_n_0 ;
  wire \spo[30]_INST_0_i_2_n_0 ;
  wire \spo[30]_INST_0_i_3_n_0 ;
  wire \spo[30]_INST_0_i_4_n_0 ;
  wire \spo[30]_INST_0_i_5_n_0 ;
  wire \spo[30]_INST_0_i_6_n_0 ;
  wire \spo[30]_INST_0_i_7_n_0 ;
  wire \spo[30]_INST_0_i_8_n_0 ;
  wire \spo[30]_INST_0_i_9_n_0 ;
  wire \spo[31]_INST_0_i_10_n_0 ;
  wire \spo[31]_INST_0_i_1_n_0 ;
  wire \spo[31]_INST_0_i_2_n_0 ;
  wire \spo[31]_INST_0_i_3_n_0 ;
  wire \spo[31]_INST_0_i_4_n_0 ;
  wire \spo[31]_INST_0_i_5_n_0 ;
  wire \spo[31]_INST_0_i_6_n_0 ;
  wire \spo[31]_INST_0_i_7_n_0 ;
  wire \spo[31]_INST_0_i_8_n_0 ;
  wire \spo[31]_INST_0_i_9_n_0 ;
  wire \spo[32]_INST_0_i_10_n_0 ;
  wire \spo[32]_INST_0_i_1_n_0 ;
  wire \spo[32]_INST_0_i_2_n_0 ;
  wire \spo[32]_INST_0_i_3_n_0 ;
  wire \spo[32]_INST_0_i_4_n_0 ;
  wire \spo[32]_INST_0_i_5_n_0 ;
  wire \spo[32]_INST_0_i_6_n_0 ;
  wire \spo[32]_INST_0_i_7_n_0 ;
  wire \spo[32]_INST_0_i_8_n_0 ;
  wire \spo[32]_INST_0_i_9_n_0 ;
  wire \spo[33]_INST_0_i_10_n_0 ;
  wire \spo[33]_INST_0_i_1_n_0 ;
  wire \spo[33]_INST_0_i_2_n_0 ;
  wire \spo[33]_INST_0_i_3_n_0 ;
  wire \spo[33]_INST_0_i_4_n_0 ;
  wire \spo[33]_INST_0_i_5_n_0 ;
  wire \spo[33]_INST_0_i_6_n_0 ;
  wire \spo[33]_INST_0_i_7_n_0 ;
  wire \spo[33]_INST_0_i_8_n_0 ;
  wire \spo[33]_INST_0_i_9_n_0 ;
  wire \spo[34]_INST_0_i_10_n_0 ;
  wire \spo[34]_INST_0_i_1_n_0 ;
  wire \spo[34]_INST_0_i_2_n_0 ;
  wire \spo[34]_INST_0_i_3_n_0 ;
  wire \spo[34]_INST_0_i_4_n_0 ;
  wire \spo[34]_INST_0_i_5_n_0 ;
  wire \spo[34]_INST_0_i_6_n_0 ;
  wire \spo[34]_INST_0_i_7_n_0 ;
  wire \spo[34]_INST_0_i_8_n_0 ;
  wire \spo[34]_INST_0_i_9_n_0 ;
  wire \spo[35]_INST_0_i_10_n_0 ;
  wire \spo[35]_INST_0_i_1_n_0 ;
  wire \spo[35]_INST_0_i_2_n_0 ;
  wire \spo[35]_INST_0_i_3_n_0 ;
  wire \spo[35]_INST_0_i_4_n_0 ;
  wire \spo[35]_INST_0_i_5_n_0 ;
  wire \spo[35]_INST_0_i_6_n_0 ;
  wire \spo[35]_INST_0_i_7_n_0 ;
  wire \spo[35]_INST_0_i_8_n_0 ;
  wire \spo[35]_INST_0_i_9_n_0 ;
  wire \spo[36]_INST_0_i_10_n_0 ;
  wire \spo[36]_INST_0_i_1_n_0 ;
  wire \spo[36]_INST_0_i_2_n_0 ;
  wire \spo[36]_INST_0_i_3_n_0 ;
  wire \spo[36]_INST_0_i_4_n_0 ;
  wire \spo[36]_INST_0_i_5_n_0 ;
  wire \spo[36]_INST_0_i_6_n_0 ;
  wire \spo[36]_INST_0_i_7_n_0 ;
  wire \spo[36]_INST_0_i_8_n_0 ;
  wire \spo[36]_INST_0_i_9_n_0 ;
  wire \spo[37]_INST_0_i_10_n_0 ;
  wire \spo[37]_INST_0_i_1_n_0 ;
  wire \spo[37]_INST_0_i_2_n_0 ;
  wire \spo[37]_INST_0_i_3_n_0 ;
  wire \spo[37]_INST_0_i_4_n_0 ;
  wire \spo[37]_INST_0_i_5_n_0 ;
  wire \spo[37]_INST_0_i_6_n_0 ;
  wire \spo[37]_INST_0_i_7_n_0 ;
  wire \spo[37]_INST_0_i_8_n_0 ;
  wire \spo[37]_INST_0_i_9_n_0 ;
  wire \spo[38]_INST_0_i_10_n_0 ;
  wire \spo[38]_INST_0_i_1_n_0 ;
  wire \spo[38]_INST_0_i_2_n_0 ;
  wire \spo[38]_INST_0_i_3_n_0 ;
  wire \spo[38]_INST_0_i_4_n_0 ;
  wire \spo[38]_INST_0_i_5_n_0 ;
  wire \spo[38]_INST_0_i_6_n_0 ;
  wire \spo[38]_INST_0_i_7_n_0 ;
  wire \spo[38]_INST_0_i_8_n_0 ;
  wire \spo[38]_INST_0_i_9_n_0 ;
  wire \spo[39]_INST_0_i_10_n_0 ;
  wire \spo[39]_INST_0_i_1_n_0 ;
  wire \spo[39]_INST_0_i_2_n_0 ;
  wire \spo[39]_INST_0_i_3_n_0 ;
  wire \spo[39]_INST_0_i_4_n_0 ;
  wire \spo[39]_INST_0_i_5_n_0 ;
  wire \spo[39]_INST_0_i_6_n_0 ;
  wire \spo[39]_INST_0_i_7_n_0 ;
  wire \spo[39]_INST_0_i_8_n_0 ;
  wire \spo[39]_INST_0_i_9_n_0 ;
  wire \spo[3]_INST_0_i_10_n_0 ;
  wire \spo[3]_INST_0_i_1_n_0 ;
  wire \spo[3]_INST_0_i_2_n_0 ;
  wire \spo[3]_INST_0_i_3_n_0 ;
  wire \spo[3]_INST_0_i_4_n_0 ;
  wire \spo[3]_INST_0_i_5_n_0 ;
  wire \spo[3]_INST_0_i_6_n_0 ;
  wire \spo[3]_INST_0_i_7_n_0 ;
  wire \spo[3]_INST_0_i_8_n_0 ;
  wire \spo[3]_INST_0_i_9_n_0 ;
  wire \spo[40]_INST_0_i_10_n_0 ;
  wire \spo[40]_INST_0_i_1_n_0 ;
  wire \spo[40]_INST_0_i_2_n_0 ;
  wire \spo[40]_INST_0_i_3_n_0 ;
  wire \spo[40]_INST_0_i_4_n_0 ;
  wire \spo[40]_INST_0_i_5_n_0 ;
  wire \spo[40]_INST_0_i_6_n_0 ;
  wire \spo[40]_INST_0_i_7_n_0 ;
  wire \spo[40]_INST_0_i_8_n_0 ;
  wire \spo[40]_INST_0_i_9_n_0 ;
  wire \spo[41]_INST_0_i_10_n_0 ;
  wire \spo[41]_INST_0_i_1_n_0 ;
  wire \spo[41]_INST_0_i_2_n_0 ;
  wire \spo[41]_INST_0_i_3_n_0 ;
  wire \spo[41]_INST_0_i_4_n_0 ;
  wire \spo[41]_INST_0_i_5_n_0 ;
  wire \spo[41]_INST_0_i_6_n_0 ;
  wire \spo[41]_INST_0_i_7_n_0 ;
  wire \spo[41]_INST_0_i_8_n_0 ;
  wire \spo[41]_INST_0_i_9_n_0 ;
  wire \spo[42]_INST_0_i_10_n_0 ;
  wire \spo[42]_INST_0_i_1_n_0 ;
  wire \spo[42]_INST_0_i_2_n_0 ;
  wire \spo[42]_INST_0_i_3_n_0 ;
  wire \spo[42]_INST_0_i_4_n_0 ;
  wire \spo[42]_INST_0_i_5_n_0 ;
  wire \spo[42]_INST_0_i_6_n_0 ;
  wire \spo[42]_INST_0_i_7_n_0 ;
  wire \spo[42]_INST_0_i_8_n_0 ;
  wire \spo[42]_INST_0_i_9_n_0 ;
  wire \spo[43]_INST_0_i_10_n_0 ;
  wire \spo[43]_INST_0_i_1_n_0 ;
  wire \spo[43]_INST_0_i_2_n_0 ;
  wire \spo[43]_INST_0_i_3_n_0 ;
  wire \spo[43]_INST_0_i_4_n_0 ;
  wire \spo[43]_INST_0_i_5_n_0 ;
  wire \spo[43]_INST_0_i_6_n_0 ;
  wire \spo[43]_INST_0_i_7_n_0 ;
  wire \spo[43]_INST_0_i_8_n_0 ;
  wire \spo[43]_INST_0_i_9_n_0 ;
  wire \spo[44]_INST_0_i_10_n_0 ;
  wire \spo[44]_INST_0_i_1_n_0 ;
  wire \spo[44]_INST_0_i_2_n_0 ;
  wire \spo[44]_INST_0_i_3_n_0 ;
  wire \spo[44]_INST_0_i_4_n_0 ;
  wire \spo[44]_INST_0_i_5_n_0 ;
  wire \spo[44]_INST_0_i_6_n_0 ;
  wire \spo[44]_INST_0_i_7_n_0 ;
  wire \spo[44]_INST_0_i_8_n_0 ;
  wire \spo[44]_INST_0_i_9_n_0 ;
  wire \spo[45]_INST_0_i_10_n_0 ;
  wire \spo[45]_INST_0_i_1_n_0 ;
  wire \spo[45]_INST_0_i_2_n_0 ;
  wire \spo[45]_INST_0_i_3_n_0 ;
  wire \spo[45]_INST_0_i_4_n_0 ;
  wire \spo[45]_INST_0_i_5_n_0 ;
  wire \spo[45]_INST_0_i_6_n_0 ;
  wire \spo[45]_INST_0_i_7_n_0 ;
  wire \spo[45]_INST_0_i_8_n_0 ;
  wire \spo[45]_INST_0_i_9_n_0 ;
  wire \spo[46]_INST_0_i_1_n_0 ;
  wire \spo[46]_INST_0_i_2_n_0 ;
  wire \spo[46]_INST_0_i_3_n_0 ;
  wire \spo[46]_INST_0_i_4_n_0 ;
  wire \spo[46]_INST_0_i_5_n_0 ;
  wire \spo[46]_INST_0_i_6_n_0 ;
  wire \spo[47]_INST_0_i_1_n_0 ;
  wire \spo[47]_INST_0_i_2_n_0 ;
  wire \spo[47]_INST_0_i_3_n_0 ;
  wire \spo[47]_INST_0_i_4_n_0 ;
  wire \spo[47]_INST_0_i_5_n_0 ;
  wire \spo[47]_INST_0_i_6_n_0 ;
  wire \spo[48]_INST_0_i_1_n_0 ;
  wire \spo[48]_INST_0_i_2_n_0 ;
  wire \spo[4]_INST_0_i_10_n_0 ;
  wire \spo[4]_INST_0_i_1_n_0 ;
  wire \spo[4]_INST_0_i_2_n_0 ;
  wire \spo[4]_INST_0_i_3_n_0 ;
  wire \spo[4]_INST_0_i_4_n_0 ;
  wire \spo[4]_INST_0_i_5_n_0 ;
  wire \spo[4]_INST_0_i_6_n_0 ;
  wire \spo[4]_INST_0_i_7_n_0 ;
  wire \spo[4]_INST_0_i_8_n_0 ;
  wire \spo[4]_INST_0_i_9_n_0 ;
  wire \spo[50]_INST_0_i_10_n_0 ;
  wire \spo[50]_INST_0_i_1_n_0 ;
  wire \spo[50]_INST_0_i_2_n_0 ;
  wire \spo[50]_INST_0_i_3_n_0 ;
  wire \spo[50]_INST_0_i_4_n_0 ;
  wire \spo[50]_INST_0_i_5_n_0 ;
  wire \spo[50]_INST_0_i_6_n_0 ;
  wire \spo[50]_INST_0_i_7_n_0 ;
  wire \spo[50]_INST_0_i_8_n_0 ;
  wire \spo[50]_INST_0_i_9_n_0 ;
  wire \spo[51]_INST_0_i_10_n_0 ;
  wire \spo[51]_INST_0_i_1_n_0 ;
  wire \spo[51]_INST_0_i_2_n_0 ;
  wire \spo[51]_INST_0_i_3_n_0 ;
  wire \spo[51]_INST_0_i_4_n_0 ;
  wire \spo[51]_INST_0_i_5_n_0 ;
  wire \spo[51]_INST_0_i_6_n_0 ;
  wire \spo[51]_INST_0_i_7_n_0 ;
  wire \spo[51]_INST_0_i_8_n_0 ;
  wire \spo[51]_INST_0_i_9_n_0 ;
  wire \spo[52]_INST_0_i_10_n_0 ;
  wire \spo[52]_INST_0_i_1_n_0 ;
  wire \spo[52]_INST_0_i_2_n_0 ;
  wire \spo[52]_INST_0_i_3_n_0 ;
  wire \spo[52]_INST_0_i_4_n_0 ;
  wire \spo[52]_INST_0_i_5_n_0 ;
  wire \spo[52]_INST_0_i_6_n_0 ;
  wire \spo[52]_INST_0_i_7_n_0 ;
  wire \spo[52]_INST_0_i_8_n_0 ;
  wire \spo[52]_INST_0_i_9_n_0 ;
  wire \spo[53]_INST_0_i_10_n_0 ;
  wire \spo[53]_INST_0_i_1_n_0 ;
  wire \spo[53]_INST_0_i_2_n_0 ;
  wire \spo[53]_INST_0_i_3_n_0 ;
  wire \spo[53]_INST_0_i_4_n_0 ;
  wire \spo[53]_INST_0_i_5_n_0 ;
  wire \spo[53]_INST_0_i_6_n_0 ;
  wire \spo[53]_INST_0_i_7_n_0 ;
  wire \spo[53]_INST_0_i_8_n_0 ;
  wire \spo[53]_INST_0_i_9_n_0 ;
  wire \spo[54]_INST_0_i_10_n_0 ;
  wire \spo[54]_INST_0_i_1_n_0 ;
  wire \spo[54]_INST_0_i_2_n_0 ;
  wire \spo[54]_INST_0_i_3_n_0 ;
  wire \spo[54]_INST_0_i_4_n_0 ;
  wire \spo[54]_INST_0_i_5_n_0 ;
  wire \spo[54]_INST_0_i_6_n_0 ;
  wire \spo[54]_INST_0_i_7_n_0 ;
  wire \spo[54]_INST_0_i_8_n_0 ;
  wire \spo[54]_INST_0_i_9_n_0 ;
  wire \spo[55]_INST_0_i_10_n_0 ;
  wire \spo[55]_INST_0_i_1_n_0 ;
  wire \spo[55]_INST_0_i_2_n_0 ;
  wire \spo[55]_INST_0_i_3_n_0 ;
  wire \spo[55]_INST_0_i_4_n_0 ;
  wire \spo[55]_INST_0_i_5_n_0 ;
  wire \spo[55]_INST_0_i_6_n_0 ;
  wire \spo[55]_INST_0_i_7_n_0 ;
  wire \spo[55]_INST_0_i_8_n_0 ;
  wire \spo[55]_INST_0_i_9_n_0 ;
  wire \spo[56]_INST_0_i_10_n_0 ;
  wire \spo[56]_INST_0_i_1_n_0 ;
  wire \spo[56]_INST_0_i_2_n_0 ;
  wire \spo[56]_INST_0_i_3_n_0 ;
  wire \spo[56]_INST_0_i_4_n_0 ;
  wire \spo[56]_INST_0_i_5_n_0 ;
  wire \spo[56]_INST_0_i_6_n_0 ;
  wire \spo[56]_INST_0_i_7_n_0 ;
  wire \spo[56]_INST_0_i_8_n_0 ;
  wire \spo[56]_INST_0_i_9_n_0 ;
  wire \spo[57]_INST_0_i_10_n_0 ;
  wire \spo[57]_INST_0_i_1_n_0 ;
  wire \spo[57]_INST_0_i_2_n_0 ;
  wire \spo[57]_INST_0_i_3_n_0 ;
  wire \spo[57]_INST_0_i_4_n_0 ;
  wire \spo[57]_INST_0_i_5_n_0 ;
  wire \spo[57]_INST_0_i_6_n_0 ;
  wire \spo[57]_INST_0_i_7_n_0 ;
  wire \spo[57]_INST_0_i_8_n_0 ;
  wire \spo[57]_INST_0_i_9_n_0 ;
  wire \spo[58]_INST_0_i_1_n_0 ;
  wire \spo[58]_INST_0_i_2_n_0 ;
  wire \spo[58]_INST_0_i_3_n_0 ;
  wire \spo[58]_INST_0_i_4_n_0 ;
  wire \spo[59]_INST_0_i_1_n_0 ;
  wire \spo[59]_INST_0_i_2_n_0 ;
  wire \spo[59]_INST_0_i_3_n_0 ;
  wire \spo[59]_INST_0_i_4_n_0 ;
  wire \spo[59]_INST_0_i_5_n_0 ;
  wire \spo[59]_INST_0_i_6_n_0 ;
  wire \spo[5]_INST_0_i_10_n_0 ;
  wire \spo[5]_INST_0_i_1_n_0 ;
  wire \spo[5]_INST_0_i_2_n_0 ;
  wire \spo[5]_INST_0_i_3_n_0 ;
  wire \spo[5]_INST_0_i_4_n_0 ;
  wire \spo[5]_INST_0_i_5_n_0 ;
  wire \spo[5]_INST_0_i_6_n_0 ;
  wire \spo[5]_INST_0_i_7_n_0 ;
  wire \spo[5]_INST_0_i_8_n_0 ;
  wire \spo[5]_INST_0_i_9_n_0 ;
  wire \spo[60]_INST_0_i_1_n_0 ;
  wire \spo[60]_INST_0_i_2_n_0 ;
  wire \spo[60]_INST_0_i_3_n_0 ;
  wire \spo[60]_INST_0_i_4_n_0 ;
  wire \spo[60]_INST_0_i_5_n_0 ;
  wire \spo[60]_INST_0_i_6_n_0 ;
  wire \spo[62]_INST_0_i_1_n_0 ;
  wire \spo[62]_INST_0_i_2_n_0 ;
  wire \spo[6]_INST_0_i_10_n_0 ;
  wire \spo[6]_INST_0_i_1_n_0 ;
  wire \spo[6]_INST_0_i_2_n_0 ;
  wire \spo[6]_INST_0_i_3_n_0 ;
  wire \spo[6]_INST_0_i_4_n_0 ;
  wire \spo[6]_INST_0_i_5_n_0 ;
  wire \spo[6]_INST_0_i_6_n_0 ;
  wire \spo[6]_INST_0_i_7_n_0 ;
  wire \spo[6]_INST_0_i_8_n_0 ;
  wire \spo[6]_INST_0_i_9_n_0 ;
  wire \spo[7]_INST_0_i_10_n_0 ;
  wire \spo[7]_INST_0_i_1_n_0 ;
  wire \spo[7]_INST_0_i_2_n_0 ;
  wire \spo[7]_INST_0_i_3_n_0 ;
  wire \spo[7]_INST_0_i_4_n_0 ;
  wire \spo[7]_INST_0_i_5_n_0 ;
  wire \spo[7]_INST_0_i_6_n_0 ;
  wire \spo[7]_INST_0_i_7_n_0 ;
  wire \spo[7]_INST_0_i_8_n_0 ;
  wire \spo[7]_INST_0_i_9_n_0 ;
  wire \spo[8]_INST_0_i_10_n_0 ;
  wire \spo[8]_INST_0_i_1_n_0 ;
  wire \spo[8]_INST_0_i_2_n_0 ;
  wire \spo[8]_INST_0_i_3_n_0 ;
  wire \spo[8]_INST_0_i_4_n_0 ;
  wire \spo[8]_INST_0_i_5_n_0 ;
  wire \spo[8]_INST_0_i_6_n_0 ;
  wire \spo[8]_INST_0_i_7_n_0 ;
  wire \spo[8]_INST_0_i_8_n_0 ;
  wire \spo[8]_INST_0_i_9_n_0 ;
  wire \spo[9]_INST_0_i_10_n_0 ;
  wire \spo[9]_INST_0_i_1_n_0 ;
  wire \spo[9]_INST_0_i_2_n_0 ;
  wire \spo[9]_INST_0_i_3_n_0 ;
  wire \spo[9]_INST_0_i_4_n_0 ;
  wire \spo[9]_INST_0_i_5_n_0 ;
  wire \spo[9]_INST_0_i_6_n_0 ;
  wire \spo[9]_INST_0_i_7_n_0 ;
  wire \spo[9]_INST_0_i_8_n_0 ;
  wire \spo[9]_INST_0_i_9_n_0 ;

  assign dpo[63] = \<const0> ;
  assign dpo[62] = \<const0> ;
  assign dpo[61] = \<const0> ;
  assign dpo[60] = \<const0> ;
  assign dpo[59] = \<const0> ;
  assign dpo[58] = \<const0> ;
  assign dpo[57] = \<const0> ;
  assign dpo[56] = \<const0> ;
  assign dpo[55] = \<const0> ;
  assign dpo[54] = \<const0> ;
  assign dpo[53] = \<const0> ;
  assign dpo[52] = \<const0> ;
  assign dpo[51] = \<const0> ;
  assign dpo[50] = \<const0> ;
  assign dpo[49] = \<const0> ;
  assign dpo[48] = \<const0> ;
  assign dpo[47] = \<const0> ;
  assign dpo[46] = \<const0> ;
  assign dpo[45] = \<const0> ;
  assign dpo[44] = \<const0> ;
  assign dpo[43] = \<const0> ;
  assign dpo[42] = \<const0> ;
  assign dpo[41] = \<const0> ;
  assign dpo[40] = \<const0> ;
  assign dpo[39] = \<const0> ;
  assign dpo[38] = \<const0> ;
  assign dpo[37] = \<const0> ;
  assign dpo[36] = \<const0> ;
  assign dpo[35] = \<const0> ;
  assign dpo[34] = \<const0> ;
  assign dpo[33] = \<const0> ;
  assign dpo[32] = \<const0> ;
  assign dpo[31] = \<const0> ;
  assign dpo[30] = \<const0> ;
  assign dpo[29] = \<const0> ;
  assign dpo[28] = \<const0> ;
  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qdpo[63] = \<const0> ;
  assign qdpo[62] = \<const0> ;
  assign qdpo[61] = \<const0> ;
  assign qdpo[60] = \<const0> ;
  assign qdpo[59] = \<const0> ;
  assign qdpo[58] = \<const0> ;
  assign qdpo[57] = \<const0> ;
  assign qdpo[56] = \<const0> ;
  assign qdpo[55] = \<const0> ;
  assign qdpo[54] = \<const0> ;
  assign qdpo[53] = \<const0> ;
  assign qdpo[52] = \<const0> ;
  assign qdpo[51] = \<const0> ;
  assign qdpo[50] = \<const0> ;
  assign qdpo[49] = \<const0> ;
  assign qdpo[48] = \<const0> ;
  assign qdpo[47] = \<const0> ;
  assign qdpo[46] = \<const0> ;
  assign qdpo[45] = \<const0> ;
  assign qdpo[44] = \<const0> ;
  assign qdpo[43] = \<const0> ;
  assign qdpo[42] = \<const0> ;
  assign qdpo[41] = \<const0> ;
  assign qdpo[40] = \<const0> ;
  assign qdpo[39] = \<const0> ;
  assign qdpo[38] = \<const0> ;
  assign qdpo[37] = \<const0> ;
  assign qdpo[36] = \<const0> ;
  assign qdpo[35] = \<const0> ;
  assign qdpo[34] = \<const0> ;
  assign qdpo[33] = \<const0> ;
  assign qdpo[32] = \<const0> ;
  assign qdpo[31] = \<const0> ;
  assign qdpo[30] = \<const0> ;
  assign qdpo[29] = \<const0> ;
  assign qdpo[28] = \<const0> ;
  assign qdpo[27] = \<const0> ;
  assign qdpo[26] = \<const0> ;
  assign qdpo[25] = \<const0> ;
  assign qdpo[24] = \<const0> ;
  assign qdpo[23] = \<const0> ;
  assign qdpo[22] = \<const0> ;
  assign qdpo[21] = \<const0> ;
  assign qdpo[20] = \<const0> ;
  assign qdpo[19] = \<const0> ;
  assign qdpo[18] = \<const0> ;
  assign qdpo[17] = \<const0> ;
  assign qdpo[16] = \<const0> ;
  assign qdpo[15] = \<const0> ;
  assign qdpo[14] = \<const0> ;
  assign qdpo[13] = \<const0> ;
  assign qdpo[12] = \<const0> ;
  assign qdpo[11] = \<const0> ;
  assign qdpo[10] = \<const0> ;
  assign qdpo[9] = \<const0> ;
  assign qdpo[8] = \<const0> ;
  assign qdpo[7] = \<const0> ;
  assign qdpo[6] = \<const0> ;
  assign qdpo[5] = \<const0> ;
  assign qdpo[4] = \<const0> ;
  assign qdpo[3] = \<const0> ;
  assign qdpo[2] = \<const0> ;
  assign qdpo[1] = \<const0> ;
  assign qdpo[0] = \<const0> ;
  assign qspo[63] = \<const0> ;
  assign qspo[62] = \<const0> ;
  assign qspo[61] = \<const0> ;
  assign qspo[60] = \<const0> ;
  assign qspo[59] = \<const0> ;
  assign qspo[58] = \<const0> ;
  assign qspo[57] = \<const0> ;
  assign qspo[56] = \<const0> ;
  assign qspo[55] = \<const0> ;
  assign qspo[54] = \<const0> ;
  assign qspo[53] = \<const0> ;
  assign qspo[52] = \<const0> ;
  assign qspo[51] = \<const0> ;
  assign qspo[50] = \<const0> ;
  assign qspo[49] = \<const0> ;
  assign qspo[48] = \<const0> ;
  assign qspo[47] = \<const0> ;
  assign qspo[46] = \<const0> ;
  assign qspo[45] = \<const0> ;
  assign qspo[44] = \<const0> ;
  assign qspo[43] = \<const0> ;
  assign qspo[42] = \<const0> ;
  assign qspo[41] = \<const0> ;
  assign qspo[40] = \<const0> ;
  assign qspo[39] = \<const0> ;
  assign qspo[38] = \<const0> ;
  assign qspo[37] = \<const0> ;
  assign qspo[36] = \<const0> ;
  assign qspo[35] = \<const0> ;
  assign qspo[34] = \<const0> ;
  assign qspo[33] = \<const0> ;
  assign qspo[32] = \<const0> ;
  assign qspo[31] = \<const0> ;
  assign qspo[30] = \<const0> ;
  assign qspo[29] = \<const0> ;
  assign qspo[28] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[63:62] = \^spo [63:62];
  assign spo[61] = \<const1> ;
  assign spo[60:50] = \^spo [60:50];
  assign spo[49] = \<const1> ;
  assign spo[48:30] = \^spo [48:30];
  assign spo[29] = \<const1> ;
  assign spo[28:0] = \^spo [28:0];
  GND GND
       (.G(\<const0> ));
  VCC VCC
       (.P(\<const1> ));
  LUT6 #(
    .INIT(64'h02BA53C8666B27A8)) 
    g0_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b0_n_0));
  LUT6 #(
    .INIT(64'h7B3B8628F63A2100)) 
    g0_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b1_n_0));
  LUT6 #(
    .INIT(64'h794AB6913E9468BE)) 
    g0_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b10_n_0));
  LUT6 #(
    .INIT(64'h67F558392236F27E)) 
    g0_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b11_n_0));
  LUT6 #(
    .INIT(64'h0EEEE88336220354)) 
    g0_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b12_n_0));
  LUT6 #(
    .INIT(64'h9393941BF7A2CF54)) 
    g0_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b13_n_0));
  LUT6 #(
    .INIT(64'hF45EF7A6192A7B10)) 
    g0_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b14_n_0));
  LUT6 #(
    .INIT(64'hA7CB0D3EA08DD338)) 
    g0_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b15_n_0));
  LUT6 #(
    .INIT(64'h3839563E6ACFC9A0)) 
    g0_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b16_n_0));
  LUT6 #(
    .INIT(64'h6AAD983E19A56DC0)) 
    g0_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b17_n_0));
  LUT6 #(
    .INIT(64'hE664B56B52C98E00)) 
    g0_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b18_n_0));
  LUT6 #(
    .INIT(64'hB4B6D9B39CF1F000)) 
    g0_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b19_n_0));
  LUT6 #(
    .INIT(64'hE69207A5807213D0)) 
    g0_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b2_n_0));
  LUT6 #(
    .INIT(64'hC738E1C3E0FE0000)) 
    g0_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b20_n_0));
  LUT6 #(
    .INIT(64'hAD6A54A955AAAAAA)) 
    g0_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b21_n_0));
  LUT6 #(
    .INIT(64'h9CE63398CC666666)) 
    g0_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b22_n_0));
  LUT6 #(
    .INIT(64'h83E1F0783C1E1E1E)) 
    g0_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b23_n_0));
  LUT6 #(
    .INIT(64'h7FE00FF803FE01FE)) 
    g0_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b24_n_0));
  LUT6 #(
    .INIT(64'h001FFFF80001FFFE)) 
    g0_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b25_n_0));
  LUT6 #(
    .INIT(64'h00000007FFFFFFFE)) 
    g0_b26
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b26_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    g0_b28
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b28_n_0));
  LUT6 #(
    .INIT(64'h94DD39D78D20FF8A)) 
    g0_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b3_n_0));
  LUT6 #(
    .INIT(64'hF6E4CF23A82F7CC8)) 
    g0_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b30_n_0));
  LUT6 #(
    .INIT(64'hD11D2CF227E765E7)) 
    g0_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b31_n_0));
  LUT6 #(
    .INIT(64'h4FFCB2E0532EA7F5)) 
    g0_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b32_n_0));
  LUT6 #(
    .INIT(64'hC00394EBDE0C559F)) 
    g0_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b33_n_0));
  LUT6 #(
    .INIT(64'hA666142A527E4291)) 
    g0_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b34_n_0));
  LUT6 #(
    .INIT(64'h43C3AFA2BFC6A3FD)) 
    g0_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b35_n_0));
  LUT6 #(
    .INIT(64'h7E813D270BD64109)) 
    g0_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b36_n_0));
  LUT6 #(
    .INIT(64'hD4FF69DEAC337F51)) 
    g0_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b37_n_0));
  LUT6 #(
    .INIT(64'h98FF1B54CFF12A61)) 
    g0_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b38_n_0));
  LUT6 #(
    .INIT(64'hE0FF07325AA5B381)) 
    g0_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b39_n_0));
  LUT6 #(
    .INIT(64'h6BD380C77B6C1742)) 
    g0_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b4_n_0));
  LUT6 #(
    .INIT(64'hAA55AA5B6CC63C01)) 
    g0_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b40_n_0));
  LUT6 #(
    .INIT(64'hCC99CC638F07C001)) 
    g0_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b41_n_0));
  LUT6 #(
    .INIT(64'h5A4B5AD6A552AAAB)) 
    g0_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b42_n_0));
  LUT6 #(
    .INIT(64'hC638C6319CCE6667)) 
    g0_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b43_n_0));
  LUT6 #(
    .INIT(64'h3E07C1F07C3E1E1F)) 
    g0_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b44_n_0));
  LUT6 #(
    .INIT(64'hFE003FF003FE01FF)) 
    g0_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b45_n_0));
  LUT6 #(
    .INIT(64'h01FFFFF00001FFFF)) 
    g0_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b46_n_0));
  LUT6 #(
    .INIT(64'hE6493BCFEAF711AA)) 
    g0_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b5_n_0));
  LUT6 #(
    .INIT(64'h8FF732AC747CFE6E)) 
    g0_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b50_n_0));
  LUT6 #(
    .INIT(64'hB2E0901760406970)) 
    g0_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b51_n_0));
  LUT6 #(
    .INIT(64'h42E0718D2AE94E7F)) 
    g0_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b52_n_0));
  LUT6 #(
    .INIT(64'h02E00F8319DB252A)) 
    g0_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b53_n_0));
  LUT6 #(
    .INIT(64'h57B5552A529249B3)) 
    g0_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b54_n_0));
  LUT6 #(
    .INIT(64'h31933366C9B6DB69)) 
    g0_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b55_n_0));
  LUT6 #(
    .INIT(64'hF070F0E1C78E38E7)) 
    g0_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b56_n_0));
  LUT6 #(
    .INIT(64'h0FF00FE03F81F81F)) 
    g0_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b57_n_0));
  LUT6 #(
    .INIT(64'hFFF0001FFF8007FF)) 
    g0_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b58_n_0));
  LUT6 #(
    .INIT(64'hFFF00000007FFFFF)) 
    g0_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b59_n_0));
  LUT6 #(
    .INIT(64'h2204AFBA477F0CC6)) 
    g0_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h1FFF)) 
    g0_b60
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g0_b60_n_0));
  LUT6 #(
    .INIT(64'h60421B7A7865C206)) 
    g0_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b7_n_0));
  LUT6 #(
    .INIT(64'h2D944AF81D3FBECE)) 
    g0_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b8_n_0));
  LUT6 #(
    .INIT(64'h94182860EB17181E)) 
    g0_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g0_b9_n_0));
  LUT6 #(
    .INIT(64'h191DF086E07ADDB1)) 
    g10_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b0_n_0));
  LUT6 #(
    .INIT(64'hF7A8718DF16990BB)) 
    g10_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b1_n_0));
  LUT6 #(
    .INIT(64'h5FA83C4EC5DE8BD2)) 
    g10_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b10_n_0));
  LUT6 #(
    .INIT(64'h168718AA20D94183)) 
    g10_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b11_n_0));
  LUT6 #(
    .INIT(64'h6C975AE242CF7A5E)) 
    g10_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b12_n_0));
  LUT6 #(
    .INIT(64'h7DD8CCE77E6F2C34)) 
    g10_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b13_n_0));
  LUT6 #(
    .INIT(64'h83B56F1ED48F1AA7)) 
    g10_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b14_n_0));
  LUT6 #(
    .INIT(64'h0073255498F0F992)) 
    g10_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b15_n_0));
  LUT6 #(
    .INIT(64'h000F1CCDB5AAAD24)) 
    g10_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b16_n_0));
  LUT6 #(
    .INIT(64'hAAAA5696D93331C7)) 
    g10_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b17_n_0));
  LUT6 #(
    .INIT(64'h9999324DB49694AD)) 
    g10_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b18_n_0));
  LUT6 #(
    .INIT(64'hD2D25B6926DB26C9)) 
    g10_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b19_n_0));
  LUT6 #(
    .INIT(64'h2B4B4D59A128B2F2)) 
    g10_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b2_n_0));
  LUT6 #(
    .INIT(64'hB64936DB6DB6925B)) 
    g10_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b20_n_0));
  LUT6 #(
    .INIT(64'h71C70E38E38E71C7)) 
    g10_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b21_n_0));
  LUT6 #(
    .INIT(64'h0FC0FE07E07E0FC0)) 
    g10_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b22_n_0));
  LUT6 #(
    .INIT(64'hFFC001FFE001FFC0)) 
    g10_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b23_n_0));
  LUT6 #(
    .INIT(64'h003FFFFFE000003F)) 
    g10_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b24_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFE0000000)) 
    g10_b26
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b26_n_0));
  LUT6 #(
    .INIT(64'h000000001FFFFFFF)) 
    g10_b27
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b27_n_0));
  LUT6 #(
    .INIT(64'hF0AC4479DC0063A7)) 
    g10_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b3_n_0));
  LUT6 #(
    .INIT(64'h67F63A7096A75C41)) 
    g10_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b30_n_0));
  LUT6 #(
    .INIT(64'h3C491AA97D5EAE49)) 
    g10_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b31_n_0));
  LUT6 #(
    .INIT(64'h24E39423BBBA20CC)) 
    g10_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b32_n_0));
  LUT6 #(
    .INIT(64'hFF91A904E4E506FD)) 
    g10_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b33_n_0));
  LUT6 #(
    .INIT(64'hBD0A6F42E8421679)) 
    g10_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b34_n_0));
  LUT6 #(
    .INIT(64'h3CAC1A7E4FD40C84)) 
    g10_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b35_n_0));
  LUT6 #(
    .INIT(64'hC39AAC7E2567FDA9)) 
    g10_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b36_n_0));
  LUT6 #(
    .INIT(64'hAAD3307E1CD2A931)) 
    g10_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b37_n_0));
  LUT6 #(
    .INIT(64'hCCE3C07E03CE6494)) 
    g10_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b38_n_0));
  LUT6 #(
    .INIT(64'h5A56AAD4AA94B6D9)) 
    g10_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b39_n_0));
  LUT6 #(
    .INIT(64'h81C90CBAA48E1942)) 
    g10_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b4_n_0));
  LUT6 #(
    .INIT(64'h6C9B33673318C71E)) 
    g10_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b40_n_0));
  LUT6 #(
    .INIT(64'h25B696D296B5AD4A)) 
    g10_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b41_n_0));
  LUT6 #(
    .INIT(64'hE38E71CE718C6339)) 
    g10_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b42_n_0));
  LUT6 #(
    .INIT(64'hE07E0FC1F07C1F07)) 
    g10_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b43_n_0));
  LUT6 #(
    .INIT(64'hE001FFC00FFC00FF)) 
    g10_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b44_n_0));
  LUT6 #(
    .INIT(64'hE000003FFFFC0000)) 
    g10_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b45_n_0));
  LUT6 #(
    .INIT(64'hE00000000003FFFF)) 
    g10_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b46_n_0));
  LUT6 #(
    .INIT(64'h1FFFFFFFFFFFFFFF)) 
    g10_b47
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b47_n_0));
  LUT6 #(
    .INIT(64'h7F3985D3F3BDF100)) 
    g10_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b5_n_0));
  LUT6 #(
    .INIT(64'hC606E48819EC45FD)) 
    g10_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b50_n_0));
  LUT6 #(
    .INIT(64'h52102140980BD56C)) 
    g10_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b51_n_0));
  LUT6 #(
    .INIT(64'h307592F58EAA7E41)) 
    g10_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b52_n_0));
  LUT6 #(
    .INIT(64'hA4A6DB66ECCC678E)) 
    g10_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b53_n_0));
  LUT6 #(
    .INIT(64'h926DB6D25A5AD2A5)) 
    g10_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b54_n_0));
  LUT6 #(
    .INIT(64'h71E38E31C639CE63)) 
    g10_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b55_n_0));
  LUT6 #(
    .INIT(64'hF01F81F03E07C1E0)) 
    g10_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b56_n_0));
  LUT6 #(
    .INIT(64'hF0007FF001FFC01F)) 
    g10_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b57_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h3FFC007F)) 
    g10_b58
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g10_b58_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFE00)) 
    g10_b59
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g10_b59_n_0));
  LUT6 #(
    .INIT(64'h00BF981C49F40A98)) 
    g10_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h01FF)) 
    g10_b60
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g10_b60_n_0));
  LUT6 #(
    .INIT(64'h99F6941FD0E0CA3D)) 
    g10_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b7_n_0));
  LUT6 #(
    .INIT(64'h9685994A9FBD284D)) 
    g10_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b8_n_0));
  LUT6 #(
    .INIT(64'h56B5F80A860F85B5)) 
    g10_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g10_b9_n_0));
  LUT6 #(
    .INIT(64'hDEAC3561288D803C)) 
    g11_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b0_n_0));
  LUT6 #(
    .INIT(64'hF19ED75E21D885E0)) 
    g11_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b1_n_0));
  LUT6 #(
    .INIT(64'h7BC07CFAD7C6D8AC)) 
    g11_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b10_n_0));
  LUT6 #(
    .INIT(64'h6EDDC78EDC76DBD2)) 
    g11_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b11_n_0));
  LUT6 #(
    .INIT(64'h9B3628519D7333A1)) 
    g11_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b12_n_0));
  LUT6 #(
    .INIT(64'hF9581A9FB6715C6A)) 
    g11_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b13_n_0));
  LUT6 #(
    .INIT(64'h5260064AD870CAB3)) 
    g11_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b14_n_0));
  LUT6 #(
    .INIT(64'h638001C64ADA933C)) 
    g11_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b15_n_0));
  LUT6 #(
    .INIT(64'h2955556B6C9CE3C0)) 
    g11_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b16_n_0));
  LUT6 #(
    .INIT(64'hE7333326DA4A56AA)) 
    g11_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b17_n_0));
  LUT6 #(
    .INIT(64'h1F0F0F1E39C63199)) 
    g11_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b18_n_0));
  LUT6 #(
    .INIT(64'hAA55AA54AD6B5AD2)) 
    g11_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b19_n_0));
  LUT6 #(
    .INIT(64'h316E58D134989364)) 
    g11_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b2_n_0));
  LUT6 #(
    .INIT(64'h66CC993264D93649)) 
    g11_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b20_n_0));
  LUT6 #(
    .INIT(64'h1E3C78F1E3C70E38)) 
    g11_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b21_n_0));
  LUT6 #(
    .INIT(64'hFE03F80FE03F01F8)) 
    g11_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b22_n_0));
  LUT6 #(
    .INIT(64'h01FFF8001FFF0007)) 
    g11_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b23_n_0));
  LUT6 #(
    .INIT(64'h000007FFFFFF0000)) 
    g11_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b24_n_0));
  LUT6 #(
    .INIT(64'h10413A6F8DAE1DED)) 
    g11_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b3_n_0));
  LUT6 #(
    .INIT(64'hF40D4AAC28FEFEC8)) 
    g11_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b30_n_0));
  LUT6 #(
    .INIT(64'h06A4C6654FD7D184)) 
    g11_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b31_n_0));
  LUT6 #(
    .INIT(64'h3405A7854301AC9B)) 
    g11_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b32_n_0));
  LUT6 #(
    .INIT(64'h1AEB16EBAE2247F1)) 
    g11_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b33_n_0));
  LUT6 #(
    .INIT(64'hF4E5F31A1BEBD7A0)) 
    g11_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b34_n_0));
  LUT6 #(
    .INIT(64'hA71CA406AC196795)) 
    g11_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b35_n_0));
  LUT6 #(
    .INIT(64'hC7FC6D54CFF8D2D9)) 
    g11_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b36_n_0));
  LUT6 #(
    .INIT(64'hAD56B6670FF831B4)) 
    g11_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b37_n_0));
  LUT6 #(
    .INIT(64'h9CCD92D2A552A526)) 
    g11_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b38_n_0));
  LUT6 #(
    .INIT(64'h7C3C71CE63366C92)) 
    g11_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b39_n_0));
  LUT6 #(
    .INIT(64'h0386F0D3C53DAE29)) 
    g11_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b4_n_0));
  LUT6 #(
    .INIT(64'h56A95A94B5A4B6DB)) 
    g11_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b40_n_0));
  LUT6 #(
    .INIT(64'hCD9B364D936D9249)) 
    g11_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b41_n_0));
  LUT6 #(
    .INIT(64'hC3870E3C70E38E38)) 
    g11_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b42_n_0));
  LUT6 #(
    .INIT(64'hC07F01FC0FE07E07)) 
    g11_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b43_n_0));
  LUT6 #(
    .INIT(64'h3FFF0003FFE001FF)) 
    g11_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b44_n_0));
  LUT6 #(
    .INIT(64'hFFFF0000001FFFFF)) 
    g11_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b45_n_0));
  LUT6 #(
    .INIT(64'h92A9389E676DF55D)) 
    g11_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b5_n_0));
  LUT6 #(
    .INIT(64'h5FE3E9B1EE381FEE)) 
    g11_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b50_n_0));
  LUT6 #(
    .INIT(64'h8EEBE7BBDAA18DCE)) 
    g11_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b51_n_0));
  LUT6 #(
    .INIT(64'h0F1400443E1D3420)) 
    g11_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b52_n_0));
  LUT6 #(
    .INIT(64'hA555555554A856B4)) 
    g11_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b53_n_0));
  LUT6 #(
    .INIT(64'h9CCCCCCCCD9B326D)) 
    g11_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b54_n_0));
  LUT6 #(
    .INIT(64'h83C3C3C3C3870E1C)) 
    g11_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b55_n_0));
  LUT6 #(
    .INIT(64'h7FC03FC03F80FE03)) 
    g11_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b56_n_0));
  LUT6 #(
    .INIT(64'hFFC0003FFF8001FF)) 
    g11_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b57_n_0));
  LUT6 #(
    .INIT(64'h003FFFFFFF800000)) 
    g11_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b58_n_0));
  LUT6 #(
    .INIT(64'h6665E42DA64CE01F)) 
    g11_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b6_n_0));
  LUT6 #(
    .INIT(64'hC87ADB7432D91772)) 
    g11_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b7_n_0));
  LUT6 #(
    .INIT(64'h2E91249F085D3EB8)) 
    g11_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b8_n_0));
  LUT6 #(
    .INIT(64'hE4F5E85DEEB3E3B1)) 
    g11_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g11_b9_n_0));
  LUT6 #(
    .INIT(64'h87578ED70A254DA8)) 
    g12_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b0_n_0));
  LUT6 #(
    .INIT(64'h783F2FBFDF7C01D8)) 
    g12_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b1_n_0));
  LUT6 #(
    .INIT(64'hFA5FF332D2D332FA)) 
    g12_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b10_n_0));
  LUT6 #(
    .INIT(64'h117774B46B94B58D)) 
    g12_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b11_n_0));
  LUT6 #(
    .INIT(64'h0A7272CD7912CD05)) 
    g12_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b12_n_0));
  LUT6 #(
    .INIT(64'hF92471A98744FCA9)) 
    g12_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b13_n_0));
  LUT6 #(
    .INIT(64'hADB87064AA67039B)) 
    g12_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b14_n_0));
  LUT6 #(
    .INIT(64'h31C0701C66D2AAD2)) 
    g12_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b15_n_0));
  LUT6 #(
    .INIT(64'h3E007003E1CE6649)) 
    g12_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b16_n_0));
  LUT6 #(
    .INIT(64'h3FFF8FFFE03E1E38)) 
    g12_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b17_n_0));
  LUT6 #(
    .INIT(64'hC00000001FFE01F8)) 
    g12_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b18_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAAAAAAB5552)) 
    g12_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b19_n_0));
  LUT6 #(
    .INIT(64'h0BDBE1A41FE19070)) 
    g12_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b2_n_0));
  LUT6 #(
    .INIT(64'h9999999999993336)) 
    g12_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b20_n_0));
  LUT6 #(
    .INIT(64'h8787878787870F0E)) 
    g12_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b21_n_0));
  LUT6 #(
    .INIT(64'h7F807F807F80FF01)) 
    g12_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b22_n_0));
  LUT6 #(
    .INIT(64'h007FFF80007FFF00)) 
    g12_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b23_n_0));
  LUT6 #(
    .INIT(64'h0000007FFFFFFF00)) 
    g12_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hFE)) 
    g12_b25
       (.I0(a[3]),
        .I1(a[4]),
        .I2(a[5]),
        .O(g12_b25_n_0));
  LUT6 #(
    .INIT(64'h331AAA142B119C3E)) 
    g12_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b3_n_0));
  LUT6 #(
    .INIT(64'h3C72AF59AAF1FDA2)) 
    g12_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b30_n_0));
  LUT6 #(
    .INIT(64'hB39AB443DB841436)) 
    g12_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b31_n_0));
  LUT6 #(
    .INIT(64'hADC115F1881F2A5D)) 
    g12_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b32_n_0));
  LUT6 #(
    .INIT(64'hD271A48A56F74422)) 
    g12_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b33_n_0));
  LUT6 #(
    .INIT(64'h5E8A71069E58D7EB)) 
    g12_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b34_n_0));
  LUT6 #(
    .INIT(64'h61AC0CAB1E3567E6)) 
    g12_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b35_n_0));
  LUT6 #(
    .INIT(64'hD53016CC1E0CD2B4)) 
    g12_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b36_n_0));
  LUT6 #(
    .INIT(64'hCC9558F01E03CE6D)) 
    g12_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b37_n_0));
  LUT6 #(
    .INIT(64'h96D980FFE1FFC1E3)) 
    g12_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b38_n_0));
  LUT6 #(
    .INIT(64'h18E1FF0000003FE0)) 
    g12_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b39_n_0));
  LUT6 #(
    .INIT(64'h7C818A258C91AEB2)) 
    g12_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b4_n_0));
  LUT6 #(
    .INIT(64'h1F01EAAAAAAAAAB5)) 
    g12_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b40_n_0));
  LUT6 #(
    .INIT(64'hB554A6666666666C)) 
    g12_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b41_n_0));
  LUT6 #(
    .INIT(64'h8CCC61E1E1E1E1E3)) 
    g12_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b42_n_0));
  LUT6 #(
    .INIT(64'h83C3E01FE01FE01F)) 
    g12_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b43_n_0));
  LUT6 #(
    .INIT(64'h803FE0001FFFE000)) 
    g12_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b44_n_0));
  LUT6 #(
    .INIT(64'h7FFFE00000001FFF)) 
    g12_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b45_n_0));
  LUT6 #(
    .INIT(64'h99C2C85D7057F59F)) 
    g12_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b5_n_0));
  LUT6 #(
    .INIT(64'hAE32251313288D21)) 
    g12_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b50_n_0));
  LUT6 #(
    .INIT(64'hAC4BECE79789CFD2)) 
    g12_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b51_n_0));
  LUT6 #(
    .INIT(64'hE45EBC05634ED07C)) 
    g12_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b52_n_0));
  LUT6 #(
    .INIT(64'h376CCAC6615A752A)) 
    g12_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b53_n_0));
  LUT6 #(
    .INIT(64'h6D25A5AD28C63319)) 
    g12_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b54_n_0));
  LUT6 #(
    .INIT(64'h1CE39C63183E0F07)) 
    g12_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b55_n_0));
  LUT6 #(
    .INIT(64'hFC1F83E0F801FF00)) 
    g12_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b56_n_0));
  LUT6 #(
    .INIT(64'h03FF801FF80000FF)) 
    g12_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b57_n_0));
  LUT6 #(
    .INIT(64'h00007FFFF8000000)) 
    g12_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b58_n_0));
  LUT6 #(
    .INIT(64'hA58FC5B8FFC71F47)) 
    g12_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b6_n_0));
  LUT6 #(
    .INIT(64'hFFFFE00007FFFFFF)) 
    g12_b62
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b62_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFF8000000)) 
    g12_b63
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b63_n_0));
  LUT6 #(
    .INIT(64'hF0374BD400320889)) 
    g12_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b7_n_0));
  LUT6 #(
    .INIT(64'h842F9819555BFAFA)) 
    g12_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b8_n_0));
  LUT6 #(
    .INIT(64'h2C3547E1999C0653)) 
    g12_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g12_b9_n_0));
  LUT6 #(
    .INIT(64'hDA9E20062BEBB3BB)) 
    g13_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b0_n_0));
  LUT6 #(
    .INIT(64'hB9C01FB38A1F3125)) 
    g13_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b1_n_0));
  LUT6 #(
    .INIT(64'hEB64A446BD83060C)) 
    g13_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b10_n_0));
  LUT6 #(
    .INIT(64'hE33D17036CF4BC2D)) 
    g13_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b11_n_0));
  LUT6 #(
    .INIT(64'h4CE9F27EB3A797E6)) 
    g13_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b12_n_0));
  LUT6 #(
    .INIT(64'h701B5B81953872B7)) 
    g13_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b13_n_0));
  LUT6 #(
    .INIT(64'h7FF8C955263FF192)) 
    g13_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b14_n_0));
  LUT6 #(
    .INIT(64'h7FF838CC92955ADB)) 
    g13_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b15_n_0));
  LUT6 #(
    .INIT(64'h2AAD5296DB26631C)) 
    g13_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b16_n_0));
  LUT6 #(
    .INIT(64'h4CCE6318E3C783E0)) 
    g13_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b17_n_0));
  LUT6 #(
    .INIT(64'h70F07C1F03F803FF)) 
    g13_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b18_n_0));
  LUT6 #(
    .INIT(64'hD5AAD54AA95556AA)) 
    g13_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b19_n_0));
  LUT6 #(
    .INIT(64'hBB92DA3A5EF40876)) 
    g13_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b2_n_0));
  LUT6 #(
    .INIT(64'h3399CCC667333199)) 
    g13_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b20_n_0));
  LUT6 #(
    .INIT(64'hF0783C3E1F0F0F87)) 
    g13_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b21_n_0));
  LUT6 #(
    .INIT(64'hF007FC01FF00FF80)) 
    g13_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b22_n_0));
  LUT6 #(
    .INIT(64'h0FFFFC0000FFFF80)) 
    g13_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b23_n_0));
  LUT6 #(
    .INIT(64'h000003FFFFFFFF80)) 
    g13_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b24_n_0));
  LUT6 #(
    .INIT(64'h53601A31DCC72EE0)) 
    g13_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b3_n_0));
  LUT6 #(
    .INIT(64'hA30889F8AFFF28DC)) 
    g13_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b30_n_0));
  LUT6 #(
    .INIT(64'hC0AFAF456EEE0B8D)) 
    g13_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b31_n_0));
  LUT6 #(
    .INIT(64'h660356B07D7D85CA)) 
    g13_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b32_n_0));
  LUT6 #(
    .INIT(64'hC3BB76E23892472B)) 
    g13_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b33_n_0));
  LUT6 #(
    .INIT(64'h7EC67314105E821C)) 
    g13_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b34_n_0));
  LUT6 #(
    .INIT(64'h7E5471580A9E5405)) 
    g13_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b35_n_0));
  LUT6 #(
    .INIT(64'h7E32DA60064B67FC)) 
    g13_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b36_n_0));
  LUT6 #(
    .INIT(64'h81F1C92AAB6C7803)) 
    g13_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b37_n_0));
  LUT6 #(
    .INIT(64'h000FC71999252AAA)) 
    g13_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b38_n_0));
  LUT6 #(
    .INIT(64'h55556A52D249B333)) 
    g13_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b39_n_0));
  LUT6 #(
    .INIT(64'hE3674D07CC120216)) 
    g13_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b4_n_0));
  LUT6 #(
    .INIT(64'h6666739CE38E3C3C)) 
    g13_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b40_n_0));
  LUT6 #(
    .INIT(64'hD2D2D6B5A95A956A)) 
    g13_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b41_n_0));
  LUT6 #(
    .INIT(64'hCE31CE7398C67319)) 
    g13_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b42_n_0));
  LUT6 #(
    .INIT(64'h3E0FC1F0783E0F07)) 
    g13_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b43_n_0));
  LUT6 #(
    .INIT(64'hFE003FF007FE00FF)) 
    g13_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b44_n_0));
  LUT6 #(
    .INIT(64'hFE00000FFFFE0000)) 
    g13_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b45_n_0));
  LUT6 #(
    .INIT(64'hFE0000000001FFFF)) 
    g13_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b46_n_0));
  LUT6 #(
    .INIT(64'h01FFFFFFFFFFFFFF)) 
    g13_b47
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b47_n_0));
  LUT6 #(
    .INIT(64'h033CA3856D28DCA6)) 
    g13_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b5_n_0));
  LUT6 #(
    .INIT(64'h7C407102883929C2)) 
    g13_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b50_n_0));
  LUT6 #(
    .INIT(64'hEE4CCE44500193B2)) 
    g13_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b51_n_0));
  LUT6 #(
    .INIT(64'hFC3C3EE3A9989969)) 
    g13_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b52_n_0));
  LUT6 #(
    .INIT(64'hA956AB4AD2D2D24D)) 
    g13_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b53_n_0));
  LUT6 #(
    .INIT(64'h9B3266D9B649B6DB)) 
    g13_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b54_n_0));
  LUT6 #(
    .INIT(64'h78F1E1C78E3871C7)) 
    g13_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b55_n_0));
  LUT6 #(
    .INIT(64'hF80FE03F81F80FC0)) 
    g13_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b56_n_0));
  LUT6 #(
    .INIT(64'hF8001FFF8007FFC0)) 
    g13_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b57_n_0));
  LUT6 #(
    .INIT(64'hF80000007FFFFFC0)) 
    g13_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b58_n_0));
  LUT6 #(
    .INIT(64'hF80000000000003F)) 
    g13_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b59_n_0));
  LUT6 #(
    .INIT(64'h5642EE4ABF88BF39)) 
    g13_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b6_n_0));
  LUT6 #(
    .INIT(64'h07FFFFFFFFFFFFFF)) 
    g13_b60
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b60_n_0));
  LUT6 #(
    .INIT(64'h9B81B17BB8EBE659)) 
    g13_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b7_n_0));
  LUT6 #(
    .INIT(64'h2F33594A09D08F16)) 
    g13_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b8_n_0));
  LUT6 #(
    .INIT(64'h887843648C17204F)) 
    g13_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g13_b9_n_0));
  LUT6 #(
    .INIT(64'h6DC7AC20FFA225E9)) 
    g14_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b0_n_0));
  LUT6 #(
    .INIT(64'h785DF78A77414486)) 
    g14_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b1_n_0));
  LUT6 #(
    .INIT(64'h1C5FFF9249D51B1C)) 
    g14_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b10_n_0));
  LUT6 #(
    .INIT(64'hF7D0BD0BD0920CA2)) 
    g14_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b11_n_0));
  LUT6 #(
    .INIT(64'h0D6069F96044053E)) 
    g14_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b12_n_0));
  LUT6 #(
    .INIT(64'hFCD54E072A98036B)) 
    g14_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b13_n_0));
  LUT6 #(
    .INIT(64'hA9667000E64AAA4C)) 
    g14_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b14_n_0));
  LUT6 #(
    .INIT(64'h64D2D5554B6CCC70)) 
    g14_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b15_n_0));
  LUT6 #(
    .INIT(64'hE3CE333326DA5AD5)) 
    g14_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b16_n_0));
  LUT6 #(
    .INIT(64'hB56B5A5A4B6C9366)) 
    g14_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b17_n_0));
  LUT6 #(
    .INIT(64'h398C639C738F1C78)) 
    g14_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b18_n_0));
  LUT6 #(
    .INIT(64'h6B5AD6B5295AB52A)) 
    g14_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b19_n_0));
  LUT6 #(
    .INIT(64'h359B2BA5C6CB9A49)) 
    g14_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b2_n_0));
  LUT6 #(
    .INIT(64'h18C6318CE7398CE6)) 
    g14_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b20_n_0));
  LUT6 #(
    .INIT(64'h07C1F07C1F0783E1)) 
    g14_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b21_n_0));
  LUT6 #(
    .INIT(64'hFFC00FFC00FF801F)) 
    g14_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b22_n_0));
  LUT6 #(
    .INIT(64'hFFC00003FFFF8000)) 
    g14_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b23_n_0));
  LUT6 #(
    .INIT(64'h003FFFFFFFFF8000)) 
    g14_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b24_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFF8000)) 
    g14_b27
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b27_n_0));
  LUT6 #(
    .INIT(64'h0000000000007FFF)) 
    g14_b28
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b28_n_0));
  LUT6 #(
    .INIT(64'hB54ECE1DB919944F)) 
    g14_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b3_n_0));
  LUT6 #(
    .INIT(64'hB6910CB6BF2AA28C)) 
    g14_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b30_n_0));
  LUT6 #(
    .INIT(64'h7A64F6772A9999A6)) 
    g14_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b31_n_0));
  LUT6 #(
    .INIT(64'hCF9F346E554B4B51)) 
    g14_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b32_n_0));
  LUT6 #(
    .INIT(64'h2EF74FC3DDD629DD)) 
    g14_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b33_n_0));
  LUT6 #(
    .INIT(64'hE4F27D7E9C9EB763)) 
    g14_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b34_n_0));
  LUT6 #(
    .INIT(64'hE25B832B1C4B3F2A)) 
    g14_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b35_n_0));
  LUT6 #(
    .INIT(64'h1E36AA4C1C396A4C)) 
    g14_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b36_n_0));
  LUT6 #(
    .INIT(64'hFE0E66DAB6ADB38F)) 
    g14_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b37_n_0));
  LUT6 #(
    .INIT(64'hAB54B4932731C3F0)) 
    g14_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b38_n_0));
  LUT6 #(
    .INIT(64'h99326DB69294A955)) 
    g14_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b39_n_0));
  LUT6 #(
    .INIT(64'h315DF11A808BCD56)) 
    g14_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b4_n_0));
  LUT6 #(
    .INIT(64'h2DA4B6DB24D93266)) 
    g14_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b40_n_0));
  LUT6 #(
    .INIT(64'h9B6D92496DB496D2)) 
    g14_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b41_n_0));
  LUT6 #(
    .INIT(64'h871C71C71C738E31)) 
    g14_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b42_n_0));
  LUT6 #(
    .INIT(64'h80FC0FC0FC0F81F0)) 
    g14_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b43_n_0));
  LUT6 #(
    .INIT(64'h8003FFC003FF800F)) 
    g14_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b44_n_0));
  LUT6 #(
    .INIT(64'h7FFFFFC000007FFF)) 
    g14_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b45_n_0));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h0007FFFF)) 
    g14_b46
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g14_b46_n_0));
  LUT6 #(
    .INIT(64'h9918CC68D503257A)) 
    g14_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b5_n_0));
  LUT6 #(
    .INIT(64'hFB606DD34E206170)) 
    g14_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b50_n_0));
  LUT6 #(
    .INIT(64'h6C19EEBE2EBFE1AE)) 
    g14_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b51_n_0));
  LUT6 #(
    .INIT(64'h8E1E6B17F1401613)) 
    g14_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b52_n_0));
  LUT6 #(
    .INIT(64'hA54AC542AAAAAAAA)) 
    g14_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b53_n_0));
  LUT6 #(
    .INIT(64'h9CC6233199999999)) 
    g14_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b54_n_0));
  LUT6 #(
    .INIT(64'h83C1E0F078787878)) 
    g14_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b55_n_0));
  LUT6 #(
    .INIT(64'h803FE00FF807F807)) 
    g14_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b56_n_0));
  LUT6 #(
    .INIT(64'h80001FFFF80007FF)) 
    g14_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b57_n_0));
  LUT6 #(
    .INIT(64'h8000000007FFFFFF)) 
    g14_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b58_n_0));
  LUT6 #(
    .INIT(64'h74652DC17F9F8DC3)) 
    g14_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b6_n_0));
  LUT6 #(
    .INIT(64'h3FE52AE3BBC288C3)) 
    g14_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b7_n_0));
  LUT6 #(
    .INIT(64'hB76BF46E4E70170F)) 
    g14_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b8_n_0));
  LUT6 #(
    .INIT(64'hFEA924FDB7123BB7)) 
    g14_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g14_b9_n_0));
  LUT6 #(
    .INIT(64'h0A6C1BA0937BEDD9)) 
    g15_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b0_n_0));
  LUT6 #(
    .INIT(64'h3F98553385584678)) 
    g15_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b1_n_0));
  LUT6 #(
    .INIT(64'hB480F3F3C7D41A7F)) 
    g15_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b10_n_0));
  LUT6 #(
    .INIT(64'h32FAF5EBD7A4A685)) 
    g15_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b11_n_0));
  LUT6 #(
    .INIT(64'h64F9A61967913E56)) 
    g15_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b12_n_0));
  LUT6 #(
    .INIT(64'hB8F86D5278736B67)) 
    g15_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b13_n_0));
  LUT6 #(
    .INIT(64'h95AD499C7FF0E6D2)) 
    g15_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b14_n_0));
  LUT6 #(
    .INIT(64'hD9318E1F800FE1CE)) 
    g15_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b15_n_0));
  LUT6 #(
    .INIT(64'h1E3E0FE000001FC1)) 
    g15_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b16_n_0));
  LUT6 #(
    .INIT(64'hB56AA5555555556A)) 
    g15_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b17_n_0));
  LUT6 #(
    .INIT(64'hD9B3366666666673)) 
    g15_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b18_n_0));
  LUT6 #(
    .INIT(64'h4B696D2D2D2D2D29)) 
    g15_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b19_n_0));
  LUT6 #(
    .INIT(64'hE39194AE21ACD011)) 
    g15_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b2_n_0));
  LUT6 #(
    .INIT(64'h38E71CE31CE31CE7)) 
    g15_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b20_n_0));
  LUT6 #(
    .INIT(64'h07E0FC1F03E0FC1F)) 
    g15_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b21_n_0));
  LUT6 #(
    .INIT(64'hFFE003FF001FFC00)) 
    g15_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b22_n_0));
  LUT6 #(
    .INIT(64'h001FFFFF000003FF)) 
    g15_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b23_n_0));
  LUT6 #(
    .INIT(64'h5F50CFCF5F50C0C0)) 
    g15_b25
       (.I0(a[5]),
        .I1(g14_b27_n_0),
        .I2(a[7]),
        .I3(g4_b47_n_0),
        .I4(a[6]),
        .I5(g12_b25_n_0),
        .O(g15_b25_n_0));
  LUT6 #(
    .INIT(64'h45CA76D23D250579)) 
    g15_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b3_n_0));
  LUT6 #(
    .INIT(64'h3A2501AAD0A4522D)) 
    g15_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b30_n_0));
  LUT6 #(
    .INIT(64'h8BDB894411B0D9A1)) 
    g15_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b31_n_0));
  LUT6 #(
    .INIT(64'hBD24EA938223BB07)) 
    g15_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b32_n_0));
  LUT6 #(
    .INIT(64'h90BD1C5EF47EF342)) 
    g15_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b33_n_0));
  LUT6 #(
    .INIT(64'h753CAFCB0D41A32B)) 
    g15_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b34_n_0));
  LUT6 #(
    .INIT(64'h0C96CFC6A98069B3)) 
    g15_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b35_n_0));
  LUT6 #(
    .INIT(64'h56D8F03E64AAB23C)) 
    g15_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b36_n_0));
  LUT6 #(
    .INIT(64'hCDB5AAAB49333C3F)) 
    g15_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b37_n_0));
  LUT6 #(
    .INIT(64'h3C7399992496956A)) 
    g15_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b38_n_0));
  LUT6 #(
    .INIT(64'h03F07878E38E7319)) 
    g15_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b39_n_0));
  LUT6 #(
    .INIT(64'h7D8A48F50F362016)) 
    g15_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b4_n_0));
  LUT6 #(
    .INIT(64'hAAA552AD4AD4A5AD)) 
    g15_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b40_n_0));
  LUT6 #(
    .INIT(64'h666CC99B264D9364)) 
    g15_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b41_n_0));
  LUT6 #(
    .INIT(64'hE1E3C7871E3C70E3)) 
    g15_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b42_n_0));
  LUT6 #(
    .INIT(64'h1FE03F80FE03F01F)) 
    g15_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b43_n_0));
  LUT6 #(
    .INIT(64'hFFE0007FFE000FFF)) 
    g15_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b44_n_0));
  LUT6 #(
    .INIT(64'h001FFFFFFE000000)) 
    g15_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b45_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFE000000)) 
    g15_b47
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b47_n_0));
  LUT6 #(
    .INIT(64'h1A9B3F0DED5E711A)) 
    g15_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b5_n_0));
  LUT6 #(
    .INIT(64'h8C155BC8B5F4AA84)) 
    g15_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b50_n_0));
  LUT6 #(
    .INIT(64'h477719778C06713B)) 
    g15_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b51_n_0));
  LUT6 #(
    .INIT(64'h8B6455B3353A9C63)) 
    g15_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b52_n_0));
  LUT6 #(
    .INIT(64'hA6D2CB696F684AD6)) 
    g15_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b53_n_0));
  LUT6 #(
    .INIT(64'h9E31C718E319C631)) 
    g15_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b54_n_0));
  LUT6 #(
    .INIT(64'h81F03F07E0F83E0F)) 
    g15_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b55_n_0));
  LUT6 #(
    .INIT(64'h800FFF001FF801FF)) 
    g15_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b56_n_0));
  LUT6 #(
    .INIT(64'h7FFFFF000007FFFF)) 
    g15_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b57_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h1F)) 
    g15_b58
       (.I0(a[3]),
        .I1(a[4]),
        .I2(a[5]),
        .O(g15_b58_n_0));
  LUT6 #(
    .INIT(64'h715DCCCF80BA51B6)) 
    g15_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b6_n_0));
  LUT6 #(
    .INIT(64'h209A2D2DB8E557BD)) 
    g15_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b7_n_0));
  LUT6 #(
    .INIT(64'h404C19E66FBDB8C8)) 
    g15_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b8_n_0));
  LUT6 #(
    .INIT(64'hB3099D2E7CA539C9)) 
    g15_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g15_b9_n_0));
  LUT6 #(
    .INIT(64'hCE9C63E512CBF51B)) 
    g1_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b0_n_0));
  LUT6 #(
    .INIT(64'h3DBE7C7607EED9DE)) 
    g1_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b1_n_0));
  LUT6 #(
    .INIT(64'hA79E8F0B7866BD11)) 
    g1_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b10_n_0));
  LUT6 #(
    .INIT(64'h6D21AF499096E17D)) 
    g1_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b11_n_0));
  LUT6 #(
    .INIT(64'h850CA9446C9570BA)) 
    g1_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b12_n_0));
  LUT6 #(
    .INIT(64'hBEB820523805C8E4)) 
    g1_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b13_n_0));
  LUT6 #(
    .INIT(64'h686F8F1EBAF1D042)) 
    g1_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b14_n_0));
  LUT6 #(
    .INIT(64'hB01ACF34C659CA81)) 
    g1_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b15_n_0));
  LUT6 #(
    .INIT(64'h95530F0DAB61C655)) 
    g1_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b16_n_0));
  LUT6 #(
    .INIT(64'h8CC95A56CC7E3E33)) 
    g1_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b17_n_0));
  LUT6 #(
    .INIT(64'hD6926C670F8001F0)) 
    g1_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b18_n_0));
  LUT6 #(
    .INIT(64'h4DB6DAD2A555555A)) 
    g1_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b19_n_0));
  LUT6 #(
    .INIT(64'h564772F4C45C2582)) 
    g1_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b2_n_0));
  LUT6 #(
    .INIT(64'h69249364C999999C)) 
    g1_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b20_n_0));
  LUT6 #(
    .INIT(64'h2492492DA4B4B4B5)) 
    g1_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b21_n_0));
  LUT6 #(
    .INIT(64'hE38E38E39C738C73)) 
    g1_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b22_n_0));
  LUT6 #(
    .INIT(64'h1F81F81F83F07C0F)) 
    g1_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b23_n_0));
  LUT6 #(
    .INIT(64'hFF8007FF800FFC00)) 
    g1_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b24_n_0));
  LUT6 #(
    .INIT(64'hFF8000007FFFFC00)) 
    g1_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b25_n_0));
  LUT6 #(
    .INIT(64'h007FFFFFFFFFFC00)) 
    g1_b26
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b26_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h0000001F)) 
    g1_b27
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g1_b27_n_0));
  LUT6 #(
    .INIT(64'hB50C5A4703B16E23)) 
    g1_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b3_n_0));
  LUT6 #(
    .INIT(64'h017063BF910ACAF5)) 
    g1_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b30_n_0));
  LUT6 #(
    .INIT(64'hCC125D7F8A286A97)) 
    g1_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b31_n_0));
  LUT6 #(
    .INIT(64'hD22AA7CCB585AEC9)) 
    g1_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b32_n_0));
  LUT6 #(
    .INIT(64'h0721711E51743914)) 
    g1_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b33_n_0));
  LUT6 #(
    .INIT(64'h2351C826D7CA54D5)) 
    g1_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b34_n_0));
  LUT6 #(
    .INIT(64'hEB2085E9922E886E)) 
    g1_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b35_n_0));
  LUT6 #(
    .INIT(64'h4CEAFCB0441B057D)) 
    g1_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b36_n_0));
  LUT6 #(
    .INIT(64'hDAB3039567F9567C)) 
    g1_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b37_n_0));
  LUT6 #(
    .INIT(64'hC6695526780732D6)) 
    g1_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b38_n_0));
  LUT6 #(
    .INIT(64'h3E18CC92D555A498)) 
    g1_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b39_n_0));
  LUT6 #(
    .INIT(64'h527320FF869E9E43)) 
    g1_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b4_n_0));
  LUT6 #(
    .INIT(64'hFE07C38E33336DB5)) 
    g1_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b40_n_0));
  LUT6 #(
    .INIT(64'h54AA952B5A5A4926)) 
    g1_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b41_n_0));
  LUT6 #(
    .INIT(64'h32664C9936C92492)) 
    g1_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b42_n_0));
  LUT6 #(
    .INIT(64'h0E1E3C78F1C71C71)) 
    g1_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b43_n_0));
  LUT6 #(
    .INIT(64'hFE01FC07F03F03F0)) 
    g1_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b44_n_0));
  LUT6 #(
    .INIT(64'h01FFFC000FFF000F)) 
    g1_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b45_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h001FFF00)) 
    g1_b46
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g1_b46_n_0));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT2 #(
    .INIT(4'hE)) 
    g1_b47
       (.I0(a[4]),
        .I1(a[5]),
        .O(g1_b47_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h1)) 
    g1_b48
       (.I0(a[4]),
        .I1(a[5]),
        .O(g1_b48_n_0));
  LUT6 #(
    .INIT(64'h27F12C3F411B22C7)) 
    g1_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b5_n_0));
  LUT6 #(
    .INIT(64'h1DD2D20FDACE8FBF)) 
    g1_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b50_n_0));
  LUT6 #(
    .INIT(64'hAA8163EF86F97AD6)) 
    g1_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b51_n_0));
  LUT6 #(
    .INIT(64'h99B6D6A52B924CE7)) 
    g1_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b52_n_0));
  LUT6 #(
    .INIT(64'h2D249B36331C70F8)) 
    g1_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b53_n_0));
  LUT6 #(
    .INIT(64'h9B6DB69296B52A55)) 
    g1_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b54_n_0));
  LUT6 #(
    .INIT(64'h871C718E718CE633)) 
    g1_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b55_n_0));
  LUT6 #(
    .INIT(64'h7F03F07E0F83E1F0)) 
    g1_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b56_n_0));
  LUT6 #(
    .INIT(64'h00FFF001FF801FF0)) 
    g1_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b57_n_0));
  LUT6 #(
    .INIT(64'h00000FFFFF80000F)) 
    g1_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b58_n_0));
  LUT6 #(
    .INIT(64'h00000000007FFFFF)) 
    g1_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b59_n_0));
  LUT6 #(
    .INIT(64'hE03A99E5E9566CE8)) 
    g1_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b6_n_0));
  LUT6 #(
    .INIT(64'h701A2F263CC24C0E)) 
    g1_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b7_n_0));
  LUT6 #(
    .INIT(64'h633E30AB216014A4)) 
    g1_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b8_n_0));
  LUT6 #(
    .INIT(64'h94B059E861817551)) 
    g1_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g1_b9_n_0));
  LUT6 #(
    .INIT(64'h07EBC4F7F1C99EAD)) 
    g2_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b0_n_0));
  LUT6 #(
    .INIT(64'h27D3D04A093D35A5)) 
    g2_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b1_n_0));
  LUT6 #(
    .INIT(64'hCA7FA053E84E56C4)) 
    g2_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b10_n_0));
  LUT6 #(
    .INIT(64'h1B0BD0B3586ACE3C)) 
    g2_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b11_n_0));
  LUT6 #(
    .INIT(64'hDDC183EA0B405865)) 
    g2_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b12_n_0));
  LUT6 #(
    .INIT(64'h3085A11283041BC1)) 
    g2_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b13_n_0));
  LUT6 #(
    .INIT(64'h0AFCC0A2532833D6)) 
    g2_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b14_n_0));
  LUT6 #(
    .INIT(64'hF9A900689CE55C32)) 
    g2_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b15_n_0));
  LUT6 #(
    .INIT(64'h52CE0019B5499FF1)) 
    g2_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b16_n_0));
  LUT6 #(
    .INIT(64'h365AAAAD2671E00F)) 
    g2_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b17_n_0));
  LUT6 #(
    .INIT(64'hF1C6666492D4AAAA)) 
    g2_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b18_n_0));
  LUT6 #(
    .INIT(64'hF03E1E1C71CC6666)) 
    g2_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b19_n_0));
  LUT6 #(
    .INIT(64'h48C40296052DE400)) 
    g2_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b2_n_0));
  LUT6 #(
    .INIT(64'hA554AB56A5694B4B)) 
    g2_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b20_n_0));
  LUT6 #(
    .INIT(64'h6CCD99326CDB26D9)) 
    g2_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b21_n_0));
  LUT6 #(
    .INIT(64'h1C3C78F1E3C71E38)) 
    g2_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b22_n_0));
  LUT6 #(
    .INIT(64'hFC03F80FE03F01F8)) 
    g2_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b23_n_0));
  LUT6 #(
    .INIT(64'h03FFF8001FFF0007)) 
    g2_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b24_n_0));
  LUT6 #(
    .INIT(64'hFFFFF8000000FFFF)) 
    g2_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b25_n_0));
  LUT6 #(
    .INIT(64'hFFFFF80000000000)) 
    g2_b27
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b27_n_0));
  LUT6 #(
    .INIT(64'h000007FFFFFFFFFF)) 
    g2_b28
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b28_n_0));
  LUT6 #(
    .INIT(64'hBA081282CF3385C4)) 
    g2_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b3_n_0));
  LUT6 #(
    .INIT(64'hF9AC44E606498896)) 
    g2_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b30_n_0));
  LUT6 #(
    .INIT(64'h768B93F80285A402)) 
    g2_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b31_n_0));
  LUT6 #(
    .INIT(64'hFA72B00001A997A0)) 
    g2_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b32_n_0));
  LUT6 #(
    .INIT(64'h306543333357EB58)) 
    g2_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b33_n_0));
  LUT6 #(
    .INIT(64'h4BC221E1E1DDBB71)) 
    g2_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b34_n_0));
  LUT6 #(
    .INIT(64'h868140BF409CC675)) 
    g2_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b35_n_0));
  LUT6 #(
    .INIT(64'h54FF2AC0D51C5473)) 
    g2_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b36_n_0));
  LUT6 #(
    .INIT(64'hCDAA4CFFCCB69870)) 
    g2_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b37_n_0));
  LUT6 #(
    .INIT(64'h3C66DA5569271F8F)) 
    g2_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b38_n_0));
  LUT6 #(
    .INIT(64'h56B4936671C7E000)) 
    g2_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b39_n_0));
  LUT6 #(
    .INIT(64'h025891B1C3B795DD)) 
    g2_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b4_n_0));
  LUT6 #(
    .INIT(64'h98C71C787E07FFFF)) 
    g2_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b40_n_0));
  LUT6 #(
    .INIT(64'hB5AD4AD52AAD5555)) 
    g2_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b41_n_0));
  LUT6 #(
    .INIT(64'h8C6339CCE6633333)) 
    g2_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b42_n_0));
  LUT6 #(
    .INIT(64'h83E0F83C1E1F0F0F)) 
    g2_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b43_n_0));
  LUT6 #(
    .INIT(64'h801FF803FE00FF00)) 
    g2_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b44_n_0));
  LUT6 #(
    .INIT(64'h7FFFF80001FFFF00)) 
    g2_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b45_n_0));
  LUT6 #(
    .INIT(64'h000007FFFFFFFF00)) 
    g2_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b46_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'h01)) 
    g2_b47
       (.I0(a[3]),
        .I1(a[4]),
        .I2(a[5]),
        .O(g2_b47_n_0));
  LUT6 #(
    .INIT(64'h2E04F191DE86E719)) 
    g2_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b5_n_0));
  LUT6 #(
    .INIT(64'h09A64567A984643F)) 
    g2_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b50_n_0));
  LUT6 #(
    .INIT(64'h849A279289ED4CC8)) 
    g2_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b51_n_0));
  LUT6 #(
    .INIT(64'hC91C79178A633259)) 
    g2_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b52_n_0));
  LUT6 #(
    .INIT(64'h0E1F8117881F0E2D)) 
    g2_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b53_n_0));
  LUT6 #(
    .INIT(64'hA54AABBD22AA54A4)) 
    g2_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b54_n_0));
  LUT6 #(
    .INIT(64'h6339988C99993263)) 
    g2_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b55_n_0));
  LUT6 #(
    .INIT(64'hE0F8787C7878F1E0)) 
    g2_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b56_n_0));
  LUT6 #(
    .INIT(64'h1FF807FC07F80FE0)) 
    g2_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b57_n_0));
  LUT6 #(
    .INIT(64'h0007FFFC0007FFE0)) 
    g2_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b58_n_0));
  LUT6 #(
    .INIT(64'h00000003FFFFFFE0)) 
    g2_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b59_n_0));
  LUT6 #(
    .INIT(64'h30429A1A54068518)) 
    g2_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b6_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFE0)) 
    g2_b62
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b62_n_0));
  LUT6 #(
    .INIT(64'h58C1FA36BE2CB71A)) 
    g2_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b7_n_0));
  LUT6 #(
    .INIT(64'h710C948E5C510319)) 
    g2_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b8_n_0));
  LUT6 #(
    .INIT(64'h8A2D56B2FB117A4D)) 
    g2_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g2_b9_n_0));
  LUT6 #(
    .INIT(64'hE525030C1B7F404B)) 
    g3_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b0_n_0));
  LUT6 #(
    .INIT(64'h26539A11C092BE74)) 
    g3_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b1_n_0));
  LUT6 #(
    .INIT(64'h4D8A70D46C62F002)) 
    g3_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b10_n_0));
  LUT6 #(
    .INIT(64'hDC9EECAE54F3D222)) 
    g3_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b11_n_0));
  LUT6 #(
    .INIT(64'h180F3813F5352AFA)) 
    g3_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b12_n_0));
  LUT6 #(
    .INIT(64'hCFAEBAF424B21247)) 
    g3_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b13_n_0));
  LUT6 #(
    .INIT(64'h9064C65811315DD4)) 
    g3_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b14_n_0));
  LUT6 #(
    .INIT(64'hB548FE3559CF3567)) 
    g3_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b15_n_0));
  LUT6 #(
    .INIT(64'h7325AB599E00F32D)) 
    g3_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b16_n_0));
  LUT6 #(
    .INIT(64'h5A49339E1FFFF0E3)) 
    g3_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b17_n_0));
  LUT6 #(
    .INIT(64'h638E3C1FE0000FE0)) 
    g3_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b18_n_0));
  LUT6 #(
    .INIT(64'h83F03FE00000001F)) 
    g3_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b19_n_0));
  LUT6 #(
    .INIT(64'hC01D889AB54FF630)) 
    g3_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b2_n_0));
  LUT6 #(
    .INIT(64'hA9556AAAAAAAAAAA)) 
    g3_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b20_n_0));
  LUT6 #(
    .INIT(64'h98CCE66666666666)) 
    g3_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b21_n_0));
  LUT6 #(
    .INIT(64'h783C1E1E1E1E1E1E)) 
    g3_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b22_n_0));
  LUT6 #(
    .INIT(64'hF803FE01FE01FE01)) 
    g3_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b23_n_0));
  LUT6 #(
    .INIT(64'h07FFFE0001FFFE00)) 
    g3_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b24_n_0));
  LUT6 #(
    .INIT(64'hFFFFFE00000001FF)) 
    g3_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b25_n_0));
  LUT6 #(
    .INIT(64'h000001FFFFFFFFFF)) 
    g3_b26
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b26_n_0));
  LUT6 #(
    .INIT(64'hB8A6C4B865A96557)) 
    g3_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b3_n_0));
  LUT6 #(
    .INIT(64'hA63F4ACC8F9C37B8)) 
    g3_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b30_n_0));
  LUT6 #(
    .INIT(64'hACF3E14B201994A3)) 
    g3_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b31_n_0));
  LUT6 #(
    .INIT(64'h72E1C4AB06769CE2)) 
    g3_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b32_n_0));
  LUT6 #(
    .INIT(64'h728C4E2F8F1C0005)) 
    g3_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b33_n_0));
  LUT6 #(
    .INIT(64'h35EDF90B13685D17)) 
    g3_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b34_n_0));
  LUT6 #(
    .INIT(64'hE7B37A1CA190360D)) 
    g3_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b35_n_0));
  LUT6 #(
    .INIT(64'hED3F2C053F555803)) 
    g3_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b36_n_0));
  LUT6 #(
    .INIT(64'h49C0E5563F266000)) 
    g3_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b37_n_0));
  LUT6 #(
    .INIT(64'h71FFE33295A78000)) 
    g3_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b38_n_0));
  LUT6 #(
    .INIT(64'hD4AAB5A4D9CD5555)) 
    g3_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b39_n_0));
  LUT6 #(
    .INIT(64'h5299906FB0C4B1DA)) 
    g3_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b4_n_0));
  LUT6 #(
    .INIT(64'h3399936DB4A99999)) 
    g3_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b40_n_0));
  LUT6 #(
    .INIT(64'h5AD2DA4926C4B4B4)) 
    g3_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b41_n_0));
  LUT6 #(
    .INIT(64'h3649B6DB6DA38C73)) 
    g3_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b42_n_0));
  LUT6 #(
    .INIT(64'h0E3871C71C607C0F)) 
    g3_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b43_n_0));
  LUT6 #(
    .INIT(64'hFE07F03F03E003FF)) 
    g3_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b44_n_0));
  LUT6 #(
    .INIT(64'h01FFF000FFE00000)) 
    g3_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b45_n_0));
  LUT6 #(
    .INIT(64'h00000FFFFFE00000)) 
    g3_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b46_n_0));
  LUT6 #(
    .INIT(64'h79EA3617ADFBAD39)) 
    g3_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b5_n_0));
  LUT6 #(
    .INIT(64'hDF26ABADC31A8F0C)) 
    g3_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b50_n_0));
  LUT6 #(
    .INIT(64'h238AF0CEFB49E268)) 
    g3_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b51_n_0));
  LUT6 #(
    .INIT(64'h1899965A560E94BE)) 
    g3_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b52_n_0));
  LUT6 #(
    .INIT(64'h52D2DB6C9B9318CF)) 
    g3_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b53_n_0));
  LUT6 #(
    .INIT(64'h3649B6DA49494A5A)) 
    g3_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b54_n_0));
  LUT6 #(
    .INIT(64'h0E3871C638C739C6)) 
    g3_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b55_n_0));
  LUT6 #(
    .INIT(64'h01F80FC1F83F07C1)) 
    g3_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b56_n_0));
  LUT6 #(
    .INIT(64'hFFF8003FF800FFC0)) 
    g3_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b57_n_0));
  LUT6 #(
    .INIT(64'hFFF8000007FFFFC0)) 
    g3_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b58_n_0));
  LUT6 #(
    .INIT(64'h0007FFFFFFFFFFC0)) 
    g3_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b59_n_0));
  LUT6 #(
    .INIT(64'hDB73BF5CB662D0F1)) 
    g3_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h00000007)) 
    g3_b60
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g3_b60_n_0));
  LUT6 #(
    .INIT(64'h00000000001FFFFF)) 
    g3_b62
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b62_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFE00000)) 
    g3_b63
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b63_n_0));
  LUT6 #(
    .INIT(64'h0056C9FB12903BF5)) 
    g3_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b7_n_0));
  LUT6 #(
    .INIT(64'h42CE508E4292280C)) 
    g3_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b8_n_0));
  LUT6 #(
    .INIT(64'h5AF2F9C8EC6632A9)) 
    g3_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g3_b9_n_0));
  LUT6 #(
    .INIT(64'hB6F2E5251FE08867)) 
    g4_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b0_n_0));
  LUT6 #(
    .INIT(64'hCF1481CB1EDF7D13)) 
    g4_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b1_n_0));
  LUT6 #(
    .INIT(64'h0064B49C0D4E4F42)) 
    g4_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b10_n_0));
  LUT6 #(
    .INIT(64'h99E15E866542E94D)) 
    g4_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b11_n_0));
  LUT6 #(
    .INIT(64'hA5C2235C3EFA6052)) 
    g4_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b12_n_0));
  LUT6 #(
    .INIT(64'h3C814162BD789A4B)) 
    g4_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b13_n_0));
  LUT6 #(
    .INIT(64'h6900D5819679AC46)) 
    g4_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b14_n_0));
  LUT6 #(
    .INIT(64'hE4AA99FF8D2D3041)) 
    g4_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b15_n_0));
  LUT6 #(
    .INIT(64'h1C664B5529B1C040)) 
    g4_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b16_n_0));
  LUT6 #(
    .INIT(64'hFC1E38CC9B6B5515)) 
    g4_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b17_n_0));
  LUT6 #(
    .INIT(64'hA954AD692DB26666)) 
    g4_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b18_n_0));
  LUT6 #(
    .INIT(64'hCE67318E31C38787)) 
    g4_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b19_n_0));
  LUT6 #(
    .INIT(64'h80D2706BD2BF61C4)) 
    g4_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b2_n_0));
  LUT6 #(
    .INIT(64'h5AD294A56B56AD52)) 
    g4_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b20_n_0));
  LUT6 #(
    .INIT(64'hC6318C6318CE6331)) 
    g4_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b21_n_0));
  LUT6 #(
    .INIT(64'hC1F07C1F07C1E0F0)) 
    g4_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b22_n_0));
  LUT6 #(
    .INIT(64'h3FF003FF003FE00F)) 
    g4_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b23_n_0));
  LUT6 #(
    .INIT(64'hFFF00000FFFFE000)) 
    g4_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b24_n_0));
  LUT6 #(
    .INIT(64'hFFF0000000001FFF)) 
    g4_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b25_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hE000)) 
    g4_b26
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g4_b26_n_0));
  LUT6 #(
    .INIT(64'hBB1973272E5D1A65)) 
    g4_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b3_n_0));
  LUT6 #(
    .INIT(64'h5F2F7BF312ED829D)) 
    g4_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b30_n_0));
  LUT6 #(
    .INIT(64'h7D3857FC11B30A0D)) 
    g4_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b31_n_0));
  LUT6 #(
    .INIT(64'h94CD3000106A0706)) 
    g4_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b32_n_0));
  LUT6 #(
    .INIT(64'h2A683CCCDCD598CE)) 
    g4_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b33_n_0));
  LUT6 #(
    .INIT(64'h1160B7879788F12C)) 
    g4_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b34_n_0));
  LUT6 #(
    .INIT(64'h0A6532FD12FAF5E7)) 
    g4_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b35_n_0));
  LUT6 #(
    .INIT(64'hF93631A9EE530CB7)) 
    g4_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b36_n_0));
  LUT6 #(
    .INIT(64'hADB83064AB63FC6D)) 
    g4_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b37_n_0));
  LUT6 #(
    .INIT(64'hCE3FCFE3992956B6)) 
    g4_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b38_n_0));
  LUT6 #(
    .INIT(64'h0FC0001F8718CD92)) 
    g4_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b39_n_0));
  LUT6 #(
    .INIT(64'h63120898864EA330)) 
    g4_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b4_n_0));
  LUT6 #(
    .INIT(64'hF00000007F07C38E)) 
    g4_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b40_n_0));
  LUT6 #(
    .INIT(64'h5555555555AA952B)) 
    g4_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b41_n_0));
  LUT6 #(
    .INIT(64'h3333333333664C99)) 
    g4_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b42_n_0));
  LUT6 #(
    .INIT(64'hF0F0F0F0F0E1C387)) 
    g4_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b43_n_0));
  LUT6 #(
    .INIT(64'h0FF00FF00FE03F80)) 
    g4_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b44_n_0));
  LUT6 #(
    .INIT(64'h000FFFF0001FFF80)) 
    g4_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b45_n_0));
  LUT6 #(
    .INIT(64'h0000000FFFFFFF80)) 
    g4_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b46_n_0));
  LUT6 #(
    .INIT(64'h000000000000007F)) 
    g4_b47
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b47_n_0));
  LUT6 #(
    .INIT(64'hEFBF048482C63AE1)) 
    g4_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b5_n_0));
  LUT6 #(
    .INIT(64'h1B0AD6EA9B9481D3)) 
    g4_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b50_n_0));
  LUT6 #(
    .INIT(64'hFBB028EA907C4E49)) 
    g4_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b51_n_0));
  LUT6 #(
    .INIT(64'h6834C0EA9003C1C7)) 
    g4_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b52_n_0));
  LUT6 #(
    .INIT(64'h743F0A403AAA956A)) 
    g4_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b53_n_0));
  LUT6 #(
    .INIT(64'hD56AA62676664CD9)) 
    g4_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b54_n_0));
  LUT6 #(
    .INIT(64'hCCE661E1F1E1C3C7)) 
    g4_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b55_n_0));
  LUT6 #(
    .INIT(64'hC3E1E01FF01FC03F)) 
    g4_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b56_n_0));
  LUT6 #(
    .INIT(64'hC01FE0000FFFC000)) 
    g4_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b57_n_0));
  LUT6 #(
    .INIT(64'h3FFFE00000003FFF)) 
    g4_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b58_n_0));
  LUT6 #(
    .INIT(64'h1B12FD4E7F0F6D24)) 
    g4_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b6_n_0));
  LUT6 #(
    .INIT(64'hFFFFE00000000000)) 
    g4_b62
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b62_n_0));
  LUT6 #(
    .INIT(64'h60660379324AE5FF)) 
    g4_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b7_n_0));
  LUT6 #(
    .INIT(64'h5D04AA7A1FFF8524)) 
    g4_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b8_n_0));
  LUT6 #(
    .INIT(64'h3E5266D3F42EEBFF)) 
    g4_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g4_b9_n_0));
  LUT6 #(
    .INIT(64'h73D0AD99E8704347)) 
    g5_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b0_n_0));
  LUT6 #(
    .INIT(64'hA622DBCB3E77C161)) 
    g5_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b1_n_0));
  LUT6 #(
    .INIT(64'hB4EC21642FA0CCC9)) 
    g5_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b10_n_0));
  LUT6 #(
    .INIT(64'hE008F835ACF9703E)) 
    g5_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b11_n_0));
  LUT6 #(
    .INIT(64'hE84AEF4E72EF77BB)) 
    g5_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b12_n_0));
  LUT6 #(
    .INIT(64'hE5764F2814E58D39)) 
    g5_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b13_n_0));
  LUT6 #(
    .INIT(64'h1CD48F1AA71CA9C7)) 
    g5_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b14_n_0));
  LUT6 #(
    .INIT(64'hA9670F066D56CE00)) 
    g5_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b15_n_0));
  LUT6 #(
    .INIT(64'h64D2A5AB4998F000)) 
    g5_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b16_n_0));
  LUT6 #(
    .INIT(64'h4964C9CC71E0FFFF)) 
    g5_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b17_n_0));
  LUT6 #(
    .INIT(64'hDB2DA4A52B55AAAA)) 
    g5_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b18_n_0));
  LUT6 #(
    .INIT(64'h924936C9B266CCCC)) 
    g5_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b19_n_0));
  LUT6 #(
    .INIT(64'h4A914CAE691B65EB)) 
    g5_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b2_n_0));
  LUT6 #(
    .INIT(64'hB6DB6DA496D25A5A)) 
    g5_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b20_n_0));
  LUT6 #(
    .INIT(64'h71C71C638E31C639)) 
    g5_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b21_n_0));
  LUT6 #(
    .INIT(64'h0FC0FC1F81F03E07)) 
    g5_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b22_n_0));
  LUT6 #(
    .INIT(64'hFFC003FF800FFE00)) 
    g5_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b23_n_0));
  LUT6 #(
    .INIT(64'h003FFFFF800001FF)) 
    g5_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b24_n_0));
  LUT6 #(
    .INIT(64'h000000007FFFFFFF)) 
    g5_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b25_n_0));
  LUT6 #(
    .INIT(64'h648415A322CC5210)) 
    g5_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b3_n_0));
  LUT6 #(
    .INIT(64'hF8F371406017E47F)) 
    g5_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b30_n_0));
  LUT6 #(
    .INIT(64'hDB8102A61994E4ED)) 
    g5_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b31_n_0));
  LUT6 #(
    .INIT(64'h00934770E96359F4)) 
    g5_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b32_n_0));
  LUT6 #(
    .INIT(64'hDBFEF636C0360D9F)) 
    g5_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b33_n_0));
  LUT6 #(
    .INIT(64'h33A173E67A1979A2)) 
    g5_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b34_n_0));
  LUT6 #(
    .INIT(64'hF6C0DBEC86A0D194)) 
    g5_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b35_n_0));
  LUT6 #(
    .INIT(64'hF1AA9C1DAB3FCB27)) 
    g5_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b36_n_0));
  LUT6 #(
    .INIT(64'hF0664AA933C03892)) 
    g5_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b37_n_0));
  LUT6 #(
    .INIT(64'h0FE1C66496AAAD24)) 
    g5_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b38_n_0));
  LUT6 #(
    .INIT(64'h554A94B6DB3331C7)) 
    g5_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b39_n_0));
  LUT6 #(
    .INIT(64'hC5EDB529CF75C83E)) 
    g5_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b4_n_0));
  LUT6 #(
    .INIT(64'h667318C71C3C3E07)) 
    g5_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b40_n_0));
  LUT6 #(
    .INIT(64'hD2D6B5AD4A956AAD)) 
    g5_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b41_n_0));
  LUT6 #(
    .INIT(64'hCE318C63398CE663)) 
    g5_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b42_n_0));
  LUT6 #(
    .INIT(64'hC1F07C1F0783E1E0)) 
    g5_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b43_n_0));
  LUT6 #(
    .INIT(64'hC00FFC00FF801FE0)) 
    g5_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b44_n_0));
  LUT6 #(
    .INIT(64'h3FFFFC00007FFFE0)) 
    g5_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b45_n_0));
  LUT6 #(
    .INIT(64'h000003FFFFFFFFE0)) 
    g5_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b46_n_0));
  LUT6 #(
    .INIT(64'h000000000000001F)) 
    g5_b48
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b48_n_0));
  LUT6 #(
    .INIT(64'h7F7642210E135D4D)) 
    g5_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b5_n_0));
  LUT6 #(
    .INIT(64'h02EF0ABE9BF1C855)) 
    g5_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b50_n_0));
  LUT6 #(
    .INIT(64'h8683C16E482C5E11)) 
    g5_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b51_n_0));
  LUT6 #(
    .INIT(64'hB0480B5B0D76CC8A)) 
    g5_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b52_n_0));
  LUT6 #(
    .INIT(64'h24926D9391B8AF1C)) 
    g5_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b53_n_0));
  LUT6 #(
    .INIT(64'h924924B6B495A54A)) 
    g5_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b54_n_0));
  LUT6 #(
    .INIT(64'h8E38E38E738C6339)) 
    g5_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b55_n_0));
  LUT6 #(
    .INIT(64'h81F81F81F07C1F07)) 
    g5_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b56_n_0));
  LUT6 #(
    .INIT(64'h8007FF800FFC00FF)) 
    g5_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b57_n_0));
  LUT6 #(
    .INIT(64'h8000007FFFFC0000)) 
    g5_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b58_n_0));
  LUT6 #(
    .INIT(64'h800000000003FFFF)) 
    g5_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b59_n_0));
  LUT6 #(
    .INIT(64'h7DCB102568E5B2B4)) 
    g5_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b6_n_0));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    g5_b60
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b60_n_0));
  LUT6 #(
    .INIT(64'h7C848310ADF9F44A)) 
    g5_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b7_n_0));
  LUT6 #(
    .INIT(64'h83A85E1DA26794E2)) 
    g5_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b8_n_0));
  LUT6 #(
    .INIT(64'hCCA9AD90170E9CA3)) 
    g5_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g5_b9_n_0));
  LUT6 #(
    .INIT(64'hD08991FA992594D9)) 
    g6_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b0_n_0));
  LUT6 #(
    .INIT(64'hF9C97F61A359210C)) 
    g6_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b1_n_0));
  LUT6 #(
    .INIT(64'hA4DB1E9217123BB4)) 
    g6_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b10_n_0));
  LUT6 #(
    .INIT(64'h8071DA0049D51B1F)) 
    g6_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b11_n_0));
  LUT6 #(
    .INIT(64'h97DF670BD0920CA2)) 
    g6_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b12_n_0));
  LUT6 #(
    .INIT(64'hD8358153CAEEAF94)) 
    g6_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b13_n_0));
  LUT6 #(
    .INIT(64'h4AA600C96CFE6527)) 
    g6_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b14_n_0));
  LUT6 #(
    .INIT(64'h3992AA9270FE1C92)) 
    g6_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b15_n_0));
  LUT6 #(
    .INIT(64'hAD24CCE380FE038E)) 
    g6_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b16_n_0));
  LUT6 #(
    .INIT(64'h9B6DA5A955AB552B)) 
    g6_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b17_n_0));
  LUT6 #(
    .INIT(64'h78E39C6733993366)) 
    g6_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b18_n_0));
  LUT6 #(
    .INIT(64'hAD4AD6B5A52DA5B4)) 
    g6_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b19_n_0));
  LUT6 #(
    .INIT(64'h349122E680504A65)) 
    g6_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b2_n_0));
  LUT6 #(
    .INIT(64'h64D9B26C9364936D)) 
    g6_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b20_n_0));
  LUT6 #(
    .INIT(64'hE3C78E1C70E38F1C)) 
    g6_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b21_n_0));
  LUT6 #(
    .INIT(64'h1FC07E03F01F80FC)) 
    g6_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b22_n_0));
  LUT6 #(
    .INIT(64'h003FFE000FFF8003)) 
    g6_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b23_n_0));
  LUT6 #(
    .INIT(64'h000001FFFFFF8000)) 
    g6_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b24_n_0));
  LUT6 #(
    .INIT(64'hB8FF0A22076F9AAC)) 
    g6_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b3_n_0));
  LUT6 #(
    .INIT(64'h31C93E843C71BD2C)) 
    g6_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b30_n_0));
  LUT6 #(
    .INIT(64'h0FC76B02BD759C12)) 
    g6_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b31_n_0));
  LUT6 #(
    .INIT(64'h330C2A67F0154538)) 
    g6_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b32_n_0));
  LUT6 #(
    .INIT(64'hE1D2083C4884214E)) 
    g6_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b33_n_0));
  LUT6 #(
    .INIT(64'h15CBE3E82FA4BC7B)) 
    g6_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b34_n_0));
  LUT6 #(
    .INIT(64'h59C6B3E54F913CD3)) 
    g6_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b35_n_0));
  LUT6 #(
    .INIT(64'h61C196B670736963)) 
    g6_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b36_n_0));
  LUT6 #(
    .INIT(64'h7E3F8E6D2AA5B183)) 
    g6_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b37_n_0));
  LUT6 #(
    .INIT(64'hD5552B49B339C1FC)) 
    g6_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b38_n_0));
  LUT6 #(
    .INIT(64'hCCCC99249694AB55)) 
    g6_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b39_n_0));
  LUT6 #(
    .INIT(64'hCCF314ACE5B5929A)) 
    g6_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b4_n_0));
  LUT6 #(
    .INIT(64'h9696D24924D93266)) 
    g6_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b40_n_0));
  LUT6 #(
    .INIT(64'hB24DB6DB6DB496D2)) 
    g6_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b41_n_0));
  LUT6 #(
    .INIT(64'h8E3C71C71C738E31)) 
    g6_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b42_n_0));
  LUT6 #(
    .INIT(64'h7E03F03F03F07E0F)) 
    g6_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b43_n_0));
  LUT6 #(
    .INIT(64'h01FFF000FFF001FF)) 
    g6_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b44_n_0));
  LUT4 #(
    .INIT(16'h07E0)) 
    g6_b45
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g6_b45_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'hFFE0)) 
    g6_b46
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g6_b46_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h001F)) 
    g6_b47
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g6_b47_n_0));
  LUT6 #(
    .INIT(64'hCB0BC58C261FC8B7)) 
    g6_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b5_n_0));
  LUT6 #(
    .INIT(64'h8CC40F10ABC216A8)) 
    g6_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b50_n_0));
  LUT6 #(
    .INIT(64'hA96C22C601897332)) 
    g6_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b51_n_0));
  LUT6 #(
    .INIT(64'h00405DC1E0470089)) 
    g6_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b52_n_0));
  LUT6 #(
    .INIT(64'hAAEAAA954A95A52D)) 
    g6_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b53_n_0));
  LUT6 #(
    .INIT(64'h99D999B3264C9364)) 
    g6_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b54_n_0));
  LUT6 #(
    .INIT(64'h87C7878F1E3C70E3)) 
    g6_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b55_n_0));
  LUT6 #(
    .INIT(64'h7FC07F80FE03F01F)) 
    g6_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b56_n_0));
  LUT6 #(
    .INIT(64'hFFC0007FFE000FFF)) 
    g6_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b57_n_0));
  LUT6 #(
    .INIT(64'hFFC0000001FFFFFF)) 
    g6_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b58_n_0));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h07FFFFFF)) 
    g6_b59
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g6_b59_n_0));
  LUT6 #(
    .INIT(64'h180620AB67F72050)) 
    g6_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b6_n_0));
  LUT6 #(
    .INIT(64'hB801428B7E6B88B0)) 
    g6_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b7_n_0));
  LUT6 #(
    .INIT(64'h1E66B2FAA5A28D8F)) 
    g6_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b8_n_0));
  LUT6 #(
    .INIT(64'hA43C4A17AA50174C)) 
    g6_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g6_b9_n_0));
  LUT6 #(
    .INIT(64'h2E6F0E56C50F96C8)) 
    g7_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b0_n_0));
  LUT6 #(
    .INIT(64'h0914AB0CD2812C99)) 
    g7_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b1_n_0));
  LUT6 #(
    .INIT(64'h002C3C1654FE0C04)) 
    g7_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b10_n_0));
  LUT6 #(
    .INIT(64'h4447B776BADC476A)) 
    g7_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b11_n_0));
  LUT6 #(
    .INIT(64'h282867265E628264)) 
    g7_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b12_n_0));
  LUT6 #(
    .INIT(64'h1AB012463481AB9D)) 
    g7_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b13_n_0));
  LUT6 #(
    .INIT(64'h066AA479F25533FC)) 
    g7_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b14_n_0));
  LUT6 #(
    .INIT(64'h01E66D2AA499C3FC)) 
    g7_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b15_n_0));
  LUT6 #(
    .INIT(64'h001E1CE66DB4A956)) 
    g7_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b16_n_0));
  LUT6 #(
    .INIT(64'h0001FC1E1C7398CD)) 
    g7_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b17_n_0));
  LUT6 #(
    .INIT(64'h000003FE03F0783C)) 
    g7_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b18_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAAB555AAD56)) 
    g7_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b19_n_0));
  LUT6 #(
    .INIT(64'h6E042B38ED45CACE)) 
    g7_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b2_n_0));
  LUT6 #(
    .INIT(64'h66666666CCC99B32)) 
    g7_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b20_n_0));
  LUT6 #(
    .INIT(64'h1E1E1E1E3C3878F1)) 
    g7_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b21_n_0));
  LUT6 #(
    .INIT(64'h01FE01FE03F807F0)) 
    g7_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b22_n_0));
  LUT6 #(
    .INIT(64'h0001FFFE0007FFF0)) 
    g7_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b23_n_0));
  LUT6 #(
    .INIT(64'h00000001FFFFFFF0)) 
    g7_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    g7_b25
       (.I0(a[2]),
        .I1(a[3]),
        .I2(a[4]),
        .I3(a[5]),
        .O(g7_b25_n_0));
  LUT6 #(
    .INIT(64'h2E5C42E004BF6524)) 
    g7_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b3_n_0));
  LUT6 #(
    .INIT(64'hA994E4E83BBD3635)) 
    g7_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b30_n_0));
  LUT6 #(
    .INIT(64'h469CA60BD7D4C493)) 
    g7_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b31_n_0));
  LUT6 #(
    .INIT(64'h6C00013E7CD59EBC)) 
    g7_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b32_n_0));
  LUT6 #(
    .INIT(64'h32F7BDEE886E5C9D)) 
    g7_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b33_n_0));
  LUT6 #(
    .INIT(64'h14F2C34E50283776)) 
    g7_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b34_n_0));
  LUT6 #(
    .INIT(64'h0DA4FF249FE5580D)) 
    g7_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b35_n_0));
  LUT6 #(
    .INIT(64'h039255B71FE33556)) 
    g7_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b36_n_0));
  LUT6 #(
    .INIT(64'h0071CC92B54A5998)) 
    g7_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b37_n_0));
  LUT6 #(
    .INIT(64'h000FC38E7326CB4A)) 
    g7_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b38_n_0));
  LUT6 #(
    .INIT(64'h00003F81F0E1C739)) 
    g7_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b39_n_0));
  LUT6 #(
    .INIT(64'h08CA587533B19144)) 
    g7_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b4_n_0));
  LUT6 #(
    .INIT(64'hAAAAAAD55AB56A52)) 
    g7_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b40_n_0));
  LUT6 #(
    .INIT(64'h6666664CC99326C9)) 
    g7_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b41_n_0));
  LUT6 #(
    .INIT(64'h1E1E1E3C3870E1C7)) 
    g7_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b42_n_0));
  LUT6 #(
    .INIT(64'h01FE01FC07F01FC0)) 
    g7_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b43_n_0));
  LUT6 #(
    .INIT(64'h0001FFFC000FFFC0)) 
    g7_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b44_n_0));
  LUT5 #(
    .INIT(32'h0001FFF8)) 
    g7_b45
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g7_b45_n_0));
  LUT6 #(
    .INIT(64'h1EF739607AC86E7F)) 
    g7_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b5_n_0));
  LUT6 #(
    .INIT(64'h0DE07808B01792C0)) 
    g7_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b50_n_0));
  LUT6 #(
    .INIT(64'hF15EF71CA67CFF2F)) 
    g7_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b51_n_0));
  LUT6 #(
    .INIT(64'h3198879AB8603DD0)) 
    g7_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b52_n_0));
  LUT6 #(
    .INIT(64'h6B4A52B5EAD56AAA)) 
    g7_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b53_n_0));
  LUT6 #(
    .INIT(64'h18C6318C66331999)) 
    g7_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b54_n_0));
  LUT6 #(
    .INIT(64'h07C1F07C1E0F0787)) 
    g7_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b55_n_0));
  LUT6 #(
    .INIT(64'h003FF003FE00FF80)) 
    g7_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b56_n_0));
  LUT6 #(
    .INIT(64'h00000FFFFE00007F)) 
    g7_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b57_n_0));
  LUT6 #(
    .INIT(64'h0000000001FFFFFF)) 
    g7_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b58_n_0));
  LUT6 #(
    .INIT(64'h04DC9EA45650934E)) 
    g7_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b6_n_0));
  LUT6 #(
    .INIT(64'h0262F100A8536D60)) 
    g7_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b7_n_0));
  LUT6 #(
    .INIT(64'h01D4F5E8441492EC)) 
    g7_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b8_n_0));
  LUT6 #(
    .INIT(64'hAA98F34FD7C7A167)) 
    g7_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g7_b9_n_0));
  LUT6 #(
    .INIT(64'h1E8630DAF42CB3DA)) 
    g8_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b0_n_0));
  LUT6 #(
    .INIT(64'h4D398C63740C3C20)) 
    g8_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b1_n_0));
  LUT6 #(
    .INIT(64'h7A4845A4493AD67E)) 
    g8_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b10_n_0));
  LUT6 #(
    .INIT(64'hE089B00E49215F10)) 
    g8_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b11_n_0));
  LUT6 #(
    .INIT(64'h6ED5B713FFFB437C)) 
    g8_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b12_n_0));
  LUT6 #(
    .INIT(64'h9B36675E85ECE188)) 
    g8_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b13_n_0));
  LUT6 #(
    .INIT(64'hF9581261A9E57F50)) 
    g8_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b14_n_0));
  LUT6 #(
    .INIT(64'h52600ED531E32A60)) 
    g8_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b15_n_0));
  LUT6 #(
    .INIT(64'h638001CC94B5B380)) 
    g8_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b16_n_0));
  LUT6 #(
    .INIT(64'h2955556926C63C00)) 
    g8_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b17_n_0));
  LUT6 #(
    .INIT(64'hB2666671C707C000)) 
    g8_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b18_n_0));
  LUT6 #(
    .INIT(64'h3C78787E07F80000)) 
    g8_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b19_n_0));
  LUT6 #(
    .INIT(64'h44CB8938349CDE0E)) 
    g8_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b2_n_0));
  LUT6 #(
    .INIT(64'h6AD52AD552AAAAAA)) 
    g8_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b20_n_0));
  LUT6 #(
    .INIT(64'hE63319CCCE666666)) 
    g8_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b21_n_0));
  LUT6 #(
    .INIT(64'hE1F0F83C3E1E1E1E)) 
    g8_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b22_n_0));
  LUT6 #(
    .INIT(64'h1FF007FC01FE01FE)) 
    g8_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b23_n_0));
  LUT6 #(
    .INIT(64'h000FFFFC0001FFFE)) 
    g8_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b24_n_0));
  LUT6 #(
    .INIT(64'h00000003FFFFFFFE)) 
    g8_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b25_n_0));
  LUT6 #(
    .INIT(64'h48226D9462CC8A6E)) 
    g8_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b3_n_0));
  LUT6 #(
    .INIT(64'h331488803E674041)) 
    g8_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b30_n_0));
  LUT6 #(
    .INIT(64'hF391E72AA169F31B)) 
    g8_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b31_n_0));
  LUT6 #(
    .INIT(64'hE1A8C6555956ED17)) 
    g8_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b32_n_0));
  LUT6 #(
    .INIT(64'hD95CB0EEE9C5F4E5)) 
    g8_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b33_n_0));
  LUT6 #(
    .INIT(64'hDA8D49393FF59F35)) 
    g8_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b34_n_0));
  LUT6 #(
    .INIT(64'h33AC85EF45DB08B1)) 
    g8_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b35_n_0));
  LUT6 #(
    .INIT(64'h0933A9E58360AF99)) 
    g8_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b36_n_0));
  LUT6 #(
    .INIT(64'hF89531E355806521)) 
    g8_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b37_n_0));
  LUT6 #(
    .INIT(64'hAD263E1F335549C1)) 
    g8_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b38_n_0));
  LUT6 #(
    .INIT(64'h64929555A5998E01)) 
    g8_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b39_n_0));
  LUT6 #(
    .INIT(64'h593DDEB5813DDB8A)) 
    g8_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b4_n_0));
  LUT6 #(
    .INIT(64'h1C718CCC934B5AAB)) 
    g8_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b40_n_0));
  LUT6 #(
    .INIT(64'h56A5296925926CCD)) 
    g8_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b41_n_0));
  LUT6 #(
    .INIT(64'hCD9364DB6CB6DA5B)) 
    g8_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b42_n_0));
  LUT6 #(
    .INIT(64'hC38F1C38E38E39C7)) 
    g8_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b43_n_0));
  LUT6 #(
    .INIT(64'hC07F03F81F81F83F)) 
    g8_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b44_n_0));
  LUT6 #(
    .INIT(64'h3FFF0007FF8007FF)) 
    g8_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b45_n_0));
  LUT6 #(
    .INIT(64'hFFFF0000007FFFFF)) 
    g8_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b46_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT2 #(
    .INIT(4'h7)) 
    g8_b47
       (.I0(a[4]),
        .I1(a[5]),
        .O(g8_b47_n_0));
  LUT6 #(
    .INIT(64'hE35F133CD6B61EDE)) 
    g8_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b5_n_0));
  LUT6 #(
    .INIT(64'hAE155CA0209420EB)) 
    g8_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b50_n_0));
  LUT6 #(
    .INIT(64'h06D1D0BFF04DAA34)) 
    g8_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b51_n_0));
  LUT6 #(
    .INIT(64'h9DB4F5EAA5693338)) 
    g8_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b52_n_0));
  LUT6 #(
    .INIT(64'h29269933398E3C3F)) 
    g8_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b53_n_0));
  LUT6 #(
    .INIT(64'h9B6DB49694A56A95)) 
    g8_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b54_n_0));
  LUT6 #(
    .INIT(64'h871C738E739CE673)) 
    g8_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b55_n_0));
  LUT6 #(
    .INIT(64'h80FC0F81F07C1E0F)) 
    g8_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b56_n_0));
  LUT6 #(
    .INIT(64'h8003FF800FFC01FF)) 
    g8_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b57_n_0));
  LUT6 #(
    .INIT(64'h7FFFFF800003FFFF)) 
    g8_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b58_n_0));
  LUT6 #(
    .INIT(64'h0000007FFFFFFFFF)) 
    g8_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b59_n_0));
  LUT6 #(
    .INIT(64'hD14087CA1952D676)) 
    g8_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b6_n_0));
  LUT6 #(
    .INIT(64'hCAF36FFB86E4C2EE)) 
    g8_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b7_n_0));
  LUT6 #(
    .INIT(64'h0A47A006F6CBF95E)) 
    g8_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b8_n_0));
  LUT6 #(
    .INIT(64'h7D5CF9983FE21794)) 
    g8_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g8_b9_n_0));
  LUT6 #(
    .INIT(64'h1A5056BA469DC9F2)) 
    g9_b0
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b0_n_0));
  LUT6 #(
    .INIT(64'h4619CFA19B8E5570)) 
    g9_b1
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b1_n_0));
  LUT6 #(
    .INIT(64'h50D81A91C1E354E6)) 
    g9_b10
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b10_n_0));
  LUT6 #(
    .INIT(64'h568B2FE9A679542D)) 
    g9_b11
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b11_n_0));
  LUT6 #(
    .INIT(64'h46034445BC3AEFA7)) 
    g9_b12
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b12_n_0));
  LUT6 #(
    .INIT(64'h4CF982833D4682DD)) 
    g9_b13
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b13_n_0));
  LUT6 #(
    .INIT(64'hBDADFE55C32B01A9)) 
    g9_b14
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b14_n_0));
  LUT6 #(
    .INIT(64'hA931FE3355B3FF9B)) 
    g9_b15
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b15_n_0));
  LUT6 #(
    .INIT(64'hCE3E01F0CC96AAD2)) 
    g9_b16
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b16_n_0));
  LUT6 #(
    .INIT(64'h0FC0000FC38E6649)) 
    g9_b17
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b17_n_0));
  LUT6 #(
    .INIT(64'h5AAAAAAA952B4B6D)) 
    g9_b18
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b18_n_0));
  LUT6 #(
    .INIT(64'h9333333319CC738E)) 
    g9_b19
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b19_n_0));
  LUT6 #(
    .INIT(64'h0B05C0E2B41FF95D)) 
    g9_b2
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b2_n_0));
  LUT6 #(
    .INIT(64'h496969694B5AD6A5)) 
    g9_b20
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b20_n_0));
  LUT6 #(
    .INIT(64'h38E718E738C6319C)) 
    g9_b21
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b21_n_0));
  LUT6 #(
    .INIT(64'hF81F07E0F83E0F83)) 
    g9_b22
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b22_n_0));
  LUT6 #(
    .INIT(64'h07FF001FF801FF80)) 
    g9_b23
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b23_n_0));
  LUT6 #(
    .INIT(64'hFFFF000007FFFF80)) 
    g9_b24
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b24_n_0));
  LUT6 #(
    .INIT(64'h0000FFFFFFFFFF80)) 
    g9_b25
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b25_n_0));
  LUT6 #(
    .INIT(64'hF198D1D89C1DFABF)) 
    g9_b3
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b3_n_0));
  LUT6 #(
    .INIT(64'h96B77A9AF89FE443)) 
    g9_b30
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b30_n_0));
  LUT6 #(
    .INIT(64'h6F7AFCD3050895F0)) 
    g9_b31
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b31_n_0));
  LUT6 #(
    .INIT(64'hF50355B6A9FAF1DE)) 
    g9_b32
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b32_n_0));
  LUT6 #(
    .INIT(64'h9FCF55E802CA9507)) 
    g9_b33
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b33_n_0));
  LUT6 #(
    .INIT(64'hA22E44EEEED75176)) 
    g9_b34
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b34_n_0));
  LUT6 #(
    .INIT(64'hC14EE44E4E616C73)) 
    g9_b35
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b35_n_0));
  LUT6 #(
    .INIT(64'h00DB7BDB71D58324)) 
    g9_b36
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b36_n_0));
  LUT6 #(
    .INIT(64'hFFC6D56C7FCCAA47)) 
    g9_b37
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b37_n_0));
  LUT6 #(
    .INIT(64'hAA94998F803C66D2)) 
    g9_b38
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b38_n_0));
  LUT6 #(
    .INIT(64'h3318E1F00003E1CE)) 
    g9_b39
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b39_n_0));
  LUT6 #(
    .INIT(64'h940090A38757C525)) 
    g9_b4
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b4_n_0));
  LUT6 #(
    .INIT(64'h3C1F01FFFFFFE03E)) 
    g9_b40
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b40_n_0));
  LUT6 #(
    .INIT(64'h954AAB5555554AAB)) 
    g9_b41
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b41_n_0));
  LUT6 #(
    .INIT(64'h8CC6673333332666)) 
    g9_b42
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b42_n_0));
  LUT6 #(
    .INIT(64'h83C1E0F0F0F0E1E1)) 
    g9_b43
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b43_n_0));
  LUT6 #(
    .INIT(64'h803FE00FF00FE01F)) 
    g9_b44
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b44_n_0));
  LUT6 #(
    .INIT(64'h7FFFE0000FFFE000)) 
    g9_b45
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b45_n_0));
  LUT6 #(
    .INIT(64'hFFFFE00000001FFF)) 
    g9_b46
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b46_n_0));
  LUT6 #(
    .INIT(64'h00001FFFFFFFFFFF)) 
    g9_b48
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b48_n_0));
  LUT6 #(
    .INIT(64'h326A8FF6B8A71795)) 
    g9_b5
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b5_n_0));
  LUT6 #(
    .INIT(64'hD809F308B0F01652)) 
    g9_b50
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b50_n_0));
  LUT6 #(
    .INIT(64'h92E334DB03ECCD08)) 
    g9_b51
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b51_n_0));
  LUT6 #(
    .INIT(64'h138C37F783E3C339)) 
    g9_b52
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b52_n_0));
  LUT6 #(
    .INIT(64'h1C0FC8007D4A95AD)) 
    g9_b53
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b53_n_0));
  LUT6 #(
    .INIT(64'h4AA5555554D9B364)) 
    g9_b54
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b54_n_0));
  LUT6 #(
    .INIT(64'h399CCCCCCC3870E3)) 
    g9_b55
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b55_n_0));
  LUT6 #(
    .INIT(64'hF87C3C3C3C07F01F)) 
    g9_b56
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b56_n_0));
  LUT6 #(
    .INIT(64'hF803FC03FC000FFF)) 
    g9_b57
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b57_n_0));
  LUT6 #(
    .INIT(64'hF80003FFFC000000)) 
    g9_b58
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b58_n_0));
  LUT6 #(
    .INIT(64'h07FFFFFFFC000000)) 
    g9_b59
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b59_n_0));
  LUT6 #(
    .INIT(64'h8E953FB7AAE118E8)) 
    g9_b6
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFFE000)) 
    g9_b62
       (.I0(a[1]),
        .I1(a[2]),
        .I2(a[3]),
        .I3(a[4]),
        .I4(a[5]),
        .O(g9_b62_n_0));
  LUT6 #(
    .INIT(64'h81A24CAA4CE82C8B)) 
    g9_b7
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b7_n_0));
  LUT6 #(
    .INIT(64'hE60DB4E35A4F47EB)) 
    g9_b8
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b8_n_0));
  LUT6 #(
    .INIT(64'h708BD336C62582E3)) 
    g9_b9
       (.I0(a[0]),
        .I1(a[1]),
        .I2(a[2]),
        .I3(a[3]),
        .I4(a[4]),
        .I5(a[5]),
        .O(g9_b9_n_0));
  MUXF7 \spo[0]_INST_0 
       (.I0(\spo[0]_INST_0_i_1_n_0 ),
        .I1(\spo[0]_INST_0_i_2_n_0 ),
        .O(\^spo [0]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[0]_INST_0_i_1 
       (.I0(\spo[0]_INST_0_i_3_n_0 ),
        .I1(\spo[0]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[0]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[0]_INST_0_i_6_n_0 ),
        .O(\spo[0]_INST_0_i_1_n_0 ));
  MUXF7 \spo[0]_INST_0_i_10 
       (.I0(g8_b0_n_0),
        .I1(g9_b0_n_0),
        .O(\spo[0]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[0]_INST_0_i_2 
       (.I0(\spo[0]_INST_0_i_7_n_0 ),
        .I1(\spo[0]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[0]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[0]_INST_0_i_10_n_0 ),
        .O(\spo[0]_INST_0_i_2_n_0 ));
  MUXF7 \spo[0]_INST_0_i_3 
       (.I0(g6_b0_n_0),
        .I1(g7_b0_n_0),
        .O(\spo[0]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[0]_INST_0_i_4 
       (.I0(g4_b0_n_0),
        .I1(g5_b0_n_0),
        .O(\spo[0]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[0]_INST_0_i_5 
       (.I0(g2_b0_n_0),
        .I1(g3_b0_n_0),
        .O(\spo[0]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[0]_INST_0_i_6 
       (.I0(g0_b0_n_0),
        .I1(g1_b0_n_0),
        .O(\spo[0]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[0]_INST_0_i_7 
       (.I0(g14_b0_n_0),
        .I1(g15_b0_n_0),
        .O(\spo[0]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[0]_INST_0_i_8 
       (.I0(g12_b0_n_0),
        .I1(g13_b0_n_0),
        .O(\spo[0]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[0]_INST_0_i_9 
       (.I0(g10_b0_n_0),
        .I1(g11_b0_n_0),
        .O(\spo[0]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0 
       (.I0(\spo[10]_INST_0_i_1_n_0 ),
        .I1(\spo[10]_INST_0_i_2_n_0 ),
        .O(\^spo [10]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[10]_INST_0_i_1 
       (.I0(\spo[10]_INST_0_i_3_n_0 ),
        .I1(\spo[10]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[10]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[10]_INST_0_i_6_n_0 ),
        .O(\spo[10]_INST_0_i_1_n_0 ));
  MUXF7 \spo[10]_INST_0_i_10 
       (.I0(g8_b10_n_0),
        .I1(g9_b10_n_0),
        .O(\spo[10]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[10]_INST_0_i_2 
       (.I0(\spo[10]_INST_0_i_7_n_0 ),
        .I1(\spo[10]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[10]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[10]_INST_0_i_10_n_0 ),
        .O(\spo[10]_INST_0_i_2_n_0 ));
  MUXF7 \spo[10]_INST_0_i_3 
       (.I0(g6_b10_n_0),
        .I1(g7_b10_n_0),
        .O(\spo[10]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_4 
       (.I0(g4_b10_n_0),
        .I1(g5_b10_n_0),
        .O(\spo[10]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_5 
       (.I0(g2_b10_n_0),
        .I1(g3_b10_n_0),
        .O(\spo[10]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_6 
       (.I0(g0_b10_n_0),
        .I1(g1_b10_n_0),
        .O(\spo[10]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_7 
       (.I0(g14_b10_n_0),
        .I1(g15_b10_n_0),
        .O(\spo[10]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_8 
       (.I0(g12_b10_n_0),
        .I1(g13_b10_n_0),
        .O(\spo[10]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[10]_INST_0_i_9 
       (.I0(g10_b10_n_0),
        .I1(g11_b10_n_0),
        .O(\spo[10]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0 
       (.I0(\spo[11]_INST_0_i_1_n_0 ),
        .I1(\spo[11]_INST_0_i_2_n_0 ),
        .O(\^spo [11]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[11]_INST_0_i_1 
       (.I0(\spo[11]_INST_0_i_3_n_0 ),
        .I1(\spo[11]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[11]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[11]_INST_0_i_6_n_0 ),
        .O(\spo[11]_INST_0_i_1_n_0 ));
  MUXF7 \spo[11]_INST_0_i_10 
       (.I0(g8_b11_n_0),
        .I1(g9_b11_n_0),
        .O(\spo[11]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[11]_INST_0_i_2 
       (.I0(\spo[11]_INST_0_i_7_n_0 ),
        .I1(\spo[11]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[11]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[11]_INST_0_i_10_n_0 ),
        .O(\spo[11]_INST_0_i_2_n_0 ));
  MUXF7 \spo[11]_INST_0_i_3 
       (.I0(g6_b11_n_0),
        .I1(g7_b11_n_0),
        .O(\spo[11]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_4 
       (.I0(g4_b11_n_0),
        .I1(g5_b11_n_0),
        .O(\spo[11]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_5 
       (.I0(g2_b11_n_0),
        .I1(g3_b11_n_0),
        .O(\spo[11]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_6 
       (.I0(g0_b11_n_0),
        .I1(g1_b11_n_0),
        .O(\spo[11]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_7 
       (.I0(g14_b11_n_0),
        .I1(g15_b11_n_0),
        .O(\spo[11]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_8 
       (.I0(g12_b11_n_0),
        .I1(g13_b11_n_0),
        .O(\spo[11]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[11]_INST_0_i_9 
       (.I0(g10_b11_n_0),
        .I1(g11_b11_n_0),
        .O(\spo[11]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0 
       (.I0(\spo[12]_INST_0_i_1_n_0 ),
        .I1(\spo[12]_INST_0_i_2_n_0 ),
        .O(\^spo [12]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[12]_INST_0_i_1 
       (.I0(\spo[12]_INST_0_i_3_n_0 ),
        .I1(\spo[12]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[12]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[12]_INST_0_i_6_n_0 ),
        .O(\spo[12]_INST_0_i_1_n_0 ));
  MUXF7 \spo[12]_INST_0_i_10 
       (.I0(g8_b12_n_0),
        .I1(g9_b12_n_0),
        .O(\spo[12]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[12]_INST_0_i_2 
       (.I0(\spo[12]_INST_0_i_7_n_0 ),
        .I1(\spo[12]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[12]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[12]_INST_0_i_10_n_0 ),
        .O(\spo[12]_INST_0_i_2_n_0 ));
  MUXF7 \spo[12]_INST_0_i_3 
       (.I0(g6_b12_n_0),
        .I1(g7_b12_n_0),
        .O(\spo[12]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0_i_4 
       (.I0(g4_b12_n_0),
        .I1(g5_b12_n_0),
        .O(\spo[12]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0_i_5 
       (.I0(g2_b12_n_0),
        .I1(g3_b12_n_0),
        .O(\spo[12]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0_i_6 
       (.I0(g0_b12_n_0),
        .I1(g1_b12_n_0),
        .O(\spo[12]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0_i_7 
       (.I0(g14_b12_n_0),
        .I1(g15_b12_n_0),
        .O(\spo[12]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0_i_8 
       (.I0(g12_b12_n_0),
        .I1(g13_b12_n_0),
        .O(\spo[12]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[12]_INST_0_i_9 
       (.I0(g10_b12_n_0),
        .I1(g11_b12_n_0),
        .O(\spo[12]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0 
       (.I0(\spo[13]_INST_0_i_1_n_0 ),
        .I1(\spo[13]_INST_0_i_2_n_0 ),
        .O(\^spo [13]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[13]_INST_0_i_1 
       (.I0(\spo[13]_INST_0_i_3_n_0 ),
        .I1(\spo[13]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[13]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[13]_INST_0_i_6_n_0 ),
        .O(\spo[13]_INST_0_i_1_n_0 ));
  MUXF7 \spo[13]_INST_0_i_10 
       (.I0(g8_b13_n_0),
        .I1(g9_b13_n_0),
        .O(\spo[13]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[13]_INST_0_i_2 
       (.I0(\spo[13]_INST_0_i_7_n_0 ),
        .I1(\spo[13]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[13]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[13]_INST_0_i_10_n_0 ),
        .O(\spo[13]_INST_0_i_2_n_0 ));
  MUXF7 \spo[13]_INST_0_i_3 
       (.I0(g6_b13_n_0),
        .I1(g7_b13_n_0),
        .O(\spo[13]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_4 
       (.I0(g4_b13_n_0),
        .I1(g5_b13_n_0),
        .O(\spo[13]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_5 
       (.I0(g2_b13_n_0),
        .I1(g3_b13_n_0),
        .O(\spo[13]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_6 
       (.I0(g0_b13_n_0),
        .I1(g1_b13_n_0),
        .O(\spo[13]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_7 
       (.I0(g14_b13_n_0),
        .I1(g15_b13_n_0),
        .O(\spo[13]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_8 
       (.I0(g12_b13_n_0),
        .I1(g13_b13_n_0),
        .O(\spo[13]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[13]_INST_0_i_9 
       (.I0(g10_b13_n_0),
        .I1(g11_b13_n_0),
        .O(\spo[13]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0 
       (.I0(\spo[14]_INST_0_i_1_n_0 ),
        .I1(\spo[14]_INST_0_i_2_n_0 ),
        .O(\^spo [14]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[14]_INST_0_i_1 
       (.I0(\spo[14]_INST_0_i_3_n_0 ),
        .I1(\spo[14]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[14]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[14]_INST_0_i_6_n_0 ),
        .O(\spo[14]_INST_0_i_1_n_0 ));
  MUXF7 \spo[14]_INST_0_i_10 
       (.I0(g8_b14_n_0),
        .I1(g9_b14_n_0),
        .O(\spo[14]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[14]_INST_0_i_2 
       (.I0(\spo[14]_INST_0_i_7_n_0 ),
        .I1(\spo[14]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[14]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[14]_INST_0_i_10_n_0 ),
        .O(\spo[14]_INST_0_i_2_n_0 ));
  MUXF7 \spo[14]_INST_0_i_3 
       (.I0(g6_b14_n_0),
        .I1(g7_b14_n_0),
        .O(\spo[14]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0_i_4 
       (.I0(g4_b14_n_0),
        .I1(g5_b14_n_0),
        .O(\spo[14]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0_i_5 
       (.I0(g2_b14_n_0),
        .I1(g3_b14_n_0),
        .O(\spo[14]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0_i_6 
       (.I0(g0_b14_n_0),
        .I1(g1_b14_n_0),
        .O(\spo[14]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0_i_7 
       (.I0(g14_b14_n_0),
        .I1(g15_b14_n_0),
        .O(\spo[14]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0_i_8 
       (.I0(g12_b14_n_0),
        .I1(g13_b14_n_0),
        .O(\spo[14]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[14]_INST_0_i_9 
       (.I0(g10_b14_n_0),
        .I1(g11_b14_n_0),
        .O(\spo[14]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0 
       (.I0(\spo[15]_INST_0_i_1_n_0 ),
        .I1(\spo[15]_INST_0_i_2_n_0 ),
        .O(\^spo [15]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[15]_INST_0_i_1 
       (.I0(\spo[15]_INST_0_i_3_n_0 ),
        .I1(\spo[15]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[15]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[15]_INST_0_i_6_n_0 ),
        .O(\spo[15]_INST_0_i_1_n_0 ));
  MUXF7 \spo[15]_INST_0_i_10 
       (.I0(g8_b15_n_0),
        .I1(g9_b15_n_0),
        .O(\spo[15]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[15]_INST_0_i_2 
       (.I0(\spo[15]_INST_0_i_7_n_0 ),
        .I1(\spo[15]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[15]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[15]_INST_0_i_10_n_0 ),
        .O(\spo[15]_INST_0_i_2_n_0 ));
  MUXF7 \spo[15]_INST_0_i_3 
       (.I0(g6_b15_n_0),
        .I1(g7_b15_n_0),
        .O(\spo[15]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_4 
       (.I0(g4_b15_n_0),
        .I1(g5_b15_n_0),
        .O(\spo[15]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_5 
       (.I0(g2_b15_n_0),
        .I1(g3_b15_n_0),
        .O(\spo[15]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_6 
       (.I0(g0_b15_n_0),
        .I1(g1_b15_n_0),
        .O(\spo[15]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_7 
       (.I0(g14_b15_n_0),
        .I1(g15_b15_n_0),
        .O(\spo[15]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_8 
       (.I0(g12_b15_n_0),
        .I1(g13_b15_n_0),
        .O(\spo[15]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[15]_INST_0_i_9 
       (.I0(g10_b15_n_0),
        .I1(g11_b15_n_0),
        .O(\spo[15]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0 
       (.I0(\spo[16]_INST_0_i_1_n_0 ),
        .I1(\spo[16]_INST_0_i_2_n_0 ),
        .O(\^spo [16]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[16]_INST_0_i_1 
       (.I0(\spo[16]_INST_0_i_3_n_0 ),
        .I1(\spo[16]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[16]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[16]_INST_0_i_6_n_0 ),
        .O(\spo[16]_INST_0_i_1_n_0 ));
  MUXF7 \spo[16]_INST_0_i_10 
       (.I0(g8_b16_n_0),
        .I1(g9_b16_n_0),
        .O(\spo[16]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[16]_INST_0_i_2 
       (.I0(\spo[16]_INST_0_i_7_n_0 ),
        .I1(\spo[16]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[16]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[16]_INST_0_i_10_n_0 ),
        .O(\spo[16]_INST_0_i_2_n_0 ));
  MUXF7 \spo[16]_INST_0_i_3 
       (.I0(g6_b16_n_0),
        .I1(g7_b16_n_0),
        .O(\spo[16]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_4 
       (.I0(g4_b16_n_0),
        .I1(g5_b16_n_0),
        .O(\spo[16]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_5 
       (.I0(g2_b16_n_0),
        .I1(g3_b16_n_0),
        .O(\spo[16]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_6 
       (.I0(g0_b16_n_0),
        .I1(g1_b16_n_0),
        .O(\spo[16]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_7 
       (.I0(g14_b16_n_0),
        .I1(g15_b16_n_0),
        .O(\spo[16]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_8 
       (.I0(g12_b16_n_0),
        .I1(g13_b16_n_0),
        .O(\spo[16]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[16]_INST_0_i_9 
       (.I0(g10_b16_n_0),
        .I1(g11_b16_n_0),
        .O(\spo[16]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0 
       (.I0(\spo[17]_INST_0_i_1_n_0 ),
        .I1(\spo[17]_INST_0_i_2_n_0 ),
        .O(\^spo [17]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[17]_INST_0_i_1 
       (.I0(\spo[17]_INST_0_i_3_n_0 ),
        .I1(\spo[17]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[17]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[17]_INST_0_i_6_n_0 ),
        .O(\spo[17]_INST_0_i_1_n_0 ));
  MUXF7 \spo[17]_INST_0_i_10 
       (.I0(g8_b17_n_0),
        .I1(g9_b17_n_0),
        .O(\spo[17]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[17]_INST_0_i_2 
       (.I0(\spo[17]_INST_0_i_7_n_0 ),
        .I1(\spo[17]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[17]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[17]_INST_0_i_10_n_0 ),
        .O(\spo[17]_INST_0_i_2_n_0 ));
  MUXF7 \spo[17]_INST_0_i_3 
       (.I0(g6_b17_n_0),
        .I1(g7_b17_n_0),
        .O(\spo[17]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_4 
       (.I0(g4_b17_n_0),
        .I1(g5_b17_n_0),
        .O(\spo[17]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_5 
       (.I0(g2_b17_n_0),
        .I1(g3_b17_n_0),
        .O(\spo[17]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_6 
       (.I0(g0_b17_n_0),
        .I1(g1_b17_n_0),
        .O(\spo[17]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_7 
       (.I0(g14_b17_n_0),
        .I1(g15_b17_n_0),
        .O(\spo[17]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_8 
       (.I0(g12_b17_n_0),
        .I1(g13_b17_n_0),
        .O(\spo[17]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[17]_INST_0_i_9 
       (.I0(g10_b17_n_0),
        .I1(g11_b17_n_0),
        .O(\spo[17]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0 
       (.I0(\spo[18]_INST_0_i_1_n_0 ),
        .I1(\spo[18]_INST_0_i_2_n_0 ),
        .O(\^spo [18]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[18]_INST_0_i_1 
       (.I0(\spo[18]_INST_0_i_3_n_0 ),
        .I1(\spo[18]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[18]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[18]_INST_0_i_6_n_0 ),
        .O(\spo[18]_INST_0_i_1_n_0 ));
  MUXF7 \spo[18]_INST_0_i_10 
       (.I0(g8_b18_n_0),
        .I1(g9_b18_n_0),
        .O(\spo[18]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[18]_INST_0_i_2 
       (.I0(\spo[18]_INST_0_i_7_n_0 ),
        .I1(\spo[18]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[18]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[18]_INST_0_i_10_n_0 ),
        .O(\spo[18]_INST_0_i_2_n_0 ));
  MUXF7 \spo[18]_INST_0_i_3 
       (.I0(g6_b18_n_0),
        .I1(g7_b18_n_0),
        .O(\spo[18]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_4 
       (.I0(g4_b18_n_0),
        .I1(g5_b18_n_0),
        .O(\spo[18]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_5 
       (.I0(g2_b18_n_0),
        .I1(g3_b18_n_0),
        .O(\spo[18]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_6 
       (.I0(g0_b18_n_0),
        .I1(g1_b18_n_0),
        .O(\spo[18]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_7 
       (.I0(g14_b18_n_0),
        .I1(g15_b18_n_0),
        .O(\spo[18]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_8 
       (.I0(g12_b18_n_0),
        .I1(g13_b18_n_0),
        .O(\spo[18]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[18]_INST_0_i_9 
       (.I0(g10_b18_n_0),
        .I1(g11_b18_n_0),
        .O(\spo[18]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0 
       (.I0(\spo[19]_INST_0_i_1_n_0 ),
        .I1(\spo[19]_INST_0_i_2_n_0 ),
        .O(\^spo [19]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[19]_INST_0_i_1 
       (.I0(\spo[19]_INST_0_i_3_n_0 ),
        .I1(\spo[19]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[19]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[19]_INST_0_i_6_n_0 ),
        .O(\spo[19]_INST_0_i_1_n_0 ));
  MUXF7 \spo[19]_INST_0_i_10 
       (.I0(g8_b19_n_0),
        .I1(g9_b19_n_0),
        .O(\spo[19]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[19]_INST_0_i_2 
       (.I0(\spo[19]_INST_0_i_7_n_0 ),
        .I1(\spo[19]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[19]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[19]_INST_0_i_10_n_0 ),
        .O(\spo[19]_INST_0_i_2_n_0 ));
  MUXF7 \spo[19]_INST_0_i_3 
       (.I0(g6_b19_n_0),
        .I1(g7_b19_n_0),
        .O(\spo[19]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_4 
       (.I0(g4_b19_n_0),
        .I1(g5_b19_n_0),
        .O(\spo[19]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_5 
       (.I0(g2_b19_n_0),
        .I1(g3_b19_n_0),
        .O(\spo[19]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_6 
       (.I0(g0_b19_n_0),
        .I1(g1_b19_n_0),
        .O(\spo[19]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_7 
       (.I0(g14_b19_n_0),
        .I1(g15_b19_n_0),
        .O(\spo[19]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_8 
       (.I0(g12_b19_n_0),
        .I1(g13_b19_n_0),
        .O(\spo[19]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[19]_INST_0_i_9 
       (.I0(g10_b19_n_0),
        .I1(g11_b19_n_0),
        .O(\spo[19]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0 
       (.I0(\spo[1]_INST_0_i_1_n_0 ),
        .I1(\spo[1]_INST_0_i_2_n_0 ),
        .O(\^spo [1]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_1 
       (.I0(\spo[1]_INST_0_i_3_n_0 ),
        .I1(\spo[1]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[1]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[1]_INST_0_i_6_n_0 ),
        .O(\spo[1]_INST_0_i_1_n_0 ));
  MUXF7 \spo[1]_INST_0_i_10 
       (.I0(g8_b1_n_0),
        .I1(g9_b1_n_0),
        .O(\spo[1]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[1]_INST_0_i_2 
       (.I0(\spo[1]_INST_0_i_7_n_0 ),
        .I1(\spo[1]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[1]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[1]_INST_0_i_10_n_0 ),
        .O(\spo[1]_INST_0_i_2_n_0 ));
  MUXF7 \spo[1]_INST_0_i_3 
       (.I0(g6_b1_n_0),
        .I1(g7_b1_n_0),
        .O(\spo[1]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0_i_4 
       (.I0(g4_b1_n_0),
        .I1(g5_b1_n_0),
        .O(\spo[1]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0_i_5 
       (.I0(g2_b1_n_0),
        .I1(g3_b1_n_0),
        .O(\spo[1]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0_i_6 
       (.I0(g0_b1_n_0),
        .I1(g1_b1_n_0),
        .O(\spo[1]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0_i_7 
       (.I0(g14_b1_n_0),
        .I1(g15_b1_n_0),
        .O(\spo[1]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0_i_8 
       (.I0(g12_b1_n_0),
        .I1(g13_b1_n_0),
        .O(\spo[1]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[1]_INST_0_i_9 
       (.I0(g10_b1_n_0),
        .I1(g11_b1_n_0),
        .O(\spo[1]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0 
       (.I0(\spo[20]_INST_0_i_1_n_0 ),
        .I1(\spo[20]_INST_0_i_2_n_0 ),
        .O(\^spo [20]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[20]_INST_0_i_1 
       (.I0(\spo[20]_INST_0_i_3_n_0 ),
        .I1(\spo[20]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[20]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[20]_INST_0_i_6_n_0 ),
        .O(\spo[20]_INST_0_i_1_n_0 ));
  MUXF7 \spo[20]_INST_0_i_10 
       (.I0(g8_b20_n_0),
        .I1(g9_b20_n_0),
        .O(\spo[20]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[20]_INST_0_i_2 
       (.I0(\spo[20]_INST_0_i_7_n_0 ),
        .I1(\spo[20]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[20]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[20]_INST_0_i_10_n_0 ),
        .O(\spo[20]_INST_0_i_2_n_0 ));
  MUXF7 \spo[20]_INST_0_i_3 
       (.I0(g6_b20_n_0),
        .I1(g7_b20_n_0),
        .O(\spo[20]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_4 
       (.I0(g4_b20_n_0),
        .I1(g5_b20_n_0),
        .O(\spo[20]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_5 
       (.I0(g2_b20_n_0),
        .I1(g3_b20_n_0),
        .O(\spo[20]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_6 
       (.I0(g0_b20_n_0),
        .I1(g1_b20_n_0),
        .O(\spo[20]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_7 
       (.I0(g14_b20_n_0),
        .I1(g15_b20_n_0),
        .O(\spo[20]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_8 
       (.I0(g12_b20_n_0),
        .I1(g13_b20_n_0),
        .O(\spo[20]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[20]_INST_0_i_9 
       (.I0(g10_b20_n_0),
        .I1(g11_b20_n_0),
        .O(\spo[20]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0 
       (.I0(\spo[21]_INST_0_i_1_n_0 ),
        .I1(\spo[21]_INST_0_i_2_n_0 ),
        .O(\^spo [21]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[21]_INST_0_i_1 
       (.I0(\spo[21]_INST_0_i_3_n_0 ),
        .I1(\spo[21]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[21]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[21]_INST_0_i_6_n_0 ),
        .O(\spo[21]_INST_0_i_1_n_0 ));
  MUXF7 \spo[21]_INST_0_i_10 
       (.I0(g8_b21_n_0),
        .I1(g9_b21_n_0),
        .O(\spo[21]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[21]_INST_0_i_2 
       (.I0(\spo[21]_INST_0_i_7_n_0 ),
        .I1(\spo[21]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[21]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[21]_INST_0_i_10_n_0 ),
        .O(\spo[21]_INST_0_i_2_n_0 ));
  MUXF7 \spo[21]_INST_0_i_3 
       (.I0(g6_b21_n_0),
        .I1(g7_b21_n_0),
        .O(\spo[21]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_4 
       (.I0(g4_b21_n_0),
        .I1(g5_b21_n_0),
        .O(\spo[21]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_5 
       (.I0(g2_b21_n_0),
        .I1(g3_b21_n_0),
        .O(\spo[21]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_6 
       (.I0(g0_b21_n_0),
        .I1(g1_b21_n_0),
        .O(\spo[21]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_7 
       (.I0(g14_b21_n_0),
        .I1(g15_b21_n_0),
        .O(\spo[21]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_8 
       (.I0(g12_b21_n_0),
        .I1(g13_b21_n_0),
        .O(\spo[21]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[21]_INST_0_i_9 
       (.I0(g10_b21_n_0),
        .I1(g11_b21_n_0),
        .O(\spo[21]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0 
       (.I0(\spo[22]_INST_0_i_1_n_0 ),
        .I1(\spo[22]_INST_0_i_2_n_0 ),
        .O(\^spo [22]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[22]_INST_0_i_1 
       (.I0(\spo[22]_INST_0_i_3_n_0 ),
        .I1(\spo[22]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[22]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[22]_INST_0_i_6_n_0 ),
        .O(\spo[22]_INST_0_i_1_n_0 ));
  MUXF7 \spo[22]_INST_0_i_10 
       (.I0(g8_b22_n_0),
        .I1(g9_b22_n_0),
        .O(\spo[22]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[22]_INST_0_i_2 
       (.I0(\spo[22]_INST_0_i_7_n_0 ),
        .I1(\spo[22]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[22]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[22]_INST_0_i_10_n_0 ),
        .O(\spo[22]_INST_0_i_2_n_0 ));
  MUXF7 \spo[22]_INST_0_i_3 
       (.I0(g6_b22_n_0),
        .I1(g7_b22_n_0),
        .O(\spo[22]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_4 
       (.I0(g4_b22_n_0),
        .I1(g5_b22_n_0),
        .O(\spo[22]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_5 
       (.I0(g2_b22_n_0),
        .I1(g3_b22_n_0),
        .O(\spo[22]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_6 
       (.I0(g0_b22_n_0),
        .I1(g1_b22_n_0),
        .O(\spo[22]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_7 
       (.I0(g14_b22_n_0),
        .I1(g15_b22_n_0),
        .O(\spo[22]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_8 
       (.I0(g12_b22_n_0),
        .I1(g13_b22_n_0),
        .O(\spo[22]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[22]_INST_0_i_9 
       (.I0(g10_b22_n_0),
        .I1(g11_b22_n_0),
        .O(\spo[22]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0 
       (.I0(\spo[23]_INST_0_i_1_n_0 ),
        .I1(\spo[23]_INST_0_i_2_n_0 ),
        .O(\^spo [23]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[23]_INST_0_i_1 
       (.I0(\spo[23]_INST_0_i_3_n_0 ),
        .I1(\spo[23]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[23]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[23]_INST_0_i_6_n_0 ),
        .O(\spo[23]_INST_0_i_1_n_0 ));
  MUXF7 \spo[23]_INST_0_i_10 
       (.I0(g8_b23_n_0),
        .I1(g9_b23_n_0),
        .O(\spo[23]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[23]_INST_0_i_2 
       (.I0(\spo[23]_INST_0_i_7_n_0 ),
        .I1(\spo[23]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[23]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[23]_INST_0_i_10_n_0 ),
        .O(\spo[23]_INST_0_i_2_n_0 ));
  MUXF7 \spo[23]_INST_0_i_3 
       (.I0(g6_b23_n_0),
        .I1(g7_b23_n_0),
        .O(\spo[23]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_4 
       (.I0(g4_b23_n_0),
        .I1(g5_b23_n_0),
        .O(\spo[23]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_5 
       (.I0(g2_b23_n_0),
        .I1(g3_b23_n_0),
        .O(\spo[23]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_6 
       (.I0(g0_b23_n_0),
        .I1(g1_b23_n_0),
        .O(\spo[23]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_7 
       (.I0(g14_b23_n_0),
        .I1(g15_b23_n_0),
        .O(\spo[23]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_8 
       (.I0(g12_b23_n_0),
        .I1(g13_b23_n_0),
        .O(\spo[23]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[23]_INST_0_i_9 
       (.I0(g10_b23_n_0),
        .I1(g11_b23_n_0),
        .O(\spo[23]_INST_0_i_9_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[24]_INST_0 
       (.I0(\spo[24]_INST_0_i_1_n_0 ),
        .I1(\spo[24]_INST_0_i_2_n_0 ),
        .I2(a[9]),
        .I3(\spo[24]_INST_0_i_3_n_0 ),
        .I4(a[8]),
        .I5(\spo[24]_INST_0_i_4_n_0 ),
        .O(\^spo [24]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[24]_INST_0_i_1 
       (.I0(a[5]),
        .I1(g14_b24_n_0),
        .I2(a[7]),
        .I3(g13_b24_n_0),
        .I4(a[6]),
        .I5(g12_b24_n_0),
        .O(\spo[24]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[24]_INST_0_i_2 
       (.I0(g11_b24_n_0),
        .I1(g10_b24_n_0),
        .I2(a[7]),
        .I3(g9_b24_n_0),
        .I4(a[6]),
        .I5(g8_b24_n_0),
        .O(\spo[24]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[24]_INST_0_i_3 
       (.I0(g7_b24_n_0),
        .I1(g6_b24_n_0),
        .I2(a[7]),
        .I3(g5_b24_n_0),
        .I4(a[6]),
        .I5(g4_b24_n_0),
        .O(\spo[24]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[24]_INST_0_i_4 
       (.I0(g3_b24_n_0),
        .I1(g2_b24_n_0),
        .I2(a[7]),
        .I3(g1_b24_n_0),
        .I4(a[6]),
        .I5(g0_b24_n_0),
        .O(\spo[24]_INST_0_i_4_n_0 ));
  MUXF8 \spo[25]_INST_0 
       (.I0(\spo[25]_INST_0_i_1_n_0 ),
        .I1(\spo[25]_INST_0_i_2_n_0 ),
        .O(\^spo [25]),
        .S(a[9]));
  MUXF7 \spo[25]_INST_0_i_1 
       (.I0(\spo[25]_INST_0_i_3_n_0 ),
        .I1(\spo[25]_INST_0_i_4_n_0 ),
        .O(\spo[25]_INST_0_i_1_n_0 ),
        .S(a[8]));
  MUXF7 \spo[25]_INST_0_i_2 
       (.I0(\spo[25]_INST_0_i_5_n_0 ),
        .I1(g15_b25_n_0),
        .O(\spo[25]_INST_0_i_2_n_0 ),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[25]_INST_0_i_3 
       (.I0(g3_b25_n_0),
        .I1(g2_b25_n_0),
        .I2(a[7]),
        .I3(g1_b25_n_0),
        .I4(a[6]),
        .I5(g0_b25_n_0),
        .O(\spo[25]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[25]_INST_0_i_4 
       (.I0(g7_b25_n_0),
        .I1(g14_b27_n_0),
        .I2(a[7]),
        .I3(g5_b25_n_0),
        .I4(a[6]),
        .I5(g4_b25_n_0),
        .O(\spo[25]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[25]_INST_0_i_5 
       (.I0(g1_b48_n_0),
        .I1(g10_b26_n_0),
        .I2(a[7]),
        .I3(g9_b25_n_0),
        .I4(a[6]),
        .I5(g8_b25_n_0),
        .O(\spo[25]_INST_0_i_5_n_0 ));
  MUXF8 \spo[26]_INST_0 
       (.I0(\spo[26]_INST_0_i_1_n_0 ),
        .I1(\spo[26]_INST_0_i_2_n_0 ),
        .O(\^spo [26]),
        .S(a[9]));
  MUXF7 \spo[26]_INST_0_i_1 
       (.I0(\spo[26]_INST_0_i_3_n_0 ),
        .I1(\spo[26]_INST_0_i_4_n_0 ),
        .O(\spo[26]_INST_0_i_1_n_0 ),
        .S(a[8]));
  MUXF7 \spo[26]_INST_0_i_2 
       (.I0(\spo[26]_INST_0_i_5_n_0 ),
        .I1(\spo[26]_INST_0_i_6_n_0 ),
        .O(\spo[26]_INST_0_i_2_n_0 ),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[26]_INST_0_i_3 
       (.I0(g3_b26_n_0),
        .I1(g2_b27_n_0),
        .I2(a[7]),
        .I3(g1_b26_n_0),
        .I4(a[6]),
        .I5(g0_b26_n_0),
        .O(\spo[26]_INST_0_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h3B38)) 
    \spo[26]_INST_0_i_4 
       (.I0(g14_b28_n_0),
        .I1(a[7]),
        .I2(a[6]),
        .I3(g4_b26_n_0),
        .O(\spo[26]_INST_0_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFCBBFC88)) 
    \spo[26]_INST_0_i_5 
       (.I0(g10_b26_n_0),
        .I1(a[7]),
        .I2(g4_b47_n_0),
        .I3(a[6]),
        .I4(g0_b28_n_0),
        .O(\spo[26]_INST_0_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hCCB8)) 
    \spo[26]_INST_0_i_6 
       (.I0(g14_b27_n_0),
        .I1(a[7]),
        .I2(g2_b47_n_0),
        .I3(a[6]),
        .O(\spo[26]_INST_0_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h88B8BBBB88B88888)) 
    \spo[27]_INST_0 
       (.I0(\spo[27]_INST_0_i_1_n_0 ),
        .I1(a[9]),
        .I2(\spo[27]_INST_0_i_2_n_0 ),
        .I3(a[7]),
        .I4(a[8]),
        .I5(\spo[27]_INST_0_i_3_n_0 ),
        .O(\^spo [27]));
  LUT6 #(
    .INIT(64'hCC33B833CC33B800)) 
    \spo[27]_INST_0_i_1 
       (.I0(g14_b27_n_0),
        .I1(a[8]),
        .I2(g10_b27_n_0),
        .I3(a[7]),
        .I4(a[6]),
        .I5(g0_b28_n_0),
        .O(\spo[27]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \spo[27]_INST_0_i_2 
       (.I0(g0_b60_n_0),
        .I1(a[6]),
        .O(\spo[27]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFCBBFC88)) 
    \spo[27]_INST_0_i_3 
       (.I0(g2_b27_n_0),
        .I1(a[7]),
        .I2(g1_b27_n_0),
        .I3(a[6]),
        .I4(g0_b28_n_0),
        .O(\spo[27]_INST_0_i_3_n_0 ));
  MUXF7 \spo[28]_INST_0 
       (.I0(\spo[28]_INST_0_i_1_n_0 ),
        .I1(\spo[28]_INST_0_i_2_n_0 ),
        .O(\^spo [28]),
        .S(a[9]));
  LUT5 #(
    .INIT(32'h00003E0E)) 
    \spo[28]_INST_0_i_1 
       (.I0(g0_b28_n_0),
        .I1(a[6]),
        .I2(a[7]),
        .I3(g2_b28_n_0),
        .I4(a[8]),
        .O(\spo[28]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h3F3FBFBC)) 
    \spo[28]_INST_0_i_2 
       (.I0(g14_b28_n_0),
        .I1(a[8]),
        .I2(a[7]),
        .I3(g0_b28_n_0),
        .I4(a[6]),
        .O(\spo[28]_INST_0_i_2_n_0 ));
  MUXF7 \spo[2]_INST_0 
       (.I0(\spo[2]_INST_0_i_1_n_0 ),
        .I1(\spo[2]_INST_0_i_2_n_0 ),
        .O(\^spo [2]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[2]_INST_0_i_1 
       (.I0(\spo[2]_INST_0_i_3_n_0 ),
        .I1(\spo[2]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[2]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[2]_INST_0_i_6_n_0 ),
        .O(\spo[2]_INST_0_i_1_n_0 ));
  MUXF7 \spo[2]_INST_0_i_10 
       (.I0(g8_b2_n_0),
        .I1(g9_b2_n_0),
        .O(\spo[2]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[2]_INST_0_i_2 
       (.I0(\spo[2]_INST_0_i_7_n_0 ),
        .I1(\spo[2]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[2]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[2]_INST_0_i_10_n_0 ),
        .O(\spo[2]_INST_0_i_2_n_0 ));
  MUXF7 \spo[2]_INST_0_i_3 
       (.I0(g6_b2_n_0),
        .I1(g7_b2_n_0),
        .O(\spo[2]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[2]_INST_0_i_4 
       (.I0(g4_b2_n_0),
        .I1(g5_b2_n_0),
        .O(\spo[2]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[2]_INST_0_i_5 
       (.I0(g2_b2_n_0),
        .I1(g3_b2_n_0),
        .O(\spo[2]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[2]_INST_0_i_6 
       (.I0(g0_b2_n_0),
        .I1(g1_b2_n_0),
        .O(\spo[2]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[2]_INST_0_i_7 
       (.I0(g14_b2_n_0),
        .I1(g15_b2_n_0),
        .O(\spo[2]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[2]_INST_0_i_8 
       (.I0(g12_b2_n_0),
        .I1(g13_b2_n_0),
        .O(\spo[2]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[2]_INST_0_i_9 
       (.I0(g10_b2_n_0),
        .I1(g11_b2_n_0),
        .O(\spo[2]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0 
       (.I0(\spo[30]_INST_0_i_1_n_0 ),
        .I1(\spo[30]_INST_0_i_2_n_0 ),
        .O(\^spo [30]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[30]_INST_0_i_1 
       (.I0(\spo[30]_INST_0_i_3_n_0 ),
        .I1(\spo[30]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[30]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[30]_INST_0_i_6_n_0 ),
        .O(\spo[30]_INST_0_i_1_n_0 ));
  MUXF7 \spo[30]_INST_0_i_10 
       (.I0(g8_b30_n_0),
        .I1(g9_b30_n_0),
        .O(\spo[30]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[30]_INST_0_i_2 
       (.I0(\spo[30]_INST_0_i_7_n_0 ),
        .I1(\spo[30]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[30]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[30]_INST_0_i_10_n_0 ),
        .O(\spo[30]_INST_0_i_2_n_0 ));
  MUXF7 \spo[30]_INST_0_i_3 
       (.I0(g6_b30_n_0),
        .I1(g7_b30_n_0),
        .O(\spo[30]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_4 
       (.I0(g4_b30_n_0),
        .I1(g5_b30_n_0),
        .O(\spo[30]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_5 
       (.I0(g2_b30_n_0),
        .I1(g3_b30_n_0),
        .O(\spo[30]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_6 
       (.I0(g0_b30_n_0),
        .I1(g1_b30_n_0),
        .O(\spo[30]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_7 
       (.I0(g14_b30_n_0),
        .I1(g15_b30_n_0),
        .O(\spo[30]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_8 
       (.I0(g12_b30_n_0),
        .I1(g13_b30_n_0),
        .O(\spo[30]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[30]_INST_0_i_9 
       (.I0(g10_b30_n_0),
        .I1(g11_b30_n_0),
        .O(\spo[30]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0 
       (.I0(\spo[31]_INST_0_i_1_n_0 ),
        .I1(\spo[31]_INST_0_i_2_n_0 ),
        .O(\^spo [31]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[31]_INST_0_i_1 
       (.I0(\spo[31]_INST_0_i_3_n_0 ),
        .I1(\spo[31]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[31]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[31]_INST_0_i_6_n_0 ),
        .O(\spo[31]_INST_0_i_1_n_0 ));
  MUXF7 \spo[31]_INST_0_i_10 
       (.I0(g8_b31_n_0),
        .I1(g9_b31_n_0),
        .O(\spo[31]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[31]_INST_0_i_2 
       (.I0(\spo[31]_INST_0_i_7_n_0 ),
        .I1(\spo[31]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[31]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[31]_INST_0_i_10_n_0 ),
        .O(\spo[31]_INST_0_i_2_n_0 ));
  MUXF7 \spo[31]_INST_0_i_3 
       (.I0(g6_b31_n_0),
        .I1(g7_b31_n_0),
        .O(\spo[31]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_4 
       (.I0(g4_b31_n_0),
        .I1(g5_b31_n_0),
        .O(\spo[31]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_5 
       (.I0(g2_b31_n_0),
        .I1(g3_b31_n_0),
        .O(\spo[31]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_6 
       (.I0(g0_b31_n_0),
        .I1(g1_b31_n_0),
        .O(\spo[31]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_7 
       (.I0(g14_b31_n_0),
        .I1(g15_b31_n_0),
        .O(\spo[31]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_8 
       (.I0(g12_b31_n_0),
        .I1(g13_b31_n_0),
        .O(\spo[31]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[31]_INST_0_i_9 
       (.I0(g10_b31_n_0),
        .I1(g11_b31_n_0),
        .O(\spo[31]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0 
       (.I0(\spo[32]_INST_0_i_1_n_0 ),
        .I1(\spo[32]_INST_0_i_2_n_0 ),
        .O(\^spo [32]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[32]_INST_0_i_1 
       (.I0(\spo[32]_INST_0_i_3_n_0 ),
        .I1(\spo[32]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[32]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[32]_INST_0_i_6_n_0 ),
        .O(\spo[32]_INST_0_i_1_n_0 ));
  MUXF7 \spo[32]_INST_0_i_10 
       (.I0(g8_b32_n_0),
        .I1(g9_b32_n_0),
        .O(\spo[32]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[32]_INST_0_i_2 
       (.I0(\spo[32]_INST_0_i_7_n_0 ),
        .I1(\spo[32]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[32]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[32]_INST_0_i_10_n_0 ),
        .O(\spo[32]_INST_0_i_2_n_0 ));
  MUXF7 \spo[32]_INST_0_i_3 
       (.I0(g6_b32_n_0),
        .I1(g7_b32_n_0),
        .O(\spo[32]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0_i_4 
       (.I0(g4_b32_n_0),
        .I1(g5_b32_n_0),
        .O(\spo[32]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0_i_5 
       (.I0(g2_b32_n_0),
        .I1(g3_b32_n_0),
        .O(\spo[32]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0_i_6 
       (.I0(g0_b32_n_0),
        .I1(g1_b32_n_0),
        .O(\spo[32]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0_i_7 
       (.I0(g14_b32_n_0),
        .I1(g15_b32_n_0),
        .O(\spo[32]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0_i_8 
       (.I0(g12_b32_n_0),
        .I1(g13_b32_n_0),
        .O(\spo[32]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[32]_INST_0_i_9 
       (.I0(g10_b32_n_0),
        .I1(g11_b32_n_0),
        .O(\spo[32]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0 
       (.I0(\spo[33]_INST_0_i_1_n_0 ),
        .I1(\spo[33]_INST_0_i_2_n_0 ),
        .O(\^spo [33]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[33]_INST_0_i_1 
       (.I0(\spo[33]_INST_0_i_3_n_0 ),
        .I1(\spo[33]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[33]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[33]_INST_0_i_6_n_0 ),
        .O(\spo[33]_INST_0_i_1_n_0 ));
  MUXF7 \spo[33]_INST_0_i_10 
       (.I0(g8_b33_n_0),
        .I1(g9_b33_n_0),
        .O(\spo[33]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[33]_INST_0_i_2 
       (.I0(\spo[33]_INST_0_i_7_n_0 ),
        .I1(\spo[33]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[33]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[33]_INST_0_i_10_n_0 ),
        .O(\spo[33]_INST_0_i_2_n_0 ));
  MUXF7 \spo[33]_INST_0_i_3 
       (.I0(g6_b33_n_0),
        .I1(g7_b33_n_0),
        .O(\spo[33]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0_i_4 
       (.I0(g4_b33_n_0),
        .I1(g5_b33_n_0),
        .O(\spo[33]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0_i_5 
       (.I0(g2_b33_n_0),
        .I1(g3_b33_n_0),
        .O(\spo[33]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0_i_6 
       (.I0(g0_b33_n_0),
        .I1(g1_b33_n_0),
        .O(\spo[33]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0_i_7 
       (.I0(g14_b33_n_0),
        .I1(g15_b33_n_0),
        .O(\spo[33]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0_i_8 
       (.I0(g12_b33_n_0),
        .I1(g13_b33_n_0),
        .O(\spo[33]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[33]_INST_0_i_9 
       (.I0(g10_b33_n_0),
        .I1(g11_b33_n_0),
        .O(\spo[33]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0 
       (.I0(\spo[34]_INST_0_i_1_n_0 ),
        .I1(\spo[34]_INST_0_i_2_n_0 ),
        .O(\^spo [34]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[34]_INST_0_i_1 
       (.I0(\spo[34]_INST_0_i_3_n_0 ),
        .I1(\spo[34]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[34]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[34]_INST_0_i_6_n_0 ),
        .O(\spo[34]_INST_0_i_1_n_0 ));
  MUXF7 \spo[34]_INST_0_i_10 
       (.I0(g8_b34_n_0),
        .I1(g9_b34_n_0),
        .O(\spo[34]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[34]_INST_0_i_2 
       (.I0(\spo[34]_INST_0_i_7_n_0 ),
        .I1(\spo[34]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[34]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[34]_INST_0_i_10_n_0 ),
        .O(\spo[34]_INST_0_i_2_n_0 ));
  MUXF7 \spo[34]_INST_0_i_3 
       (.I0(g6_b34_n_0),
        .I1(g7_b34_n_0),
        .O(\spo[34]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0_i_4 
       (.I0(g4_b34_n_0),
        .I1(g5_b34_n_0),
        .O(\spo[34]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0_i_5 
       (.I0(g2_b34_n_0),
        .I1(g3_b34_n_0),
        .O(\spo[34]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0_i_6 
       (.I0(g0_b34_n_0),
        .I1(g1_b34_n_0),
        .O(\spo[34]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0_i_7 
       (.I0(g14_b34_n_0),
        .I1(g15_b34_n_0),
        .O(\spo[34]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0_i_8 
       (.I0(g12_b34_n_0),
        .I1(g13_b34_n_0),
        .O(\spo[34]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[34]_INST_0_i_9 
       (.I0(g10_b34_n_0),
        .I1(g11_b34_n_0),
        .O(\spo[34]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0 
       (.I0(\spo[35]_INST_0_i_1_n_0 ),
        .I1(\spo[35]_INST_0_i_2_n_0 ),
        .O(\^spo [35]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[35]_INST_0_i_1 
       (.I0(\spo[35]_INST_0_i_3_n_0 ),
        .I1(\spo[35]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[35]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[35]_INST_0_i_6_n_0 ),
        .O(\spo[35]_INST_0_i_1_n_0 ));
  MUXF7 \spo[35]_INST_0_i_10 
       (.I0(g8_b35_n_0),
        .I1(g9_b35_n_0),
        .O(\spo[35]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[35]_INST_0_i_2 
       (.I0(\spo[35]_INST_0_i_7_n_0 ),
        .I1(\spo[35]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[35]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[35]_INST_0_i_10_n_0 ),
        .O(\spo[35]_INST_0_i_2_n_0 ));
  MUXF7 \spo[35]_INST_0_i_3 
       (.I0(g6_b35_n_0),
        .I1(g7_b35_n_0),
        .O(\spo[35]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0_i_4 
       (.I0(g4_b35_n_0),
        .I1(g5_b35_n_0),
        .O(\spo[35]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0_i_5 
       (.I0(g2_b35_n_0),
        .I1(g3_b35_n_0),
        .O(\spo[35]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0_i_6 
       (.I0(g0_b35_n_0),
        .I1(g1_b35_n_0),
        .O(\spo[35]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0_i_7 
       (.I0(g14_b35_n_0),
        .I1(g15_b35_n_0),
        .O(\spo[35]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0_i_8 
       (.I0(g12_b35_n_0),
        .I1(g13_b35_n_0),
        .O(\spo[35]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[35]_INST_0_i_9 
       (.I0(g10_b35_n_0),
        .I1(g11_b35_n_0),
        .O(\spo[35]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0 
       (.I0(\spo[36]_INST_0_i_1_n_0 ),
        .I1(\spo[36]_INST_0_i_2_n_0 ),
        .O(\^spo [36]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[36]_INST_0_i_1 
       (.I0(\spo[36]_INST_0_i_3_n_0 ),
        .I1(\spo[36]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[36]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[36]_INST_0_i_6_n_0 ),
        .O(\spo[36]_INST_0_i_1_n_0 ));
  MUXF7 \spo[36]_INST_0_i_10 
       (.I0(g8_b36_n_0),
        .I1(g9_b36_n_0),
        .O(\spo[36]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[36]_INST_0_i_2 
       (.I0(\spo[36]_INST_0_i_7_n_0 ),
        .I1(\spo[36]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[36]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[36]_INST_0_i_10_n_0 ),
        .O(\spo[36]_INST_0_i_2_n_0 ));
  MUXF7 \spo[36]_INST_0_i_3 
       (.I0(g6_b36_n_0),
        .I1(g7_b36_n_0),
        .O(\spo[36]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0_i_4 
       (.I0(g4_b36_n_0),
        .I1(g5_b36_n_0),
        .O(\spo[36]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0_i_5 
       (.I0(g2_b36_n_0),
        .I1(g3_b36_n_0),
        .O(\spo[36]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0_i_6 
       (.I0(g0_b36_n_0),
        .I1(g1_b36_n_0),
        .O(\spo[36]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0_i_7 
       (.I0(g14_b36_n_0),
        .I1(g15_b36_n_0),
        .O(\spo[36]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0_i_8 
       (.I0(g12_b36_n_0),
        .I1(g13_b36_n_0),
        .O(\spo[36]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[36]_INST_0_i_9 
       (.I0(g10_b36_n_0),
        .I1(g11_b36_n_0),
        .O(\spo[36]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0 
       (.I0(\spo[37]_INST_0_i_1_n_0 ),
        .I1(\spo[37]_INST_0_i_2_n_0 ),
        .O(\^spo [37]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[37]_INST_0_i_1 
       (.I0(\spo[37]_INST_0_i_3_n_0 ),
        .I1(\spo[37]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[37]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[37]_INST_0_i_6_n_0 ),
        .O(\spo[37]_INST_0_i_1_n_0 ));
  MUXF7 \spo[37]_INST_0_i_10 
       (.I0(g8_b37_n_0),
        .I1(g9_b37_n_0),
        .O(\spo[37]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[37]_INST_0_i_2 
       (.I0(\spo[37]_INST_0_i_7_n_0 ),
        .I1(\spo[37]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[37]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[37]_INST_0_i_10_n_0 ),
        .O(\spo[37]_INST_0_i_2_n_0 ));
  MUXF7 \spo[37]_INST_0_i_3 
       (.I0(g6_b37_n_0),
        .I1(g7_b37_n_0),
        .O(\spo[37]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0_i_4 
       (.I0(g4_b37_n_0),
        .I1(g5_b37_n_0),
        .O(\spo[37]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0_i_5 
       (.I0(g2_b37_n_0),
        .I1(g3_b37_n_0),
        .O(\spo[37]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0_i_6 
       (.I0(g0_b37_n_0),
        .I1(g1_b37_n_0),
        .O(\spo[37]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0_i_7 
       (.I0(g14_b37_n_0),
        .I1(g15_b37_n_0),
        .O(\spo[37]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0_i_8 
       (.I0(g12_b37_n_0),
        .I1(g13_b37_n_0),
        .O(\spo[37]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[37]_INST_0_i_9 
       (.I0(g10_b37_n_0),
        .I1(g11_b37_n_0),
        .O(\spo[37]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0 
       (.I0(\spo[38]_INST_0_i_1_n_0 ),
        .I1(\spo[38]_INST_0_i_2_n_0 ),
        .O(\^spo [38]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[38]_INST_0_i_1 
       (.I0(\spo[38]_INST_0_i_3_n_0 ),
        .I1(\spo[38]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[38]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[38]_INST_0_i_6_n_0 ),
        .O(\spo[38]_INST_0_i_1_n_0 ));
  MUXF7 \spo[38]_INST_0_i_10 
       (.I0(g8_b38_n_0),
        .I1(g9_b38_n_0),
        .O(\spo[38]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[38]_INST_0_i_2 
       (.I0(\spo[38]_INST_0_i_7_n_0 ),
        .I1(\spo[38]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[38]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[38]_INST_0_i_10_n_0 ),
        .O(\spo[38]_INST_0_i_2_n_0 ));
  MUXF7 \spo[38]_INST_0_i_3 
       (.I0(g6_b38_n_0),
        .I1(g7_b38_n_0),
        .O(\spo[38]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0_i_4 
       (.I0(g4_b38_n_0),
        .I1(g5_b38_n_0),
        .O(\spo[38]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0_i_5 
       (.I0(g2_b38_n_0),
        .I1(g3_b38_n_0),
        .O(\spo[38]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0_i_6 
       (.I0(g0_b38_n_0),
        .I1(g1_b38_n_0),
        .O(\spo[38]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0_i_7 
       (.I0(g14_b38_n_0),
        .I1(g15_b38_n_0),
        .O(\spo[38]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0_i_8 
       (.I0(g12_b38_n_0),
        .I1(g13_b38_n_0),
        .O(\spo[38]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[38]_INST_0_i_9 
       (.I0(g10_b38_n_0),
        .I1(g11_b38_n_0),
        .O(\spo[38]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0 
       (.I0(\spo[39]_INST_0_i_1_n_0 ),
        .I1(\spo[39]_INST_0_i_2_n_0 ),
        .O(\^spo [39]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[39]_INST_0_i_1 
       (.I0(\spo[39]_INST_0_i_3_n_0 ),
        .I1(\spo[39]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[39]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[39]_INST_0_i_6_n_0 ),
        .O(\spo[39]_INST_0_i_1_n_0 ));
  MUXF7 \spo[39]_INST_0_i_10 
       (.I0(g8_b39_n_0),
        .I1(g9_b39_n_0),
        .O(\spo[39]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[39]_INST_0_i_2 
       (.I0(\spo[39]_INST_0_i_7_n_0 ),
        .I1(\spo[39]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[39]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[39]_INST_0_i_10_n_0 ),
        .O(\spo[39]_INST_0_i_2_n_0 ));
  MUXF7 \spo[39]_INST_0_i_3 
       (.I0(g6_b39_n_0),
        .I1(g7_b39_n_0),
        .O(\spo[39]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0_i_4 
       (.I0(g4_b39_n_0),
        .I1(g5_b39_n_0),
        .O(\spo[39]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0_i_5 
       (.I0(g2_b39_n_0),
        .I1(g3_b39_n_0),
        .O(\spo[39]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0_i_6 
       (.I0(g0_b39_n_0),
        .I1(g1_b39_n_0),
        .O(\spo[39]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0_i_7 
       (.I0(g14_b39_n_0),
        .I1(g15_b39_n_0),
        .O(\spo[39]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0_i_8 
       (.I0(g12_b39_n_0),
        .I1(g13_b39_n_0),
        .O(\spo[39]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[39]_INST_0_i_9 
       (.I0(g10_b39_n_0),
        .I1(g11_b39_n_0),
        .O(\spo[39]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0 
       (.I0(\spo[3]_INST_0_i_1_n_0 ),
        .I1(\spo[3]_INST_0_i_2_n_0 ),
        .O(\^spo [3]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[3]_INST_0_i_1 
       (.I0(\spo[3]_INST_0_i_3_n_0 ),
        .I1(\spo[3]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[3]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[3]_INST_0_i_6_n_0 ),
        .O(\spo[3]_INST_0_i_1_n_0 ));
  MUXF7 \spo[3]_INST_0_i_10 
       (.I0(g8_b3_n_0),
        .I1(g9_b3_n_0),
        .O(\spo[3]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[3]_INST_0_i_2 
       (.I0(\spo[3]_INST_0_i_7_n_0 ),
        .I1(\spo[3]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[3]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[3]_INST_0_i_10_n_0 ),
        .O(\spo[3]_INST_0_i_2_n_0 ));
  MUXF7 \spo[3]_INST_0_i_3 
       (.I0(g6_b3_n_0),
        .I1(g7_b3_n_0),
        .O(\spo[3]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0_i_4 
       (.I0(g4_b3_n_0),
        .I1(g5_b3_n_0),
        .O(\spo[3]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0_i_5 
       (.I0(g2_b3_n_0),
        .I1(g3_b3_n_0),
        .O(\spo[3]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0_i_6 
       (.I0(g0_b3_n_0),
        .I1(g1_b3_n_0),
        .O(\spo[3]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0_i_7 
       (.I0(g14_b3_n_0),
        .I1(g15_b3_n_0),
        .O(\spo[3]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0_i_8 
       (.I0(g12_b3_n_0),
        .I1(g13_b3_n_0),
        .O(\spo[3]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[3]_INST_0_i_9 
       (.I0(g10_b3_n_0),
        .I1(g11_b3_n_0),
        .O(\spo[3]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0 
       (.I0(\spo[40]_INST_0_i_1_n_0 ),
        .I1(\spo[40]_INST_0_i_2_n_0 ),
        .O(\^spo [40]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[40]_INST_0_i_1 
       (.I0(\spo[40]_INST_0_i_3_n_0 ),
        .I1(\spo[40]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[40]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[40]_INST_0_i_6_n_0 ),
        .O(\spo[40]_INST_0_i_1_n_0 ));
  MUXF7 \spo[40]_INST_0_i_10 
       (.I0(g8_b40_n_0),
        .I1(g9_b40_n_0),
        .O(\spo[40]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[40]_INST_0_i_2 
       (.I0(\spo[40]_INST_0_i_7_n_0 ),
        .I1(\spo[40]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[40]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[40]_INST_0_i_10_n_0 ),
        .O(\spo[40]_INST_0_i_2_n_0 ));
  MUXF7 \spo[40]_INST_0_i_3 
       (.I0(g6_b40_n_0),
        .I1(g7_b40_n_0),
        .O(\spo[40]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0_i_4 
       (.I0(g4_b40_n_0),
        .I1(g5_b40_n_0),
        .O(\spo[40]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0_i_5 
       (.I0(g2_b40_n_0),
        .I1(g3_b40_n_0),
        .O(\spo[40]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0_i_6 
       (.I0(g0_b40_n_0),
        .I1(g1_b40_n_0),
        .O(\spo[40]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0_i_7 
       (.I0(g14_b40_n_0),
        .I1(g15_b40_n_0),
        .O(\spo[40]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0_i_8 
       (.I0(g12_b40_n_0),
        .I1(g13_b40_n_0),
        .O(\spo[40]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[40]_INST_0_i_9 
       (.I0(g10_b40_n_0),
        .I1(g11_b40_n_0),
        .O(\spo[40]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0 
       (.I0(\spo[41]_INST_0_i_1_n_0 ),
        .I1(\spo[41]_INST_0_i_2_n_0 ),
        .O(\^spo [41]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[41]_INST_0_i_1 
       (.I0(\spo[41]_INST_0_i_3_n_0 ),
        .I1(\spo[41]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[41]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[41]_INST_0_i_6_n_0 ),
        .O(\spo[41]_INST_0_i_1_n_0 ));
  MUXF7 \spo[41]_INST_0_i_10 
       (.I0(g8_b41_n_0),
        .I1(g9_b41_n_0),
        .O(\spo[41]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[41]_INST_0_i_2 
       (.I0(\spo[41]_INST_0_i_7_n_0 ),
        .I1(\spo[41]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[41]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[41]_INST_0_i_10_n_0 ),
        .O(\spo[41]_INST_0_i_2_n_0 ));
  MUXF7 \spo[41]_INST_0_i_3 
       (.I0(g6_b41_n_0),
        .I1(g7_b41_n_0),
        .O(\spo[41]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0_i_4 
       (.I0(g4_b41_n_0),
        .I1(g5_b41_n_0),
        .O(\spo[41]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0_i_5 
       (.I0(g2_b41_n_0),
        .I1(g3_b41_n_0),
        .O(\spo[41]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0_i_6 
       (.I0(g0_b41_n_0),
        .I1(g1_b41_n_0),
        .O(\spo[41]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0_i_7 
       (.I0(g14_b41_n_0),
        .I1(g15_b41_n_0),
        .O(\spo[41]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0_i_8 
       (.I0(g12_b41_n_0),
        .I1(g13_b41_n_0),
        .O(\spo[41]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[41]_INST_0_i_9 
       (.I0(g10_b41_n_0),
        .I1(g11_b41_n_0),
        .O(\spo[41]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0 
       (.I0(\spo[42]_INST_0_i_1_n_0 ),
        .I1(\spo[42]_INST_0_i_2_n_0 ),
        .O(\^spo [42]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[42]_INST_0_i_1 
       (.I0(\spo[42]_INST_0_i_3_n_0 ),
        .I1(\spo[42]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[42]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[42]_INST_0_i_6_n_0 ),
        .O(\spo[42]_INST_0_i_1_n_0 ));
  MUXF7 \spo[42]_INST_0_i_10 
       (.I0(g8_b42_n_0),
        .I1(g9_b42_n_0),
        .O(\spo[42]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[42]_INST_0_i_2 
       (.I0(\spo[42]_INST_0_i_7_n_0 ),
        .I1(\spo[42]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[42]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[42]_INST_0_i_10_n_0 ),
        .O(\spo[42]_INST_0_i_2_n_0 ));
  MUXF7 \spo[42]_INST_0_i_3 
       (.I0(g6_b42_n_0),
        .I1(g7_b42_n_0),
        .O(\spo[42]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0_i_4 
       (.I0(g4_b42_n_0),
        .I1(g5_b42_n_0),
        .O(\spo[42]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0_i_5 
       (.I0(g2_b42_n_0),
        .I1(g3_b42_n_0),
        .O(\spo[42]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0_i_6 
       (.I0(g0_b42_n_0),
        .I1(g1_b42_n_0),
        .O(\spo[42]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0_i_7 
       (.I0(g14_b42_n_0),
        .I1(g15_b42_n_0),
        .O(\spo[42]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0_i_8 
       (.I0(g12_b42_n_0),
        .I1(g13_b42_n_0),
        .O(\spo[42]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[42]_INST_0_i_9 
       (.I0(g10_b42_n_0),
        .I1(g11_b42_n_0),
        .O(\spo[42]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0 
       (.I0(\spo[43]_INST_0_i_1_n_0 ),
        .I1(\spo[43]_INST_0_i_2_n_0 ),
        .O(\^spo [43]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[43]_INST_0_i_1 
       (.I0(\spo[43]_INST_0_i_3_n_0 ),
        .I1(\spo[43]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[43]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[43]_INST_0_i_6_n_0 ),
        .O(\spo[43]_INST_0_i_1_n_0 ));
  MUXF7 \spo[43]_INST_0_i_10 
       (.I0(g8_b43_n_0),
        .I1(g9_b43_n_0),
        .O(\spo[43]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[43]_INST_0_i_2 
       (.I0(\spo[43]_INST_0_i_7_n_0 ),
        .I1(\spo[43]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[43]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[43]_INST_0_i_10_n_0 ),
        .O(\spo[43]_INST_0_i_2_n_0 ));
  MUXF7 \spo[43]_INST_0_i_3 
       (.I0(g6_b43_n_0),
        .I1(g7_b43_n_0),
        .O(\spo[43]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0_i_4 
       (.I0(g4_b43_n_0),
        .I1(g5_b43_n_0),
        .O(\spo[43]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0_i_5 
       (.I0(g2_b43_n_0),
        .I1(g3_b43_n_0),
        .O(\spo[43]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0_i_6 
       (.I0(g0_b43_n_0),
        .I1(g1_b43_n_0),
        .O(\spo[43]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0_i_7 
       (.I0(g14_b43_n_0),
        .I1(g15_b43_n_0),
        .O(\spo[43]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0_i_8 
       (.I0(g12_b43_n_0),
        .I1(g13_b43_n_0),
        .O(\spo[43]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[43]_INST_0_i_9 
       (.I0(g10_b43_n_0),
        .I1(g11_b43_n_0),
        .O(\spo[43]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0 
       (.I0(\spo[44]_INST_0_i_1_n_0 ),
        .I1(\spo[44]_INST_0_i_2_n_0 ),
        .O(\^spo [44]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[44]_INST_0_i_1 
       (.I0(\spo[44]_INST_0_i_3_n_0 ),
        .I1(\spo[44]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[44]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[44]_INST_0_i_6_n_0 ),
        .O(\spo[44]_INST_0_i_1_n_0 ));
  MUXF7 \spo[44]_INST_0_i_10 
       (.I0(g8_b44_n_0),
        .I1(g9_b44_n_0),
        .O(\spo[44]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[44]_INST_0_i_2 
       (.I0(\spo[44]_INST_0_i_7_n_0 ),
        .I1(\spo[44]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[44]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[44]_INST_0_i_10_n_0 ),
        .O(\spo[44]_INST_0_i_2_n_0 ));
  MUXF7 \spo[44]_INST_0_i_3 
       (.I0(g6_b44_n_0),
        .I1(g7_b44_n_0),
        .O(\spo[44]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0_i_4 
       (.I0(g4_b44_n_0),
        .I1(g5_b44_n_0),
        .O(\spo[44]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0_i_5 
       (.I0(g2_b44_n_0),
        .I1(g3_b44_n_0),
        .O(\spo[44]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0_i_6 
       (.I0(g0_b44_n_0),
        .I1(g1_b44_n_0),
        .O(\spo[44]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0_i_7 
       (.I0(g14_b44_n_0),
        .I1(g15_b44_n_0),
        .O(\spo[44]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0_i_8 
       (.I0(g12_b44_n_0),
        .I1(g13_b44_n_0),
        .O(\spo[44]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[44]_INST_0_i_9 
       (.I0(g10_b44_n_0),
        .I1(g11_b44_n_0),
        .O(\spo[44]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0 
       (.I0(\spo[45]_INST_0_i_1_n_0 ),
        .I1(\spo[45]_INST_0_i_2_n_0 ),
        .O(\^spo [45]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[45]_INST_0_i_1 
       (.I0(\spo[45]_INST_0_i_3_n_0 ),
        .I1(\spo[45]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[45]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[45]_INST_0_i_6_n_0 ),
        .O(\spo[45]_INST_0_i_1_n_0 ));
  MUXF7 \spo[45]_INST_0_i_10 
       (.I0(g8_b45_n_0),
        .I1(g9_b45_n_0),
        .O(\spo[45]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[45]_INST_0_i_2 
       (.I0(\spo[45]_INST_0_i_7_n_0 ),
        .I1(\spo[45]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[45]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[45]_INST_0_i_10_n_0 ),
        .O(\spo[45]_INST_0_i_2_n_0 ));
  MUXF7 \spo[45]_INST_0_i_3 
       (.I0(g6_b45_n_0),
        .I1(g7_b45_n_0),
        .O(\spo[45]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0_i_4 
       (.I0(g4_b45_n_0),
        .I1(g5_b45_n_0),
        .O(\spo[45]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0_i_5 
       (.I0(g2_b45_n_0),
        .I1(g3_b45_n_0),
        .O(\spo[45]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0_i_6 
       (.I0(g0_b45_n_0),
        .I1(g1_b45_n_0),
        .O(\spo[45]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0_i_7 
       (.I0(g14_b45_n_0),
        .I1(g15_b45_n_0),
        .O(\spo[45]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0_i_8 
       (.I0(g12_b45_n_0),
        .I1(g13_b45_n_0),
        .O(\spo[45]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[45]_INST_0_i_9 
       (.I0(g10_b45_n_0),
        .I1(g11_b45_n_0),
        .O(\spo[45]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF8 \spo[46]_INST_0 
       (.I0(\spo[46]_INST_0_i_1_n_0 ),
        .I1(\spo[46]_INST_0_i_2_n_0 ),
        .O(\^spo [46]),
        .S(a[9]));
  MUXF7 \spo[46]_INST_0_i_1 
       (.I0(\spo[46]_INST_0_i_3_n_0 ),
        .I1(\spo[46]_INST_0_i_4_n_0 ),
        .O(\spo[46]_INST_0_i_1_n_0 ),
        .S(a[8]));
  MUXF7 \spo[46]_INST_0_i_2 
       (.I0(\spo[46]_INST_0_i_5_n_0 ),
        .I1(\spo[46]_INST_0_i_6_n_0 ),
        .O(\spo[46]_INST_0_i_2_n_0 ),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[46]_INST_0_i_3 
       (.I0(g3_b46_n_0),
        .I1(g2_b46_n_0),
        .I2(a[7]),
        .I3(g1_b46_n_0),
        .I4(a[6]),
        .I5(g0_b46_n_0),
        .O(\spo[46]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[46]_INST_0_i_4 
       (.I0(g3_b60_n_0),
        .I1(g6_b46_n_0),
        .I2(a[7]),
        .I3(g5_b46_n_0),
        .I4(a[6]),
        .I5(g4_b46_n_0),
        .O(\spo[46]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[46]_INST_0_i_5 
       (.I0(g8_b47_n_0),
        .I1(g10_b46_n_0),
        .I2(a[7]),
        .I3(g9_b46_n_0),
        .I4(a[6]),
        .I5(g8_b46_n_0),
        .O(\spo[46]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[46]_INST_0_i_6 
       (.I0(g15_b47_n_0),
        .I1(g14_b46_n_0),
        .I2(a[7]),
        .I3(g13_b46_n_0),
        .I4(a[6]),
        .I5(g4_b62_n_0),
        .O(\spo[46]_INST_0_i_6_n_0 ));
  MUXF8 \spo[47]_INST_0 
       (.I0(\spo[47]_INST_0_i_1_n_0 ),
        .I1(\spo[47]_INST_0_i_2_n_0 ),
        .O(\^spo [47]),
        .S(a[9]));
  MUXF7 \spo[47]_INST_0_i_1 
       (.I0(\spo[47]_INST_0_i_3_n_0 ),
        .I1(\spo[47]_INST_0_i_4_n_0 ),
        .O(\spo[47]_INST_0_i_1_n_0 ),
        .S(a[8]));
  MUXF7 \spo[47]_INST_0_i_2 
       (.I0(\spo[47]_INST_0_i_5_n_0 ),
        .I1(\spo[47]_INST_0_i_6_n_0 ),
        .O(\spo[47]_INST_0_i_2_n_0 ),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[47]_INST_0_i_3 
       (.I0(g3_b63_n_0),
        .I1(g2_b47_n_0),
        .I2(a[7]),
        .I3(g1_b47_n_0),
        .I4(a[6]),
        .I5(g10_b60_n_0),
        .O(\spo[47]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[47]_INST_0_i_4 
       (.I0(g6_b47_n_0),
        .I1(a[7]),
        .I2(g2_b62_n_0),
        .I3(a[6]),
        .I4(g4_b47_n_0),
        .O(\spo[47]_INST_0_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[47]_INST_0_i_5 
       (.I0(g10_b47_n_0),
        .I1(a[7]),
        .I2(g4_b62_n_0),
        .I3(a[6]),
        .I4(g8_b47_n_0),
        .O(\spo[47]_INST_0_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hB833B800)) 
    \spo[47]_INST_0_i_6 
       (.I0(g15_b47_n_0),
        .I1(a[7]),
        .I2(g13_b47_n_0),
        .I3(a[6]),
        .I4(g4_b62_n_0),
        .O(\spo[47]_INST_0_i_6_n_0 ));
  MUXF7 \spo[48]_INST_0 
       (.I0(\spo[48]_INST_0_i_1_n_0 ),
        .I1(\spo[48]_INST_0_i_2_n_0 ),
        .O(\^spo [48]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'h30BB308800FF00FF)) 
    \spo[48]_INST_0_i_1 
       (.I0(g5_b48_n_0),
        .I1(a[8]),
        .I2(g3_b63_n_0),
        .I3(a[7]),
        .I4(g1_b48_n_0),
        .I5(a[6]),
        .O(\spo[48]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hA0F0A0F0FFCFF0CF)) 
    \spo[48]_INST_0_i_2 
       (.I0(g7_b58_n_0),
        .I1(g4_b62_n_0),
        .I2(a[8]),
        .I3(a[6]),
        .I4(g9_b48_n_0),
        .I5(a[7]),
        .O(\spo[48]_INST_0_i_2_n_0 ));
  MUXF7 \spo[4]_INST_0 
       (.I0(\spo[4]_INST_0_i_1_n_0 ),
        .I1(\spo[4]_INST_0_i_2_n_0 ),
        .O(\^spo [4]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[4]_INST_0_i_1 
       (.I0(\spo[4]_INST_0_i_3_n_0 ),
        .I1(\spo[4]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[4]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[4]_INST_0_i_6_n_0 ),
        .O(\spo[4]_INST_0_i_1_n_0 ));
  MUXF7 \spo[4]_INST_0_i_10 
       (.I0(g8_b4_n_0),
        .I1(g9_b4_n_0),
        .O(\spo[4]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[4]_INST_0_i_2 
       (.I0(\spo[4]_INST_0_i_7_n_0 ),
        .I1(\spo[4]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[4]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[4]_INST_0_i_10_n_0 ),
        .O(\spo[4]_INST_0_i_2_n_0 ));
  MUXF7 \spo[4]_INST_0_i_3 
       (.I0(g6_b4_n_0),
        .I1(g7_b4_n_0),
        .O(\spo[4]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_4 
       (.I0(g4_b4_n_0),
        .I1(g5_b4_n_0),
        .O(\spo[4]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_5 
       (.I0(g2_b4_n_0),
        .I1(g3_b4_n_0),
        .O(\spo[4]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_6 
       (.I0(g0_b4_n_0),
        .I1(g1_b4_n_0),
        .O(\spo[4]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_7 
       (.I0(g14_b4_n_0),
        .I1(g15_b4_n_0),
        .O(\spo[4]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_8 
       (.I0(g12_b4_n_0),
        .I1(g13_b4_n_0),
        .O(\spo[4]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[4]_INST_0_i_9 
       (.I0(g10_b4_n_0),
        .I1(g11_b4_n_0),
        .O(\spo[4]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0 
       (.I0(\spo[50]_INST_0_i_1_n_0 ),
        .I1(\spo[50]_INST_0_i_2_n_0 ),
        .O(\^spo [50]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[50]_INST_0_i_1 
       (.I0(\spo[50]_INST_0_i_3_n_0 ),
        .I1(\spo[50]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[50]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[50]_INST_0_i_6_n_0 ),
        .O(\spo[50]_INST_0_i_1_n_0 ));
  MUXF7 \spo[50]_INST_0_i_10 
       (.I0(g8_b50_n_0),
        .I1(g9_b50_n_0),
        .O(\spo[50]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[50]_INST_0_i_2 
       (.I0(\spo[50]_INST_0_i_7_n_0 ),
        .I1(\spo[50]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[50]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[50]_INST_0_i_10_n_0 ),
        .O(\spo[50]_INST_0_i_2_n_0 ));
  MUXF7 \spo[50]_INST_0_i_3 
       (.I0(g6_b50_n_0),
        .I1(g7_b50_n_0),
        .O(\spo[50]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0_i_4 
       (.I0(g4_b50_n_0),
        .I1(g5_b50_n_0),
        .O(\spo[50]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0_i_5 
       (.I0(g2_b50_n_0),
        .I1(g3_b50_n_0),
        .O(\spo[50]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0_i_6 
       (.I0(g0_b50_n_0),
        .I1(g1_b50_n_0),
        .O(\spo[50]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0_i_7 
       (.I0(g14_b50_n_0),
        .I1(g15_b50_n_0),
        .O(\spo[50]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0_i_8 
       (.I0(g12_b50_n_0),
        .I1(g13_b50_n_0),
        .O(\spo[50]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[50]_INST_0_i_9 
       (.I0(g10_b50_n_0),
        .I1(g11_b50_n_0),
        .O(\spo[50]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0 
       (.I0(\spo[51]_INST_0_i_1_n_0 ),
        .I1(\spo[51]_INST_0_i_2_n_0 ),
        .O(\^spo [51]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[51]_INST_0_i_1 
       (.I0(\spo[51]_INST_0_i_3_n_0 ),
        .I1(\spo[51]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[51]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[51]_INST_0_i_6_n_0 ),
        .O(\spo[51]_INST_0_i_1_n_0 ));
  MUXF7 \spo[51]_INST_0_i_10 
       (.I0(g8_b51_n_0),
        .I1(g9_b51_n_0),
        .O(\spo[51]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[51]_INST_0_i_2 
       (.I0(\spo[51]_INST_0_i_7_n_0 ),
        .I1(\spo[51]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[51]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[51]_INST_0_i_10_n_0 ),
        .O(\spo[51]_INST_0_i_2_n_0 ));
  MUXF7 \spo[51]_INST_0_i_3 
       (.I0(g6_b51_n_0),
        .I1(g7_b51_n_0),
        .O(\spo[51]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0_i_4 
       (.I0(g4_b51_n_0),
        .I1(g5_b51_n_0),
        .O(\spo[51]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0_i_5 
       (.I0(g2_b51_n_0),
        .I1(g3_b51_n_0),
        .O(\spo[51]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0_i_6 
       (.I0(g0_b51_n_0),
        .I1(g1_b51_n_0),
        .O(\spo[51]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0_i_7 
       (.I0(g14_b51_n_0),
        .I1(g15_b51_n_0),
        .O(\spo[51]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0_i_8 
       (.I0(g12_b51_n_0),
        .I1(g13_b51_n_0),
        .O(\spo[51]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[51]_INST_0_i_9 
       (.I0(g10_b51_n_0),
        .I1(g11_b51_n_0),
        .O(\spo[51]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0 
       (.I0(\spo[52]_INST_0_i_1_n_0 ),
        .I1(\spo[52]_INST_0_i_2_n_0 ),
        .O(\^spo [52]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[52]_INST_0_i_1 
       (.I0(\spo[52]_INST_0_i_3_n_0 ),
        .I1(\spo[52]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[52]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[52]_INST_0_i_6_n_0 ),
        .O(\spo[52]_INST_0_i_1_n_0 ));
  MUXF7 \spo[52]_INST_0_i_10 
       (.I0(g8_b52_n_0),
        .I1(g9_b52_n_0),
        .O(\spo[52]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[52]_INST_0_i_2 
       (.I0(\spo[52]_INST_0_i_7_n_0 ),
        .I1(\spo[52]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[52]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[52]_INST_0_i_10_n_0 ),
        .O(\spo[52]_INST_0_i_2_n_0 ));
  MUXF7 \spo[52]_INST_0_i_3 
       (.I0(g6_b52_n_0),
        .I1(g7_b52_n_0),
        .O(\spo[52]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0_i_4 
       (.I0(g4_b52_n_0),
        .I1(g5_b52_n_0),
        .O(\spo[52]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0_i_5 
       (.I0(g2_b52_n_0),
        .I1(g3_b52_n_0),
        .O(\spo[52]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0_i_6 
       (.I0(g0_b52_n_0),
        .I1(g1_b52_n_0),
        .O(\spo[52]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0_i_7 
       (.I0(g14_b52_n_0),
        .I1(g15_b52_n_0),
        .O(\spo[52]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0_i_8 
       (.I0(g12_b52_n_0),
        .I1(g13_b52_n_0),
        .O(\spo[52]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[52]_INST_0_i_9 
       (.I0(g10_b52_n_0),
        .I1(g11_b52_n_0),
        .O(\spo[52]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0 
       (.I0(\spo[53]_INST_0_i_1_n_0 ),
        .I1(\spo[53]_INST_0_i_2_n_0 ),
        .O(\^spo [53]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[53]_INST_0_i_1 
       (.I0(\spo[53]_INST_0_i_3_n_0 ),
        .I1(\spo[53]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[53]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[53]_INST_0_i_6_n_0 ),
        .O(\spo[53]_INST_0_i_1_n_0 ));
  MUXF7 \spo[53]_INST_0_i_10 
       (.I0(g8_b53_n_0),
        .I1(g9_b53_n_0),
        .O(\spo[53]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[53]_INST_0_i_2 
       (.I0(\spo[53]_INST_0_i_7_n_0 ),
        .I1(\spo[53]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[53]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[53]_INST_0_i_10_n_0 ),
        .O(\spo[53]_INST_0_i_2_n_0 ));
  MUXF7 \spo[53]_INST_0_i_3 
       (.I0(g6_b53_n_0),
        .I1(g7_b53_n_0),
        .O(\spo[53]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0_i_4 
       (.I0(g4_b53_n_0),
        .I1(g5_b53_n_0),
        .O(\spo[53]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0_i_5 
       (.I0(g2_b53_n_0),
        .I1(g3_b53_n_0),
        .O(\spo[53]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0_i_6 
       (.I0(g0_b53_n_0),
        .I1(g1_b53_n_0),
        .O(\spo[53]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0_i_7 
       (.I0(g14_b53_n_0),
        .I1(g15_b53_n_0),
        .O(\spo[53]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0_i_8 
       (.I0(g12_b53_n_0),
        .I1(g13_b53_n_0),
        .O(\spo[53]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[53]_INST_0_i_9 
       (.I0(g10_b53_n_0),
        .I1(g11_b53_n_0),
        .O(\spo[53]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0 
       (.I0(\spo[54]_INST_0_i_1_n_0 ),
        .I1(\spo[54]_INST_0_i_2_n_0 ),
        .O(\^spo [54]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[54]_INST_0_i_1 
       (.I0(\spo[54]_INST_0_i_3_n_0 ),
        .I1(\spo[54]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[54]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[54]_INST_0_i_6_n_0 ),
        .O(\spo[54]_INST_0_i_1_n_0 ));
  MUXF7 \spo[54]_INST_0_i_10 
       (.I0(g8_b54_n_0),
        .I1(g9_b54_n_0),
        .O(\spo[54]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[54]_INST_0_i_2 
       (.I0(\spo[54]_INST_0_i_7_n_0 ),
        .I1(\spo[54]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[54]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[54]_INST_0_i_10_n_0 ),
        .O(\spo[54]_INST_0_i_2_n_0 ));
  MUXF7 \spo[54]_INST_0_i_3 
       (.I0(g6_b54_n_0),
        .I1(g7_b54_n_0),
        .O(\spo[54]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0_i_4 
       (.I0(g4_b54_n_0),
        .I1(g5_b54_n_0),
        .O(\spo[54]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0_i_5 
       (.I0(g2_b54_n_0),
        .I1(g3_b54_n_0),
        .O(\spo[54]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0_i_6 
       (.I0(g0_b54_n_0),
        .I1(g1_b54_n_0),
        .O(\spo[54]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0_i_7 
       (.I0(g14_b54_n_0),
        .I1(g15_b54_n_0),
        .O(\spo[54]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0_i_8 
       (.I0(g12_b54_n_0),
        .I1(g13_b54_n_0),
        .O(\spo[54]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[54]_INST_0_i_9 
       (.I0(g10_b54_n_0),
        .I1(g11_b54_n_0),
        .O(\spo[54]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0 
       (.I0(\spo[55]_INST_0_i_1_n_0 ),
        .I1(\spo[55]_INST_0_i_2_n_0 ),
        .O(\^spo [55]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[55]_INST_0_i_1 
       (.I0(\spo[55]_INST_0_i_3_n_0 ),
        .I1(\spo[55]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[55]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[55]_INST_0_i_6_n_0 ),
        .O(\spo[55]_INST_0_i_1_n_0 ));
  MUXF7 \spo[55]_INST_0_i_10 
       (.I0(g8_b55_n_0),
        .I1(g9_b55_n_0),
        .O(\spo[55]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[55]_INST_0_i_2 
       (.I0(\spo[55]_INST_0_i_7_n_0 ),
        .I1(\spo[55]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[55]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[55]_INST_0_i_10_n_0 ),
        .O(\spo[55]_INST_0_i_2_n_0 ));
  MUXF7 \spo[55]_INST_0_i_3 
       (.I0(g6_b55_n_0),
        .I1(g7_b55_n_0),
        .O(\spo[55]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0_i_4 
       (.I0(g4_b55_n_0),
        .I1(g5_b55_n_0),
        .O(\spo[55]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0_i_5 
       (.I0(g2_b55_n_0),
        .I1(g3_b55_n_0),
        .O(\spo[55]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0_i_6 
       (.I0(g0_b55_n_0),
        .I1(g1_b55_n_0),
        .O(\spo[55]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0_i_7 
       (.I0(g14_b55_n_0),
        .I1(g15_b55_n_0),
        .O(\spo[55]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0_i_8 
       (.I0(g12_b55_n_0),
        .I1(g13_b55_n_0),
        .O(\spo[55]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[55]_INST_0_i_9 
       (.I0(g10_b55_n_0),
        .I1(g11_b55_n_0),
        .O(\spo[55]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0 
       (.I0(\spo[56]_INST_0_i_1_n_0 ),
        .I1(\spo[56]_INST_0_i_2_n_0 ),
        .O(\^spo [56]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[56]_INST_0_i_1 
       (.I0(\spo[56]_INST_0_i_3_n_0 ),
        .I1(\spo[56]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[56]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[56]_INST_0_i_6_n_0 ),
        .O(\spo[56]_INST_0_i_1_n_0 ));
  MUXF7 \spo[56]_INST_0_i_10 
       (.I0(g8_b56_n_0),
        .I1(g9_b56_n_0),
        .O(\spo[56]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[56]_INST_0_i_2 
       (.I0(\spo[56]_INST_0_i_7_n_0 ),
        .I1(\spo[56]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[56]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[56]_INST_0_i_10_n_0 ),
        .O(\spo[56]_INST_0_i_2_n_0 ));
  MUXF7 \spo[56]_INST_0_i_3 
       (.I0(g6_b56_n_0),
        .I1(g7_b56_n_0),
        .O(\spo[56]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0_i_4 
       (.I0(g4_b56_n_0),
        .I1(g5_b56_n_0),
        .O(\spo[56]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0_i_5 
       (.I0(g2_b56_n_0),
        .I1(g3_b56_n_0),
        .O(\spo[56]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0_i_6 
       (.I0(g0_b56_n_0),
        .I1(g1_b56_n_0),
        .O(\spo[56]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0_i_7 
       (.I0(g14_b56_n_0),
        .I1(g15_b56_n_0),
        .O(\spo[56]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0_i_8 
       (.I0(g12_b56_n_0),
        .I1(g13_b56_n_0),
        .O(\spo[56]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[56]_INST_0_i_9 
       (.I0(g10_b56_n_0),
        .I1(g11_b56_n_0),
        .O(\spo[56]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0 
       (.I0(\spo[57]_INST_0_i_1_n_0 ),
        .I1(\spo[57]_INST_0_i_2_n_0 ),
        .O(\^spo [57]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[57]_INST_0_i_1 
       (.I0(\spo[57]_INST_0_i_3_n_0 ),
        .I1(\spo[57]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[57]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[57]_INST_0_i_6_n_0 ),
        .O(\spo[57]_INST_0_i_1_n_0 ));
  MUXF7 \spo[57]_INST_0_i_10 
       (.I0(g8_b57_n_0),
        .I1(g9_b57_n_0),
        .O(\spo[57]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[57]_INST_0_i_2 
       (.I0(\spo[57]_INST_0_i_7_n_0 ),
        .I1(\spo[57]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[57]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[57]_INST_0_i_10_n_0 ),
        .O(\spo[57]_INST_0_i_2_n_0 ));
  MUXF7 \spo[57]_INST_0_i_3 
       (.I0(g6_b57_n_0),
        .I1(g7_b57_n_0),
        .O(\spo[57]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0_i_4 
       (.I0(g4_b57_n_0),
        .I1(g5_b57_n_0),
        .O(\spo[57]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0_i_5 
       (.I0(g2_b57_n_0),
        .I1(g3_b57_n_0),
        .O(\spo[57]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0_i_6 
       (.I0(g0_b57_n_0),
        .I1(g1_b57_n_0),
        .O(\spo[57]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0_i_7 
       (.I0(g14_b57_n_0),
        .I1(g15_b57_n_0),
        .O(\spo[57]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0_i_8 
       (.I0(g12_b57_n_0),
        .I1(g13_b57_n_0),
        .O(\spo[57]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[57]_INST_0_i_9 
       (.I0(g10_b57_n_0),
        .I1(g11_b57_n_0),
        .O(\spo[57]_INST_0_i_9_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[58]_INST_0 
       (.I0(\spo[58]_INST_0_i_1_n_0 ),
        .I1(\spo[58]_INST_0_i_2_n_0 ),
        .I2(a[9]),
        .I3(\spo[58]_INST_0_i_3_n_0 ),
        .I4(a[8]),
        .I5(\spo[58]_INST_0_i_4_n_0 ),
        .O(\^spo [58]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[58]_INST_0_i_1 
       (.I0(g15_b58_n_0),
        .I1(g14_b58_n_0),
        .I2(a[7]),
        .I3(g13_b58_n_0),
        .I4(a[6]),
        .I5(g12_b58_n_0),
        .O(\spo[58]_INST_0_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[58]_INST_0_i_2 
       (.I0(g11_b58_n_0),
        .I1(g10_b58_n_0),
        .I2(a[7]),
        .I3(g9_b58_n_0),
        .I4(a[6]),
        .I5(g8_b58_n_0),
        .O(\spo[58]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[58]_INST_0_i_3 
       (.I0(g7_b58_n_0),
        .I1(g6_b58_n_0),
        .I2(a[7]),
        .I3(g5_b58_n_0),
        .I4(a[6]),
        .I5(g4_b58_n_0),
        .O(\spo[58]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[58]_INST_0_i_4 
       (.I0(g3_b58_n_0),
        .I1(g2_b58_n_0),
        .I2(a[7]),
        .I3(g1_b58_n_0),
        .I4(a[6]),
        .I5(g0_b58_n_0),
        .O(\spo[58]_INST_0_i_4_n_0 ));
  MUXF8 \spo[59]_INST_0 
       (.I0(\spo[59]_INST_0_i_1_n_0 ),
        .I1(\spo[59]_INST_0_i_2_n_0 ),
        .O(\^spo [59]),
        .S(a[9]));
  MUXF7 \spo[59]_INST_0_i_1 
       (.I0(\spo[59]_INST_0_i_3_n_0 ),
        .I1(\spo[59]_INST_0_i_4_n_0 ),
        .O(\spo[59]_INST_0_i_1_n_0 ),
        .S(a[8]));
  MUXF7 \spo[59]_INST_0_i_2 
       (.I0(\spo[59]_INST_0_i_5_n_0 ),
        .I1(\spo[59]_INST_0_i_6_n_0 ),
        .O(\spo[59]_INST_0_i_2_n_0 ),
        .S(a[8]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[59]_INST_0_i_3 
       (.I0(g3_b59_n_0),
        .I1(g2_b59_n_0),
        .I2(a[7]),
        .I3(g1_b59_n_0),
        .I4(a[6]),
        .I5(g0_b59_n_0),
        .O(\spo[59]_INST_0_i_3_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[59]_INST_0_i_4 
       (.I0(g6_b59_n_0),
        .I1(a[7]),
        .I2(g5_b59_n_0),
        .I3(a[6]),
        .I4(g4_b62_n_0),
        .O(\spo[59]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[59]_INST_0_i_5 
       (.I0(g1_b59_n_0),
        .I1(g10_b59_n_0),
        .I2(a[7]),
        .I3(g9_b59_n_0),
        .I4(a[6]),
        .I5(g8_b59_n_0),
        .O(\spo[59]_INST_0_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h30BB3088)) 
    \spo[59]_INST_0_i_6 
       (.I0(g5_b60_n_0),
        .I1(a[7]),
        .I2(g13_b59_n_0),
        .I3(a[6]),
        .I4(g12_b63_n_0),
        .O(\spo[59]_INST_0_i_6_n_0 ));
  MUXF7 \spo[5]_INST_0 
       (.I0(\spo[5]_INST_0_i_1_n_0 ),
        .I1(\spo[5]_INST_0_i_2_n_0 ),
        .O(\^spo [5]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_1 
       (.I0(\spo[5]_INST_0_i_3_n_0 ),
        .I1(\spo[5]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[5]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_6_n_0 ),
        .O(\spo[5]_INST_0_i_1_n_0 ));
  MUXF7 \spo[5]_INST_0_i_10 
       (.I0(g8_b5_n_0),
        .I1(g9_b5_n_0),
        .O(\spo[5]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[5]_INST_0_i_2 
       (.I0(\spo[5]_INST_0_i_7_n_0 ),
        .I1(\spo[5]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[5]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[5]_INST_0_i_10_n_0 ),
        .O(\spo[5]_INST_0_i_2_n_0 ));
  MUXF7 \spo[5]_INST_0_i_3 
       (.I0(g6_b5_n_0),
        .I1(g7_b5_n_0),
        .O(\spo[5]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_4 
       (.I0(g4_b5_n_0),
        .I1(g5_b5_n_0),
        .O(\spo[5]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_5 
       (.I0(g2_b5_n_0),
        .I1(g3_b5_n_0),
        .O(\spo[5]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_6 
       (.I0(g0_b5_n_0),
        .I1(g1_b5_n_0),
        .O(\spo[5]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_7 
       (.I0(g14_b5_n_0),
        .I1(g15_b5_n_0),
        .O(\spo[5]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_8 
       (.I0(g12_b5_n_0),
        .I1(g13_b5_n_0),
        .O(\spo[5]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[5]_INST_0_i_9 
       (.I0(g10_b5_n_0),
        .I1(g11_b5_n_0),
        .O(\spo[5]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF8 \spo[60]_INST_0 
       (.I0(\spo[60]_INST_0_i_1_n_0 ),
        .I1(\spo[60]_INST_0_i_2_n_0 ),
        .O(\^spo [60]),
        .S(a[9]));
  MUXF7 \spo[60]_INST_0_i_1 
       (.I0(\spo[60]_INST_0_i_3_n_0 ),
        .I1(\spo[60]_INST_0_i_4_n_0 ),
        .O(\spo[60]_INST_0_i_1_n_0 ),
        .S(a[8]));
  MUXF7 \spo[60]_INST_0_i_2 
       (.I0(\spo[60]_INST_0_i_5_n_0 ),
        .I1(\spo[60]_INST_0_i_6_n_0 ),
        .O(\spo[60]_INST_0_i_2_n_0 ),
        .S(a[8]));
  LUT5 #(
    .INIT(32'hA0A0CFC0)) 
    \spo[60]_INST_0_i_3 
       (.I0(g3_b60_n_0),
        .I1(g2_b62_n_0),
        .I2(a[7]),
        .I3(g0_b60_n_0),
        .I4(a[6]),
        .O(\spo[60]_INST_0_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \spo[60]_INST_0_i_4 
       (.I0(g4_b62_n_0),
        .I1(a[6]),
        .I2(g5_b60_n_0),
        .I3(a[7]),
        .O(\spo[60]_INST_0_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h3808)) 
    \spo[60]_INST_0_i_5 
       (.I0(g10_b60_n_0),
        .I1(a[7]),
        .I2(a[6]),
        .I3(g9_b62_n_0),
        .O(\spo[60]_INST_0_i_5_n_0 ));
  LUT4 #(
    .INIT(16'h00E2)) 
    \spo[60]_INST_0_i_6 
       (.I0(g12_b63_n_0),
        .I1(a[6]),
        .I2(g13_b60_n_0),
        .I3(a[7]),
        .O(\spo[60]_INST_0_i_6_n_0 ));
  MUXF7 \spo[62]_INST_0 
       (.I0(\spo[62]_INST_0_i_1_n_0 ),
        .I1(\spo[62]_INST_0_i_2_n_0 ),
        .O(\^spo [62]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hFCFCF8C8CCCCF8C8)) 
    \spo[62]_INST_0_i_1 
       (.I0(g4_b62_n_0),
        .I1(a[8]),
        .I2(a[7]),
        .I3(g2_b62_n_0),
        .I4(a[6]),
        .I5(g3_b62_n_0),
        .O(\spo[62]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFCF8F8)) 
    \spo[62]_INST_0_i_2 
       (.I0(g12_b62_n_0),
        .I1(a[8]),
        .I2(a[7]),
        .I3(g9_b62_n_0),
        .I4(a[6]),
        .O(\spo[62]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hF3F0F0F0F0B0F0B0)) 
    \spo[63]_INST_0 
       (.I0(g12_b63_n_0),
        .I1(a[9]),
        .I2(a[8]),
        .I3(a[6]),
        .I4(g3_b63_n_0),
        .I5(a[7]),
        .O(\^spo [63]));
  MUXF7 \spo[6]_INST_0 
       (.I0(\spo[6]_INST_0_i_1_n_0 ),
        .I1(\spo[6]_INST_0_i_2_n_0 ),
        .O(\^spo [6]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_1 
       (.I0(\spo[6]_INST_0_i_3_n_0 ),
        .I1(\spo[6]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[6]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[6]_INST_0_i_6_n_0 ),
        .O(\spo[6]_INST_0_i_1_n_0 ));
  MUXF7 \spo[6]_INST_0_i_10 
       (.I0(g8_b6_n_0),
        .I1(g9_b6_n_0),
        .O(\spo[6]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[6]_INST_0_i_2 
       (.I0(\spo[6]_INST_0_i_7_n_0 ),
        .I1(\spo[6]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[6]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[6]_INST_0_i_10_n_0 ),
        .O(\spo[6]_INST_0_i_2_n_0 ));
  MUXF7 \spo[6]_INST_0_i_3 
       (.I0(g6_b6_n_0),
        .I1(g7_b6_n_0),
        .O(\spo[6]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_4 
       (.I0(g4_b6_n_0),
        .I1(g5_b6_n_0),
        .O(\spo[6]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_5 
       (.I0(g2_b6_n_0),
        .I1(g3_b6_n_0),
        .O(\spo[6]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_6 
       (.I0(g0_b6_n_0),
        .I1(g1_b6_n_0),
        .O(\spo[6]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_7 
       (.I0(g14_b6_n_0),
        .I1(g15_b6_n_0),
        .O(\spo[6]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_8 
       (.I0(g12_b6_n_0),
        .I1(g13_b6_n_0),
        .O(\spo[6]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[6]_INST_0_i_9 
       (.I0(g10_b6_n_0),
        .I1(g11_b6_n_0),
        .O(\spo[6]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0 
       (.I0(\spo[7]_INST_0_i_1_n_0 ),
        .I1(\spo[7]_INST_0_i_2_n_0 ),
        .O(\^spo [7]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_1 
       (.I0(\spo[7]_INST_0_i_3_n_0 ),
        .I1(\spo[7]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[7]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[7]_INST_0_i_6_n_0 ),
        .O(\spo[7]_INST_0_i_1_n_0 ));
  MUXF7 \spo[7]_INST_0_i_10 
       (.I0(g8_b7_n_0),
        .I1(g9_b7_n_0),
        .O(\spo[7]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[7]_INST_0_i_2 
       (.I0(\spo[7]_INST_0_i_7_n_0 ),
        .I1(\spo[7]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[7]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[7]_INST_0_i_10_n_0 ),
        .O(\spo[7]_INST_0_i_2_n_0 ));
  MUXF7 \spo[7]_INST_0_i_3 
       (.I0(g6_b7_n_0),
        .I1(g7_b7_n_0),
        .O(\spo[7]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_4 
       (.I0(g4_b7_n_0),
        .I1(g5_b7_n_0),
        .O(\spo[7]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_5 
       (.I0(g2_b7_n_0),
        .I1(g3_b7_n_0),
        .O(\spo[7]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_6 
       (.I0(g0_b7_n_0),
        .I1(g1_b7_n_0),
        .O(\spo[7]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_7 
       (.I0(g14_b7_n_0),
        .I1(g15_b7_n_0),
        .O(\spo[7]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_8 
       (.I0(g12_b7_n_0),
        .I1(g13_b7_n_0),
        .O(\spo[7]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[7]_INST_0_i_9 
       (.I0(g10_b7_n_0),
        .I1(g11_b7_n_0),
        .O(\spo[7]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0 
       (.I0(\spo[8]_INST_0_i_1_n_0 ),
        .I1(\spo[8]_INST_0_i_2_n_0 ),
        .O(\^spo [8]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[8]_INST_0_i_1 
       (.I0(\spo[8]_INST_0_i_3_n_0 ),
        .I1(\spo[8]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[8]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[8]_INST_0_i_6_n_0 ),
        .O(\spo[8]_INST_0_i_1_n_0 ));
  MUXF7 \spo[8]_INST_0_i_10 
       (.I0(g8_b8_n_0),
        .I1(g9_b8_n_0),
        .O(\spo[8]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[8]_INST_0_i_2 
       (.I0(\spo[8]_INST_0_i_7_n_0 ),
        .I1(\spo[8]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[8]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[8]_INST_0_i_10_n_0 ),
        .O(\spo[8]_INST_0_i_2_n_0 ));
  MUXF7 \spo[8]_INST_0_i_3 
       (.I0(g6_b8_n_0),
        .I1(g7_b8_n_0),
        .O(\spo[8]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_4 
       (.I0(g4_b8_n_0),
        .I1(g5_b8_n_0),
        .O(\spo[8]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_5 
       (.I0(g2_b8_n_0),
        .I1(g3_b8_n_0),
        .O(\spo[8]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_6 
       (.I0(g0_b8_n_0),
        .I1(g1_b8_n_0),
        .O(\spo[8]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_7 
       (.I0(g14_b8_n_0),
        .I1(g15_b8_n_0),
        .O(\spo[8]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_8 
       (.I0(g12_b8_n_0),
        .I1(g13_b8_n_0),
        .O(\spo[8]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[8]_INST_0_i_9 
       (.I0(g10_b8_n_0),
        .I1(g11_b8_n_0),
        .O(\spo[8]_INST_0_i_9_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0 
       (.I0(\spo[9]_INST_0_i_1_n_0 ),
        .I1(\spo[9]_INST_0_i_2_n_0 ),
        .O(\^spo [9]),
        .S(a[9]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[9]_INST_0_i_1 
       (.I0(\spo[9]_INST_0_i_3_n_0 ),
        .I1(\spo[9]_INST_0_i_4_n_0 ),
        .I2(a[8]),
        .I3(\spo[9]_INST_0_i_5_n_0 ),
        .I4(a[7]),
        .I5(\spo[9]_INST_0_i_6_n_0 ),
        .O(\spo[9]_INST_0_i_1_n_0 ));
  MUXF7 \spo[9]_INST_0_i_10 
       (.I0(g8_b9_n_0),
        .I1(g9_b9_n_0),
        .O(\spo[9]_INST_0_i_10_n_0 ),
        .S(a[6]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \spo[9]_INST_0_i_2 
       (.I0(\spo[9]_INST_0_i_7_n_0 ),
        .I1(\spo[9]_INST_0_i_8_n_0 ),
        .I2(a[8]),
        .I3(\spo[9]_INST_0_i_9_n_0 ),
        .I4(a[7]),
        .I5(\spo[9]_INST_0_i_10_n_0 ),
        .O(\spo[9]_INST_0_i_2_n_0 ));
  MUXF7 \spo[9]_INST_0_i_3 
       (.I0(g6_b9_n_0),
        .I1(g7_b9_n_0),
        .O(\spo[9]_INST_0_i_3_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_4 
       (.I0(g4_b9_n_0),
        .I1(g5_b9_n_0),
        .O(\spo[9]_INST_0_i_4_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_5 
       (.I0(g2_b9_n_0),
        .I1(g3_b9_n_0),
        .O(\spo[9]_INST_0_i_5_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_6 
       (.I0(g0_b9_n_0),
        .I1(g1_b9_n_0),
        .O(\spo[9]_INST_0_i_6_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_7 
       (.I0(g14_b9_n_0),
        .I1(g15_b9_n_0),
        .O(\spo[9]_INST_0_i_7_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_8 
       (.I0(g12_b9_n_0),
        .I1(g13_b9_n_0),
        .O(\spo[9]_INST_0_i_8_n_0 ),
        .S(a[6]));
  MUXF7 \spo[9]_INST_0_i_9 
       (.I0(g10_b9_n_0),
        .I1(g11_b9_n_0),
        .O(\spo[9]_INST_0_i_9_n_0 ),
        .S(a[6]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
