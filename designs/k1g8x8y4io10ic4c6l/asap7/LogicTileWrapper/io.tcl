set_io_pin_constraint -region top:* -pin_names [list data_north_out data_north_in config_out]
set_io_pin_constraint -region bottom:* -pin_names [list config_in data_south_in data_south_out]
set_io_pin_constraint -region left:* -pin_names [list data_west_in data_west_out clock nreset]
set_io_pin_constraint -region right:* -pin_names [list data_east_out data_east_in config_enable config_nreset]