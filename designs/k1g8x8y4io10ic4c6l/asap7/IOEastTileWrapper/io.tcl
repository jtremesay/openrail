set_io_pin_constraint -region top:* -pin_names [list  config_out]
set_io_pin_constraint -region bottom:* -pin_names [list config_in]
set_io_pin_constraint -region left:* -pin_names [list  data_from_ic data_to_ic clock nreset]
set_io_pin_constraint -region right:* -pin_names [list data_from_io data_to_io config_enable config_nreset]