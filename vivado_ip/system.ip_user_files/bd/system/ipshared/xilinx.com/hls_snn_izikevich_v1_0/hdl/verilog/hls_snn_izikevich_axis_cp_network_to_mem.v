// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
// Version: 2015.4
// Copyright (C) 2015 Xilinx Inc. All rights reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module hls_snn_izikevich_axis_cp_network_to_mem (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        input_stream0_TDATA,
        input_stream0_TVALID,
        input_stream0_TREADY,
        input_stream0_TLAST,
        neuron_type_mem_V_address0,
        neuron_type_mem_V_ce0,
        neuron_type_mem_V_we0,
        neuron_type_mem_V_d0,
        neuron_type_mem_V_q0
);

parameter    ap_const_logic_1 = 1'b1;
parameter    ap_const_logic_0 = 1'b0;
parameter    ap_ST_st1_fsm_0 = 4'b1;
parameter    ap_ST_pp0_stg0_fsm_1 = 4'b10;
parameter    ap_ST_pp0_stg1_fsm_2 = 4'b100;
parameter    ap_ST_st5_fsm_3 = 4'b1000;
parameter    ap_const_lv32_0 = 32'b00000000000000000000000000000000;
parameter    ap_const_lv1_1 = 1'b1;
parameter    ap_const_lv32_1 = 32'b1;
parameter    ap_const_lv1_0 = 1'b0;
parameter    ap_const_lv32_2 = 32'b10;
parameter    ap_const_lv14_0 = 14'b00000000000000;
parameter    ap_const_lv7_0 = 7'b0000000;
parameter    ap_const_lv14_2740 = 14'b10011101000000;
parameter    ap_const_lv14_1 = 14'b1;
parameter    ap_const_lv7_40 = 7'b1000000;
parameter    ap_const_lv32_64 = 32'b1100100;
parameter    ap_const_lv32_63 = 32'b1100011;
parameter    ap_const_lv7_1 = 7'b1;
parameter    ap_const_lv32_3 = 32'b11;
parameter    ap_true = 1'b1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [63:0] input_stream0_TDATA;
input   input_stream0_TVALID;
output   input_stream0_TREADY;
input  [0:0] input_stream0_TLAST;
output  [6:0] neuron_type_mem_V_address0;
output   neuron_type_mem_V_ce0;
output   neuron_type_mem_V_we0;
output  [99:0] neuron_type_mem_V_d0;
input  [99:0] neuron_type_mem_V_q0;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg input_stream0_TREADY;
reg neuron_type_mem_V_ce0;
reg neuron_type_mem_V_we0;
reg[99:0] neuron_type_mem_V_d0;
(* fsm_encoding = "none" *) reg   [3:0] ap_CS_fsm = 4'b1;
reg    ap_sig_cseq_ST_st1_fsm_0;
reg    ap_sig_bdd_22;
reg   [13:0] indvar_flatten_reg_77;
reg   [6:0] bvh_d_index_reg_88;
reg   [31:0] y_1_reg_99;
reg   [31:0] l_1_reg_110;
wire   [0:0] exitcond_flatten_fu_121_p2;
reg   [0:0] exitcond_flatten_reg_246;
reg    ap_sig_cseq_ST_pp0_stg0_fsm_1;
reg    ap_sig_bdd_54;
reg    ap_reg_ppiten_pp0_it0 = 1'b0;
reg    ap_reg_ppiten_pp0_it1 = 1'b0;
wire   [13:0] indvar_flatten_next_fu_127_p2;
reg   [13:0] indvar_flatten_next_reg_250;
wire   [6:0] index_assign_mid2_fu_139_p3;
reg   [6:0] index_assign_mid2_reg_255;
wire   [0:0] tmp_fu_147_p2;
reg   [0:0] tmp_reg_261;
wire   [0:0] tmp_s_fu_153_p2;
reg   [0:0] tmp_s_reg_265;
wire   [7:0] tmp_157_fu_164_p1;
reg   [7:0] tmp_157_reg_269;
reg   [6:0] neuron_type_mem_V_addr_reg_274;
wire   [31:0] y_2_fu_186_p3;
reg   [31:0] y_2_reg_279;
wire   [31:0] l_2_fu_194_p3;
reg   [31:0] l_2_reg_284;
wire   [6:0] b_fu_211_p2;
reg   [6:0] b_reg_289;
reg    ap_sig_cseq_ST_pp0_stg1_fsm_2;
reg    ap_sig_bdd_92;
reg    ap_sig_bdd_101;
reg   [13:0] indvar_flatten_phi_fu_81_p4;
reg   [6:0] bvh_d_index_phi_fu_92_p4;
reg   [31:0] y_1_phi_fu_103_p4;
reg   [31:0] l_1_phi_fu_114_p4;
wire  signed [63:0] tmp_91_fu_159_p1;
reg   [63:0] p_Val2_s_fu_54;
wire   [0:0] exitcond4_fu_133_p2;
wire   [0:0] tmp_92_fu_168_p2;
wire   [31:0] y_fu_174_p2;
wire   [31:0] l_fu_180_p2;
wire   [31:0] index_assign_cast1_fu_216_p1;
wire   [0:0] tmp_156_fu_222_p3;
reg    ap_sig_cseq_ST_st5_fsm_3;
reg    ap_sig_bdd_215;
reg   [3:0] ap_NS_fsm;




