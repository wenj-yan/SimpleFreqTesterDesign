transcript on 
write transcript nco_vho_transcript
if {[file exist [project env]] > 0} {
project close
}
if {[file exist "E:/shu/gjg6/towr/EP4CE10_Ethernet_1G/EP4CE10_V1.1_Ethernet_1G/Project/NCO_ZSJ.mpf"] == 0} {
  project new [pwd] NCO_ZSJ
} else	{
project open NCO_ZSJ
}
# Create default work directory if not present
if {[file exist work] ==0} 	{
  exec vlib work
  exec vmap work work
}
# Map lpm library
if {[file exist lpm] ==0} 	{
  exec vlib lpm
  exec vmap lpm lpm}
vcom -93 -work lpm  $env(QUARTUS_ROOTDIR)/eda/sim_lib/220pack.vhd 
vcom -93 -work lpm  $env(QUARTUS_ROOTDIR)/eda/sim_lib/220model.vhd 

# Map altera_mf library
if {[file exist altera_mf] ==0} 	{
  exec vlib altera_mf
  exec vmap altera_mf altera_mf}
vcom -93 -work altera_mf $env(QUARTUS_ROOTDIR)/eda/sim_lib/altera_mf_components.vhd 
vcom -93 -work altera_mf $env(QUARTUS_ROOTDIR)/eda/sim_lib/altera_mf.vhd 

# Map sgate library
if {[file exist sgate] ==0} 	{
  exec vlib sgate
  exec vmap sgate sgate}
vcom -93 -work sgate $env(QUARTUS_ROOTDIR)/eda/sim_lib/sgate_pack.vhd 
vcom -93 -work sgate $env(QUARTUS_ROOTDIR)/eda/sim_lib/sgate.vhd 

vcom -93 NCO_ZSJ.vho
vcom -93 NCO_ZSJ_tb.vhd
vsim -novopt NCO_ZSJ_tb
do NCO_ZSJ_wave.do
run 22000 ns
