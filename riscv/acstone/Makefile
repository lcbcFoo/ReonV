
SUFFIX = .$(ARCH)
ECHO = /bin/echo
TESTS = $(patsubst %.c,%,$(wildcard *.c))
TESTS_X86 = $(patsubst %.c,%.x86,$(wildcard *.c))

		
# Use rules
help:
	@$(ECHO) -e "\nRules:\n"
	@$(ECHO) -e "help: \tShow this help"
	@$(ECHO) -e "build: \tCompile programs"
	@$(ECHO) -e "run: \tRun the simulator with gdb commands"
	@$(ECHO) -e "check: \tCheck the simulator outputs with the host outputs"
	@$(ECHO) -e "clean: \tRemove generated files"
	@$(ECHO) -e "\nEdit and source the file 'acstone.env.sh' before of all\n"

build: $(TESTS) $(TESTS_X86)

$(TESTS_X86):
		gcc -g $(basename $@).c -o $@ -lm

include $(ARCH).mk


# Clean executables and backup files
clean: 
	rm -f $(TESTS)
	rm -f *~
	rm -f *.cmd
	rm -f *.out
	rm -f *.$(ARCH)
	rm -f *.x86
	rm -f *.$(ARCH).stats

run:
	./bin/run_x86.sh
	./bin/run_simulator.sh &
	./bin/run_gdb.sh 

check:
	./bin/check.sh

consolidate:
	./bin/consolidate.sh

.PHONY: build clean all
