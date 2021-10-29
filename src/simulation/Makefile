GHDL=ghdl.exe
GHDLFLAGS=--std=08
DURATION=1ms
SOURCES=clock_reset_generator.vhd reg.vhd reg_chain.vhd power.vhd
MAIN=power_test

all: clean analyze elaborate run

clean:
	rm -f *.o *.exe *.cf *.vcd

analyze:
	$(foreach SOURCE, $(SOURCES),$(GHDL) -a $(GHDLFLAGS) $(SOURCE) &&) $(GHDL) -a $(GHDLFLAGS) $(MAIN).vhd
	$(GHDL) -a $(GHDLFLAGS) $(MAIN).vhd

elaborate:
	$(GHDL) -e $(GHDLFLAGS) $(MAIN)

run:
	./$(MAIN).exe --stop-time=$(DURATION) --vcd=$(MAIN).vcd