always @ (posedge ap_clk) begin : ap_ret_ap_CS_fsm
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_st1_fsm_0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin : ap_ret_ap_reg_ppiten_pp0_it0
    if (ap_rst == 1'b1) begin
        ap_reg_ppiten_pp0_it0 <= ap_const_logic_0;
    end else begin
        if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & ~(exitcond_flatten_fu_121_p2 == ap_const_lv1_0))) begin
            ap_reg_ppiten_pp0_it0 <= ap_const_logic_0;
        end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~(ap_start == ap_const_logic_0))) begin
            ap_reg_ppiten_pp0_it0 <= ap_const_logic_1;
        end
    end
end

always @ (posedge ap_clk) begin : ap_ret_ap_reg_ppiten_pp0_it1
    if (ap_rst == 1'b1) begin
        ap_reg_ppiten_pp0_it1 <= ap_const_logic_0;
    end else begin
        if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg1_fsm_2) & (exitcond_flatten_reg_246 == ap_const_lv1_0) & ~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101))) begin
            ap_reg_ppiten_pp0_it1 <= ap_const_logic_1;
        end else if ((((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~(ap_start == ap_const_logic_0)) | ((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg1_fsm_2) & ~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101) & ~(exitcond_flatten_reg_246 == ap_const_lv1_0)))) begin
            ap_reg_ppiten_pp0_it1 <= ap_const_logic_0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        bvh_d_index_reg_88 <= b_reg_289;
    end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~(ap_start == ap_const_logic_0))) begin
        bvh_d_index_reg_88 <= ap_const_lv7_0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        indvar_flatten_reg_77 <= indvar_flatten_next_reg_250;
    end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~(ap_start == ap_const_logic_0))) begin
        indvar_flatten_reg_77 <= ap_const_lv14_0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        l_1_reg_110 <= l_2_reg_284;
    end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~(ap_start == ap_const_logic_0))) begin
        l_1_reg_110 <= ap_const_lv32_0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        y_1_reg_99 <= y_2_reg_279;
    end else if (((ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0) & ~(ap_start == ap_const_logic_0))) begin
        y_1_reg_99 <= ap_const_lv32_0;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & (ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg1_fsm_2) & (exitcond_flatten_reg_246 == ap_const_lv1_0) & ~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101))) begin
        b_reg_289 <= b_fu_211_p2;
    end
end

