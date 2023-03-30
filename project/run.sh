entity=$(basename "$(pwd)")
testbench="${entity}_tb"
vcdfile="${entity}.vcd"

ghdl -a *.vhd
ghdl -e $testbench

if [ $? -ne 0 ]; then
    exit $?
fi

ghdl -r $testbench --vcd=$vcdfile --stop-time=1000ms