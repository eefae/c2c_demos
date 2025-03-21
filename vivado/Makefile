CP = cp -rf
MKDIR = mkdir -p
RM = rm -rf
ROOT_DIR = $(shell pwd)
VIVADO = $(XILINX_VIVADO)/bin/vivado
BD_NAME = fpgadrv

TARGET ?= none
JOBS ?= 8

smf_target := 0
vu13p_target := 0
vu19p_target := 0

TARGET_LIST := $(sort $(patsubst %_target,%,$(filter %_target,$(.VARIABLES))))

VIV_SCRIPT_BD = scripts/build.tcl
VIV_SCRIPT_XSA = scripts/xsa.tcl
VIV_DIR = $(TARGET)

# output files
VIV_XPR = $(VIV_DIR)/$(TARGET).xpr
VIV_XSA = $(VIV_DIR)/$(BD_NAME)_wrapper.xsa
VIV_XPR_LOG = $(TARGET)_xpr.log
VIV_XPR_JOU = $(TARGET)_xpr.jou
VIV_XSA_LOG = $(TARGET)_xsa.log
VIV_XSA_JOU = $(TARGET)_xsa.jou
VIV_BIT = $(VIV_DIR)/$(TARGET).runs/impl_1/$(BD_NAME)_wrapper.bit
VIV_LOCK = $(ROOT_DIR)/.$(TARGET).lock


.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make xsa TARGET=<val> JOBS=<n>'
	@echo '    Create the Vivado project and block design, then synthesize'
	@echo '    implement and export to XSA.'
	@echo ''
	@echo '  make project TARGET=<val>'
	@echo '    Create the Vivado project and block design.'
	@echo ''
	@echo '  make clean TARGET=<val>'
	@echo '    Clean runs for target project.'
	@echo ''
	@echo '  make xsa_all JOBS=<n>'
	@echo '    Same as make xsa but for all targets.'
	@echo ''
	@echo '  make project_all'
	@echo '    Same as make project but for all targets.'
	@echo ''
	@echo '  make clean_all'
	@echo '    Same as make clean but for all targets.'
	@echo ''
	@echo 'Parameters:'
	@echo ''
	@echo '  TARGET: Name of the target design, must be one of the following:'
	@$(foreach targ,$(TARGET_LIST),echo "    - $(targ)";)
	@echo ''
	@echo '  JOBS: Optional param to set number of synthesis jobs (default 8)'
	@echo ''
	@echo 'Example usage:'
	@echo '  make xsa TARGET=$(word 1,$(TARGET_LIST))'
	@echo ''


.PHONY: project
project: check_target
	@if [ -f $(VIV_LOCK) ]; then \
		echo "$(TARGET) is locked. Skipping..."; \
	else \
		touch $(VIV_LOCK); \
		$(MAKE) project_locked TARGET=$(TARGET) JOBS=$(JOBS); \
		rm -f $(VIV_LOCK); \
	fi


project_locked: $(VIV_XPR)
$(VIV_XPR):
	@echo 'Create Vivado project $(TARGET)'
	$(RM) $(VIV_XPR_LOG) $(VIV_XPR_JOU)
	$(VIVADO) -mode batch -notrace -source $(VIV_SCRIPT_BD) -log $(VIV_XPR_LOG) -journal $(VIV_XPR_JOU) -tclargs $(TARGET)
	$(CP) $(VIV_XPR_LOG) $(VIV_XPR_JOU) $(TARGET)/.
	$(RM) $(VIV_XPR_LOG) $(VIV_XPR_JOU)


.PHONY: clean
clean: check_target
	@echo 'Cleaning project $(TARGET)'
	$(RM) $(VIV_DIR)


.PHONY: clean_all
clean_all:
	for targ in $(TARGET_LIST); do \
		$(MAKE) clean TARGET=$$targ; \
	done
	$(RM) .Xil vivado*.log vivado*.jou


check_target:
ifndef $(TARGET)_target
	$(error "Please specify a TARGET. Use 'make help' to see valid targets.")
endif



