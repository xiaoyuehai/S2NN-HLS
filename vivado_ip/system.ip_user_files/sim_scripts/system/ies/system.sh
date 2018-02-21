#!/bin/bash -f
# Vivado (TM) v2015.4 (64-bit)
#
# Filename    : system.sh
# Simulator   : Cadence Incisive Enterprise Simulator
# Description : Simulation script for compiling, elaborating and verifying the project source files.
#               The script will automatically create the design libraries sub-directories in the run
#               directory, add the library logical mappings in the simulator setup file, create default
#               'do/prj' file, execute compilation, elaboration and simulation steps.
#
# Generated by Vivado on Wed Jun 22 16:36:12 +0100 2016
# IP Build 1412160 on Tue Nov 17 13:47:24 MST 2015 
#
# usage: system.sh [-help]
# usage: system.sh [-lib_map_path]
# usage: system.sh [-noclean_files]
# usage: system.sh [-reset_run]
#
# Prerequisite:- To compile and run simulation, you must compile the Xilinx simulation libraries using the
# 'compile_simlib' TCL command. For more information about this command, run 'compile_simlib -help' in the
# Vivado Tcl Shell. Once the libraries have been compiled successfully, specify the -lib_map_path switch
# that points to these libraries and rerun export_simulation. For more information about this switch please
# type 'export_simulation -help' in the Tcl shell.
#
# You can also point to the simulation libraries by either replacing the <SPECIFY_COMPILED_LIB_PATH> in this
# script with the compiled library directory path or specify this path with the '-lib_map_path' switch when
# executing this script. Please type 'system.sh -help' for more information.
#
# Additional references - 'Xilinx Vivado Design Suite User Guide:Logic simulation (UG900)'
#
# ********************************************************************************************************

# Script info
echo -e "system.sh - Script generated by export_simulation (Vivado v2015.4 (64-bit)-id)\n"

# Script usage
usage()
{
  msg="Usage: system.sh [-help]\n\
Usage: system.sh [-lib_map_path]\n\
Usage: system.sh [-reset_run]\n\
Usage: system.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}

if [[ ($# == 1 ) && ($1 != "-lib_map_path" && $1 != "-noclean_files" && $1 != "-reset_run" && $1 != "-help" && $1 != "-h") ]]; then
  echo -e "ERROR: Unknown option specified '$1' (type \"./system.sh -help\" for more information)\n"
  exit 1
fi

if [[ ($1 == "-help" || $1 == "-h") ]]; then
  usage
fi

# STEP: setup
setup()
{
  case $1 in
    "-lib_map_path" )
      if [[ ($2 == "") ]]; then
        echo -e "ERROR: Simulation library directory path not specified (type \"./system.sh -help\" for more information)\n"
        exit 1
      fi
      # precompiled simulation library directory path
     create_lib_mappings $2
     touch hdl.var
    ;;
    "-reset_run" )
      reset_run
      echo -e "INFO: Simulation run files deleted.\n"
      exit 0
    ;;
    "-noclean_files" )
      # do not remove previous data
    ;;
    * )
     create_lib_mappings $2
     touch hdl.var
  esac

  # Add any setup/initialization commands here:-

  # <user specific commands>

}

