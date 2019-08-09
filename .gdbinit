#GDB_PATH="/home/icomm-iot/IOT/ali-smartliving-device-alios-things-rel_1.0.0/build/compiler/nds32le-elf-newlib-v3/bin/nds32le-elf-gdb"
set remotetimeout 20

shell /home/icomm-iot/IOT/ali-smartliving-device-alios-things-rel_1.0.0/build/cmd/linux64/dash -c "trap \"\" 2;"/home/icomm-iot/IOT/ali-smartliving-device-alios-things-rel_1.0.0/build/OpenOCD/Linux64/bin/openocd" -f .//build/OpenOCD/Linux64/interface/ICEman.cfg -f .//build/OpenOCD/Linux64/ICEman/ICEman.cfg -f .//build/OpenOCD/Linux64/ICEman/ICEman_gdb_jtag.cfg -l out/openocd.log &"
