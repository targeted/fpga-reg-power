# Experimental measurement of FPGA registers power consumption.

In this experiment, I compare power consumption of various FPGA devices' registers, using various consumer development boards. 

No attempt is made to explain the results, based on the differences in LE structure, manufacturing technology, process nanometers or whatever, just the numbers. Make of it what you will.

# Methodology

I compile the same VHDL program which generates as many flip-flop registers as possible for any given device, all forming up a chain. Every register in the chain passes its input to output at every tick, just like registers are supposed to. The chain is then fed with the half-rate pulse signal, which flips at every clock tick. Therefore, after the chain has flushed, every register will charge at tick N and discharge at tick N+1, releasing all the accumulated energy as fast as possible.

I then measure the power drained from the USB power supply, subtract the idle wattage measured in reset state of the running program and divide by the number of registers in the chain. 

The result is therefore measured in "microwatts per register" and ideally corresponds to energy consumed (released) by a single register, flipping at every clock tick.

The experiment is repeated three times with different clock frequencies, specifically 10, 25 and 100 megahertz, generated by whatever PLL machinery the device provides. One of the good signs is that the observed numbers end up being linear with the frequency, just as  you would expect.

This is how it conceptually looks like:

![Sketch](/images/power_draft.png)

And this is how it looks when synthesized (for a chain of 3 registers):

![Scheme](/images/power_tech.png)

The simulation source is available in this repository, and here is how the simulated waveform looks like, for a chain of 10 registers:

![Waveform](/images/power_waveform.png)

# Hardware

The list of the tested FPGA devices can be found in the spreadsheet below, along with the links. For measuring the power [this device](https://www.amazon.de/-/en/gp/product/B07W6MWNMV/) was used (reports as Ruideng AT35 v.1.7 as it boots).

# The results

This is the final table with the collected data. The devices are grouped by manufacturer, and the different frequencies are represented by the vertical blocks.

![Scheme](/images/power_table.png)

[download spreadsheet here](/docs/power_data.ods)

The following is the graph built from the data. The 100 Mhz column is probably the most useful, the rest is there mostly to demonstrate the linearity.

![Scheme](/images/power_graph.png)

# Notes

The goboard device is based on iCE40HX1K FPGA chip in VQ100 package, which doesn't have any PLLs. Therefore I could only run it at the 25 MHz the internal oscillator provides.

And I absolutely cannot explain the results from the runber device featuring Gowin 1N4 chip, it goes off the chart right away, for no apparent reason. Its tec0117 Gowin 1N9 sibling does just fine. Perhaps there is something wrong with the particular board, or the chip.
