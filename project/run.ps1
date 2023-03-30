$entity = Split-Path (Get-Location) -Leaf
$testbench = "${entity}_tb"
$vcdfile = "${entity}.vcd"

ghdl -a *.vhd
ghdl -e $testbench

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

ghdl -r $testbench --vcd=$vcdfile --stop-time=1000ms
gtkwave $vcdfile