always @ (posedge ap_clk) begin
    if ((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1)) begin
        exitcond_flatten_reg_246 <= exitcond_flatten_fu_121_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (exitcond_flatten_fu_121_p2 == ap_const_lv1_0))) begin
        index_assign_mid2_reg_255 <= index_assign_mid2_fu_139_p3;
        tmp_reg_261 <= tmp_fu_147_p2;
        tmp_s_reg_265 <= tmp_s_fu_153_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it0))) begin
        indvar_flatten_next_reg_250 <= indvar_flatten_next_fu_127_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & (exitcond_flatten_fu_121_p2 == ap_const_lv1_0))) begin
        l_2_reg_284 <= l_2_fu_194_p3;
        y_2_reg_279 <= y_2_fu_186_p3;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (exitcond_flatten_fu_121_p2 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_s_fu_153_p2))) begin
        neuron_type_mem_V_addr_reg_274 <= tmp_91_fu_159_p1;
        tmp_157_reg_269 <= tmp_157_fu_164_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & (ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg1_fsm_2) & (exitcond_flatten_reg_246 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_reg_261) & ~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101))) begin
        p_Val2_s_fu_54 <= input_stream0_TDATA;
    end
end

always @ (ap_start or ap_sig_cseq_ST_st1_fsm_0 or ap_sig_cseq_ST_st5_fsm_3) begin
    if (((~(ap_const_logic_1 == ap_start) & (ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0)) | (ap_const_logic_1 == ap_sig_cseq_ST_st5_fsm_3))) begin
        ap_done = ap_const_logic_1;
    end else begin
        ap_done = ap_const_logic_0;
    end
end

always @ (ap_start or ap_sig_cseq_ST_st1_fsm_0) begin
    if ((~(ap_const_logic_1 == ap_start) & (ap_const_logic_1 == ap_sig_cseq_ST_st1_fsm_0))) begin
        ap_idle = ap_const_logic_1;
    end else begin
        ap_idle = ap_const_logic_0;
    end
end

always @ (ap_sig_cseq_ST_st5_fsm_3) begin
    if ((ap_const_logic_1 == ap_sig_cseq_ST_st5_fsm_3)) begin
        ap_ready = ap_const_logic_1;
    end else begin
        ap_ready = ap_const_logic_0;
    end
end

always @ (ap_sig_bdd_54) begin
    if (ap_sig_bdd_54) begin
        ap_sig_cseq_ST_pp0_stg0_fsm_1 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_pp0_stg0_fsm_1 = ap_const_logic_0;
    end
end

always @ (ap_sig_bdd_92) begin
    if (ap_sig_bdd_92) begin
        ap_sig_cseq_ST_pp0_stg1_fsm_2 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_pp0_stg1_fsm_2 = ap_const_logic_0;
    end
end

always @ (ap_sig_bdd_22) begin
    if (ap_sig_bdd_22) begin
        ap_sig_cseq_ST_st1_fsm_0 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_st1_fsm_0 = ap_const_logic_0;
    end
end

always @ (ap_sig_bdd_215) begin
    if (ap_sig_bdd_215) begin
        ap_sig_cseq_ST_st5_fsm_3 = ap_const_logic_1;
    end else begin
        ap_sig_cseq_ST_st5_fsm_3 = ap_const_logic_0;
    end
end

always @ (bvh_d_index_reg_88 or exitcond_flatten_reg_246 or ap_sig_cseq_ST_pp0_stg0_fsm_1 or ap_reg_ppiten_pp0_it1 or b_reg_289) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        bvh_d_index_phi_fu_92_p4 = b_reg_289;
    end else begin
        bvh_d_index_phi_fu_92_p4 = bvh_d_index_reg_88;
    end
end

always @ (indvar_flatten_reg_77 or exitcond_flatten_reg_246 or ap_sig_cseq_ST_pp0_stg0_fsm_1 or ap_reg_ppiten_pp0_it1 or indvar_flatten_next_reg_250) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        indvar_flatten_phi_fu_81_p4 = indvar_flatten_next_reg_250;
    end else begin
        indvar_flatten_phi_fu_81_p4 = indvar_flatten_reg_77;
    end
