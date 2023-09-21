set_io_pin_constraint -region top:* -pin_names [list data_to_ic data_from_ic config_out]
set_io_pin_constraint -region bottom:* -pin_names [list config_in data_from_io data_to_io]
set_io_pin_constraint -region left:* -pin_names [list clock]
set_io_pin_constraint -region right:* -pin_names [list config_enable config_nreset]