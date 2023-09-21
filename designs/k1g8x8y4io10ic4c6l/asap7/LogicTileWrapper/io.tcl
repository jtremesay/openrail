set_io_pin_constraint -region top:* -pin_names [list data_north_in data_north_out config_out]
set_io_pin_constraint -region bottom:* -pin_names [list data_south_out data_south_in config_in]
set_io_pin_constraint -region left:* -pin_names [list data_west_in data_west_out clock nreset]
set_io_pin_constraint -region right:* -pin_names [list data_east_out data_east_in config_enable config_nreset]