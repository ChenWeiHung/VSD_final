set_host_options -max_cores 32 

create_lib CPU \
-technology /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/tf/saed14nm_1p9m.tf \
-ref_libs {
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_base_frame_timing.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_cg_frame_timing.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_dlvl_frame_timing.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_frame_only.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_iso_frame_timing.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_pg_frame_timing.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_ret_frame_timing.ndm 
	/home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_STD_SLVT/ndm/saed14slvt_ulvl_frame_timing.ndm 
	/home/summer/cell_library/SAED/14/io/lib/io_std/ndm/saed14io_fc_frame_timing_ccs.ndm 
}

read_parasitic_tech -name rcmax -tlup /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmax.tlup \
                    -layermap /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map
read_parasitic_tech -name rcnom -tlup /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cnom.tlup \
                    -layermap /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map
read_parasitic_tech -name rcmin -tlup /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/tlup/saed14nm_1p9m_Cmin.tlup \
                    -layermap /home/summer/cell_library/SAED/SAED14nm_EDK_08_2024/SAED14nm_EDK_TECH_DATA/map/saed14nm_tf_itf_tluplus.map

create_block CPU -origin_type bottom_left
link_block

set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8   }] routing_direction vertical  

save_block -as CPU:design_setup.design
save_lib


initialize_floorplan -core_utilization 0.8 -honor_pad_limit -core_offset {300}