end

always @ (exitcond_flatten_reg_246 or ap_reg_ppiten_pp0_it0 or tmp_reg_261 or ap_sig_cseq_ST_pp0_stg1_fsm_2 or ap_sig_bdd_101) begin
    if (((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & (ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg1_fsm_2) & (exitcond_flatten_reg_246 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_reg_261) & ~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101))) begin
        input_stream0_TREADY = ap_const_logic_1;
    end else begin
        input_stream0_TREADY = ap_const_logic_0;
    end
end

always @ (l_1_reg_110 or exitcond_flatten_reg_246 or ap_sig_cseq_ST_pp0_stg0_fsm_1 or ap_reg_ppiten_pp0_it1 or l_2_reg_284) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        l_1_phi_fu_114_p4 = l_2_reg_284;
    end else begin
        l_1_phi_fu_114_p4 = l_1_reg_110;
    end
end

always @ (ap_sig_cseq_ST_pp0_stg0_fsm_1 or ap_reg_ppiten_pp0_it0 or ap_reg_ppiten_pp0_it1 or ap_sig_cseq_ST_pp0_stg1_fsm_2 or ap_sig_bdd_101) begin
    if ((((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & (ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg1_fsm_2) & ~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101)) | ((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1)))) begin
        neuron_type_mem_V_ce0 = ap_const_logic_1;
    end else begin
        neuron_type_mem_V_ce0 = ap_const_logic_0;
    end
end

always @ (ap_sig_cseq_ST_pp0_stg0_fsm_1 or ap_reg_ppiten_pp0_it1 or tmp_s_reg_265) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & ~(ap_const_lv1_0 == tmp_s_reg_265))) begin
        neuron_type_mem_V_we0 = ap_const_logic_1;
    end else begin
        neuron_type_mem_V_we0 = ap_const_logic_0;
    end
end

always @ (y_1_reg_99 or exitcond_flatten_reg_246 or ap_sig_cseq_ST_pp0_stg0_fsm_1 or ap_reg_ppiten_pp0_it1 or y_2_reg_279) begin
    if (((ap_const_logic_1 == ap_sig_cseq_ST_pp0_stg0_fsm_1) & (ap_const_logic_1 == ap_reg_ppiten_pp0_it1) & (exitcond_flatten_reg_246 == ap_const_lv1_0))) begin
        y_1_phi_fu_103_p4 = y_2_reg_279;
    end else begin
        y_1_phi_fu_103_p4 = y_1_reg_99;
    end
end
always @ (ap_start or ap_CS_fsm or exitcond_flatten_fu_121_p2 or ap_reg_ppiten_pp0_it0 or ap_sig_bdd_101) begin
    case (ap_CS_fsm)
        ap_ST_st1_fsm_0 : 
        begin
            if (~(ap_start == ap_const_logic_0)) begin
                ap_NS_fsm = ap_ST_pp0_stg0_fsm_1;
            end else begin
                ap_NS_fsm = ap_ST_st1_fsm_0;
            end
        end
        ap_ST_pp0_stg0_fsm_1 : 
        begin
            if (~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ~(exitcond_flatten_fu_121_p2 == ap_const_lv1_0))) begin
                ap_NS_fsm = ap_ST_pp0_stg1_fsm_2;
            end else begin
                ap_NS_fsm = ap_ST_st5_fsm_3;
            end
        end
        ap_ST_pp0_stg1_fsm_2 : 
        begin
            if (~((ap_const_logic_1 == ap_reg_ppiten_pp0_it0) & ap_sig_bdd_101)) begin
                ap_NS_fsm = ap_ST_pp0_stg0_fsm_1;
            end else begin
                ap_NS_fsm = ap_ST_pp0_stg1_fsm_2;
            end
        end
        ap_ST_st5_fsm_3 : 
        begin
            ap_NS_fsm = ap_ST_st1_fsm_0;
        end
        default : 
        begin
            ap_NS_fsm = 'bx;
        end
    endcase