# Remove generated data from the previous run and re-create setup files/library mappings
reset_run()
{
  files_to_remove=(ncsim.key irun.key ncvlog.log ncvhdl.log compile.log elaborate.log simulate.log run.log waves.shm INCA_libs)
  for (( i=0; i<${#files_to_remove[*]}; i++ )); do
    file="${files_to_remove[i]}"
    if [[ -e $file ]]; then
      rm -rf $file
    fi
  done
}

# Main steps
run()
{
  setup $1 $2
  compile
  elaborate
  simulate
}

# Create design library directory paths and define design library mappings in cds.lib
create_lib_mappings()
{
  libs=(xbip_utils_v3_0_5 axi_utils_v2_0_1 xbip_pipe_v3_0_1 xbip_dsp48_wrapper_v3_0_4 xbip_dsp48_addsub_v3_0_1 xbip_dsp48_multadd_v3_0_1 xbip_bram18k_v3_0_1 mult_gen_v12_0_10 floating_point_v7_1_1 xil_defaultlib lib_pkg_v1_0_2 fifo_generator_v13_0_1 lib_fifo_v1_0_4 lib_srl_fifo_v1_0_2 lib_cdc_v1_0_2 axi_datamover_v5_1_9 axi_sg_v4_1_2 axi_dma_v7_1_8 generic_baseblocks_v2_1_0 axi_data_fifo_v2_1_6 axi_infrastructure_v1_1_0 axi_register_slice_v2_1_7 axi_protocol_converter_v2_1_7 axi_crossbar_v2_1_8 proc_sys_reset_v5_0_8)
  file="cds.lib"
  dir="ies"

  if [[ -e $file ]]; then
    rm -f $file
  fi

  if [[ -e $dir ]]; then
    rm -rf $dir
  fi

  touch $file
  lib_map_path="<SPECIFY_COMPILED_LIB_PATH>"
  if [[ ($1 != "" && -e $1) ]]; then
    lib_map_path="$1"
  else
    echo -e "ERROR: Compiled simulation library directory path not specified or does not exist (type "./top.sh -help" for more information)\n"
  fi
  incl_ref="INCLUDE $lib_map_path/cds.lib"
  echo $incl_ref >> $file

  for (( i=0; i<${#libs[*]}; i++ )); do
    lib="${libs[i]}"
    lib_dir="$dir/$lib"
    if [[ ! -e $lib_dir ]]; then
      mkdir -p $lib_dir
      mapping="DEFINE $lib $dir/$lib"
      echo $mapping >> $file
    fi
  done
}


# RUN_STEP: <compile>
compile()
{
  # Directory path for design sources and include directories (if any) wrt this path
  ref_dir="."
  # Command line options
  opts_ver="-64bit -messages -logfile ncvlog.log -append_log"
  opts_vhd="-64bit -V93 -RELAX -logfile ncvhdl.log -append_log"

  # Compile design files
  ncvhdl -work xbip_utils_v3_0_5 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_utils_v3_0/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

  ncvhdl -work axi_utils_v2_0_1 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/axi_utils_v2_0/hdl/axi_utils_v2_0_vh_rfs.vhd" \

  ncvhdl -work xbip_pipe_v3_0_1 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_pipe_v3_0/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_pipe_v3_0/hdl/xbip_pipe_v3_0.vhd" \

  ncvhdl -work xbip_dsp48_wrapper_v3_0_4 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_dsp48_wrapper_v3_0/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

  ncvhdl -work xbip_dsp48_addsub_v3_0_1 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_dsp48_addsub_v3_0/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_dsp48_addsub_v3_0/hdl/xbip_dsp48_addsub_v3_0.vhd" \

  ncvhdl -work xbip_dsp48_multadd_v3_0_1 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_dsp48_multadd_v3_0/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_dsp48_multadd_v3_0/hdl/xbip_dsp48_multadd_v3_0.vhd" \

  ncvhdl -work xbip_bram18k_v3_0_1 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_bram18k_v3_0/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xbip_bram18k_v3_0/hdl/xbip_bram18k_v3_0.vhd" \

  ncvhdl -work mult_gen_v12_0_10 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/mult_gen_v12_0/hdl/mult_gen_v12_0_vh_rfs.vhd" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/mult_gen_v12_0/hdl/mult_gen_v12_0.vhd" \

  ncvhdl -work floating_point_v7_1_1 $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/floating_point_v7_1/hdl/floating_point_v7_1_vh_rfs.vhd" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_axis_cp_inputs_to_mem.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_axis_cp_network_to_mem.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_axis_cp_output_to_stream.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_control_s_axi.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_hls_snn_initialize.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_hls_snn_process_step.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_hls_snn_process_step_p_mem_V.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_16ns_32s_48_3.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_21ns_32s_52_3.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_23ns_32s_54_3.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_32s_32s_64_6.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_32s_33s_64_6.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_52s_32s_83_5.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_53s_32s_84_5.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_57s_32ns_80_5.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_57s_32ns_88_5.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_mul_mul_16ns_13ns_28_1.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_neuron_type_mem_V.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_output_indexes_mem.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_sitofp_32ns_32_6.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_snn_get_synaptic_conductances.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_snn_process_step.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_snn_process_step_synapse_s_mem_V.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_u_mem_V.v" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/verilog/hls_snn_izikevich_v_mem_V.v" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/hdl/ip/hls_snn_izikevich_ap_sitofp_4_no_dsp_32.vhd" \
    "$ref_dir/../../../bd/system/ip/system_hls_snn_izikevich_0_0/sim/system_hls_snn_izikevich_0_0.vhd" \

  ncvhdl -work lib_pkg_v1_0_2 $opts_vhd \
    "$ref_dir/../../../ipstatic/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd" \

  ncvhdl -work fifo_generator_v13_0_1 $opts_vhd \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_0/simulation/fifo_generator_vhdl_beh.vhd" \
    "$ref_dir/../../../ipstatic/fifo_generator_v13_0/hdl/fifo_generator_v13_0_rfs.vhd" \

  ncvhdl -work lib_fifo_v1_0_4 $opts_vhd \
    "$ref_dir/../../../ipstatic/lib_fifo_v1_0/hdl/src/vhdl/async_fifo_fg.vhd" \
    "$ref_dir/../../../ipstatic/lib_fifo_v1_0/hdl/src/vhdl/sync_fifo_fg.vhd" \

  ncvhdl -work lib_srl_fifo_v1_0_2 $opts_vhd \
    "$ref_dir/../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/cntr_incr_decr_addn_f.vhd" \
    "$ref_dir/../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/dynshreg_f.vhd" \
    "$ref_dir/../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_rbu_f.vhd" \
    "$ref_dir/../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_f.vhd" \

  ncvhdl -work lib_cdc_v1_0_2 $opts_vhd \
    "$ref_dir/../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \

  ncvhdl -work axi_datamover_v5_1_9 $opts_vhd \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_reset.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_afifo_autord.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_sfifo_autord.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_fifo.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_cmd_status.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_scc.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_strb_gen2.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_pcc.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_addr_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rdmux.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rddata_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rd_status_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_demux.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wrdata_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_status_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_skid2mm_buf.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_skid_buf.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_rd_sf.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_wr_sf.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_stbs_set.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_stbs_set_nodre.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_ibttcc.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_indet_btt.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux2_1_x_n.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux4_1_x_n.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_dre_mux8_1_x_n.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_dre.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_dre.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_ms_strb_set.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mssai_skid_buf.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_slice.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_scatter.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_realign.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_basic_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_omit_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_s2mm_full_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_basic_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_omit_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover_mm2s_full_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_datamover_v5_1/hdl/src/vhdl/axi_datamover.vhd" \

  ncvhdl -work axi_sg_v4_1_2 $opts_vhd \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_pkg.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_reset.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_sfifo_autord.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_afifo_autord.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_fifo.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_cmd_status.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_rdmux.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_addr_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_rddata_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_rd_status_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_scc.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_wr_demux.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_scc_wr.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_skid2mm_buf.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_wrdata_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_wr_status_cntl.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_skid_buf.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_mm2s_basic_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_s2mm_basic_wrap.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_datamover.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_sm.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_pntr.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_cmdsts_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_cntrl_strm.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_queue.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_noqueue.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_ftch_q_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_cmdsts_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_sm.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_queue.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_noqueue.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_updt_q_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg_intrpt.vhd" \
    "$ref_dir/../../../ipstatic/axi_sg_v4_1/hdl/src/vhdl/axi_sg.vhd" \

  ncvhdl -work axi_dma_v7_1_8 $opts_vhd \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_pkg.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_reset.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_rst_module.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_lite_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_register.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_register_s2mm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_reg_module.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_skid_buf.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_afifo_autord.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_sofeof_gen.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_smple_sm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_sg_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_sm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_cmdsts_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_sts_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_cntrl_strm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_mm2s_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sg_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_cmdsts_if.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sts_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_sts_strm.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_s2mm_mngr.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma_cmd_split.vhd" \
    "$ref_dir/../../../ipstatic/axi_dma_v7_1/hdl/src/vhdl/axi_dma.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/system/ip/system_axi_dma_0_0/sim/system_axi_dma_0_0.vhd" \

  ncvlog -work generic_baseblocks_v2_1_0 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
    "$ref_dir/../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \

  ncvlog -work axi_data_fifo_v2_1_6 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
    "$ref_dir/../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \

  ncvlog -work axi_infrastructure_v1_1_0 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \

  ncvlog -work axi_register_slice_v2_1_7 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
    "$ref_dir/../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \

  ncvlog -work axi_protocol_converter_v2_1_7 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
    "$ref_dir/../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../bd/system/ip/system_axi_protocol_converter_0_0/sim/system_axi_protocol_converter_0_0.v" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/system/ip/system_axi_dma_0_1/sim/system_axi_dma_0_1.vhd" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../bd/system/ip/system_axi_protocol_converter_0_1/sim/system_axi_protocol_converter_0_1.v" \
    "$ref_dir/../../../bd/system/ip/system_axi_protocol_converter_0_2/sim/system_axi_protocol_converter_0_2.v" \
    "$ref_dir/../../../bd/system/ip/system_axi_protocol_converter_0_3/sim/system_axi_protocol_converter_0_3.v" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/system/ip/system_axi_dma_1_0/sim/system_axi_dma_1_0.vhd" \
    "$ref_dir/../../../bd/system/ip/system_axi_dma_1_1/sim/system_axi_dma_1_1.vhd" \

  ncvlog -work axi_crossbar_v2_1_8 $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v" \
    "$ref_dir/../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../bd/system/ip/system_axi_crossbar_0_0/sim/system_axi_crossbar_0_0.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr_4.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd_4.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp2_3.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp0_1.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ssw_hp.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_sparse_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_reg_map.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocm_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_wr_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_rd_mem.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_fmsw_gp.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_regc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocmc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_interconnect_model.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_reset.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_clock.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ddrc.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_slave.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_master.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_afi_slave.v" \
    "$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_processing_system7_bfm.v" \
    "$ref_dir/../../../bd/system/ip/system_processing_system7_0_0/sim/system_processing_system7_0_0.v" \

  ncvhdl -work proc_sys_reset_v5_0_8 $opts_vhd \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
    "$ref_dir/../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \

  ncvhdl -work xil_defaultlib $opts_vhd \
    "$ref_dir/../../../bd/system/ip/system_rst_processing_system7_0_100M_0/sim/system_rst_processing_system7_0_100M_0.vhd" \

  ncvlog -work xil_defaultlib $opts_ver +incdir+"$ref_dir/../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog" +incdir+"$ref_dir/../../../ipstatic/processing_system7_bfm_v2_0/hdl" +incdir+"$ref_dir/../../../../system.srcs/sources_1/bd/system/ipshared/xilinx.com/hls_snn_izikevich_v1_0/drivers/hls_snn_izikevich_v1_0/src" \
    "$ref_dir/../../../bd/system/ipshared/xilinx.com/xlconcat_v2_1/xlconcat.v" \
    "$ref_dir/../../../bd/system/ip/system_xlconcat_0_0/sim/system_xlconcat_0_0.v" \
    "$ref_dir/../../../bd/system/ip/system_xbar_0/sim/system_xbar_0.v" \
    "$ref_dir/../../../bd/system/ip/system_auto_pc_1/sim/system_auto_pc_1.v" \
    "$ref_dir/../../../bd/system/hdl/system.v" \


  ncvlog $opts_ver -work xil_defaultlib \
    "glbl.v"

}

# RUN_STEP: <elaborate>
elaborate()
{
  opts="-loadvpi "C:/Xilinx/Vivado/2015.4/lib/win64.o/libxil_ncsim.dll:xilinx_register_systf" -64bit -relax -access +rwc -messages -logfile elaborate.log -timescale 1ps/1ps"
  libs="-libname unisims_ver -libname unimacro_ver -libname secureip -libname xbip_utils_v3_0_5 -libname axi_utils_v2_0_1 -libname xbip_pipe_v3_0_1 -libname xbip_dsp48_wrapper_v3_0_4 -libname xbip_dsp48_addsub_v3_0_1 -libname xbip_dsp48_multadd_v3_0_1 -libname xbip_bram18k_v3_0_1 -libname mult_gen_v12_0_10 -libname floating_point_v7_1_1 -libname xil_defaultlib -libname lib_pkg_v1_0_2 -libname fifo_generator_v13_0_1 -libname lib_fifo_v1_0_4 -libname lib_srl_fifo_v1_0_2 -libname lib_cdc_v1_0_2 -libname axi_datamover_v5_1_9 -libname axi_sg_v4_1_2 -libname axi_dma_v7_1_8 -libname generic_baseblocks_v2_1_0 -libname axi_data_fifo_v2_1_6 -libname axi_infrastructure_v1_1_0 -libname axi_register_slice_v2_1_7 -libname axi_protocol_converter_v2_1_7 -libname axi_crossbar_v2_1_8 -libname proc_sys_reset_v5_0_8"
  ncelab $opts xil_defaultlib.system xil_defaultlib.glbl $libs
}

# RUN_STEP: <simulate>
simulate()
{
  opts="-64bit -logfile simulate.log"
  ncsim $opts xil_defaultlib.system -input simulate.do
}
# Script usage
usage()
{
  msg="Usage: system.sh [-help]\n\
Usage: system.sh [-lib_map_path]\n\
Usage: system.sh [-reset_run]\n\
Usage: system.sh [-noclean_files]\n\n\
[-help] -- Print help information for this script\n\n\
[-lib_map_path <path>] -- Compiled simulation library directory path. The simulation library is compiled\n\
using the compile_simlib tcl command. Please see 'compile_simlib -help' for more information.\n\n\
[-reset_run] -- Recreate simulator setup files and library mappings for a clean run. The generated files\n\
from the previous run will be removed. If you don't want to remove the simulator generated files, use the\n\
-noclean_files switch.\n\n\
[-noclean_files] -- Reset previous run, but do not remove simulator generated files from the previous run.\n\n"
  echo -e $msg
  exit 1
}


# Launch script
run $1 $2
