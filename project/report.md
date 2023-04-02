# Digital Circuit Design

## Design, simulation and synthesis of a microcontroller using VHDL in a programmable architecture component

# TODO LIST:

- [x] ALU
- [ ] Buffers A and B
- [ ] Buffers SR IN
- [ ] Control Block
- [ ] Memory Instruction
- [ ] Memory Select FCT
- [ ] Memory Select Out
- [ ] Memory Cache 1 and 2


### 1. ALU
THE ALU IS ONLY UPDATED WHEN SEL_FCT CHANGES
The ALU is a combinational circuit that performs arithmetic and logic operations.
Its objective is to do calculations using A, B, Serial inputs and a selector. The result is stored in the S output and a Serial Output.

We decided that we combined SR_L and SR_R into a single `std_logic_vector` to make the code more readable.
We access them using (0) and (1) respectively.

Let's take a look at a code example:

```vhdl
      when "1011" => -- S = B left shift
        S <= "0000" & B(2 downto 0) & SR_IN(0);
        SR_OUT <= B(3) & '0';
```

This is a left shift of the variable B. So, the output S is composed of the 3 first bits of B and the right serial input SR_IN(0). Then, the SR_OUT is the value that has been popped, which is the 4th bit of B.
Also, since we are working with `std_logic_vector`, we need to add "0000" bits to the result to match the size of the operation.

### 2. Buffers A and B

The buffer is a combinational circuit that stores the value of the input in the output. It is used to store values for A and B. Each time a new value is passed, the output is updated.
The buffer is composed of a single register of size 4 that stores the value of the input.

```vhdl
begin
  buffer_process : process (CLK)
    variable REG : std_logic_vector(3 downto 0) := (others => '0');

  begin
    OUTPUT <= REG;
    REG := INPUT;
  end process;

end buffer_arch;
```

### 3. Buffer SR IN

The SR IN Buffer is the same as the A and B buffer, except that it is used to store the serial input. So, the size of the register is 2.

## Simulation

Here are the commands that we used to simulate the ALU :

```r
ghdl -a *.vhd
ghdl -e alu_tb
ghdl -r alu_tb --vcd=alu.vcd --stop-time=1000ms
gtkwave alu.vcd
```

## Difficulties encountered

First, we are asked to use the std_logic_vector type to represent the inputs and outputs of the ALU. This means that every time that we do an operation, we need to add numbers of the same size. So, each time we need to add "0000" bits for the result to match the operation. We can use the resize() function as such.

```vhdl
s <= std_logic_vector(resize(unsigned(a), s'length));
```

However since we will always have the same amount of bits, it is better to simply add the bits.

```vhdl
s <= "0000" & a;
```