end



always @ (input_stream0_TVALID or exitcond_flatten_reg_246 or tmp_reg_261) begin
    ap_sig_bdd_101 = ((input_stream0_TVALID == ap_const_logic_0) & (exitcond_flatten_reg_246 == ap_const_lv1_0) & ~(ap_const_lv1_0 == tmp_reg_261));
end


always @ (ap_CS_fsm) begin
    ap_sig_bdd_215 = (ap_const_lv1_1 == ap_CS_fsm[ap_const_lv32_3]);
end


always @ (ap_CS_fsm) begin
    ap_sig_bdd_22 = (ap_CS_fsm[ap_const_lv32_0] == ap_const_lv1_1);
end


always @ (ap_CS_fsm) begin
    ap_sig_bdd_54 = (ap_const_lv1_1 == ap_CS_fsm[ap_const_lv32_1]);
end


always @ (ap_CS_fsm) begin
    ap_sig_bdd_92 = (ap_const_lv1_1 == ap_CS_fsm[ap_const_lv32_2]);
end

assign b_fu_211_p2 = (index_assign_mid2_reg_255 + ap_const_lv7_1);

assign exitcond4_fu_133_p2 = (bvh_d_index_phi_fu_92_p4 == ap_const_lv7_40? 1'b1: 1'b0);

assign exitcond_flatten_fu_121_p2 = (indvar_flatten_phi_fu_81_p4 == ap_const_lv14_2740? 1'b1: 1'b0);

assign index_assign_cast1_fu_216_p1 = index_assign_mid2_reg_255;

assign index_assign_mid2_fu_139_p3 = ((exitcond4_fu_133_p2[0:0] === 1'b1) ? ap_const_lv7_0 : bvh_d_index_phi_fu_92_p4);

assign indvar_flatten_next_fu_127_p2 = (indvar_flatten_phi_fu_81_p4 + ap_const_lv14_1);

assign l_2_fu_194_p3 = ((tmp_92_fu_168_p2[0:0] === 1'b1) ? l_1_phi_fu_114_p4 : l_fu_180_p2);

assign l_fu_180_p2 = (l_1_phi_fu_114_p4 + ap_const_lv32_1);

assign neuron_type_mem_V_address0 = neuron_type_mem_V_addr_reg_274;


always @ (neuron_type_mem_V_q0 or tmp_157_reg_269 or tmp_156_fu_222_p3) begin
    neuron_type_mem_V_d0 = neuron_type_mem_V_q0;
    neuron_type_mem_V_d0[tmp_157_reg_269] = tmp_156_fu_222_p3[0];
end



assign tmp_156_fu_222_p3 = p_Val2_s_fu_54[index_assign_cast1_fu_216_p1];

assign tmp_157_fu_164_p1 = y_1_phi_fu_103_p4[7:0];

assign tmp_91_fu_159_p1 = $signed(l_1_phi_fu_114_p4);

assign tmp_92_fu_168_p2 = ($signed(y_1_phi_fu_103_p4) < $signed(32'b1100011)? 1'b1: 1'b0);

assign tmp_fu_147_p2 = (index_assign_mid2_fu_139_p3 == ap_const_lv7_0? 1'b1: 1'b0);

assign tmp_s_fu_153_p2 = ($signed(l_1_phi_fu_114_p4) < $signed(32'b1100100)? 1'b1: 1'b0);

assign y_2_fu_186_p3 = ((tmp_92_fu_168_p2[0:0] === 1'b1) ? y_fu_174_p2 : ap_const_lv32_0);

assign y_fu_174_p2 = (y_1_phi_fu_103_p4 + ap_const_lv32_1);


endmodule //hls_snn_izikevich_axis_cp_network_to_mem

