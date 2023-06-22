#Part: xc7z020clg484-1
#ZedBoard Zynq Evaluation and Development Kit

set_property PACKAGE_PIN Y9  [get_ports sys_clock]
set_property IOSTANDARD LVCMOS33  [get_ports sys_clock]

set_property PACKAGE_PIN AA9  [get_ports clock]
set_property IOSTANDARD LVCMOS33  [get_ports clock]

set_property PACKAGE_PIN F22  [get_ports reset_n]; # SW0
set_property IOSTANDARD LVCMOS33  [get_ports reset_n];

# INPUT
set_property PACKAGE_PIN N15  [get_ports sensor1]; # BTNL
set_property PACKAGE_PIN P16  [get_ports sensor2]; # BTNC
set_property PACKAGE_PIN R18  [get_ports sensor3]; # BTNR
set_property PACKAGE_PIN R16 [ get_ports enable]; # BTNU
set_property PACKAGE_PIN H22  [get_ports valid_Epass[1]]; # SW2
set_property PACKAGE_PIN G22  [get_ports valid_Epass[0]]; # SW1


set_property IOSTANDARD LVCMOS33  [get_ports sensor1]; # BTNL
set_property IOSTANDARD LVCMOS33  [get_ports sensor2]; # BTNC
set_property IOSTANDARD LVCMOS33  [get_ports sensor3]; # BTNR
set_property IOSTANDARD LVCMOS33  [get_ports valid_Epass[0]]; # SW1
set_property IOSTANDARD LVCMOS33  [get_ports valid_Epass[1]]; # SW2
set_property IOSTANDARD LVCMOS33  [get_ports enable]; # SW1

# OUTPUT
#set_property PACKAGE_PIN Y11  [get_ports barrier]; # JA1
set_property PACKAGE_PIN T22  [get_ports {barrier}];
set_property PACKAGE_PIN AA11  [get_ports serial_data_out]; # JA2
set_property PACKAGE_PIN U14  [get_ports  {led1}]; # LD7
set_property PACKAGE_PIN U19  [get_ports  {led2}]; # LD6
set_property PACKAGE_PIN W22  [get_ports  {led3}]; # LD5
set_property PACKAGE_PIN V22  [get_ports  {led4}]; # LD4
set_property PACKAGE_PIN U21  [get_ports  {led5}]; # LD3
set_property PACKAGE_PIN U22  [get_ports  {led6}]; # LD2

set_property IOSTANDARD LVCMOS33  [get_ports {barrier}]; # JA1
set_property IOSTANDARD LVCMOS33  [get_ports serial_data_out]; # JA2
set_property IOSTANDARD LVCMOS33  [get_ports  {led1}]; # LD7
set_property IOSTANDARD LVCMOS33  [get_ports  {led2}]; # LD6
set_property IOSTANDARD LVCMOS33  [get_ports  {led3}]; # LD5
set_property IOSTANDARD LVCMOS33  [get_ports  {led4}]; # LD4
set_property IOSTANDARD LVCMOS33  [get_ports  {led5}]; # LD3
set_property IOSTANDARD LVCMOS33  [get_ports  {led6}]; # LD2
set_property DRIVE 8 [get_ports serial_data_out];