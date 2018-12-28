.PHONY: test_install
test_install:
	make -s -f basic.mk hint CONTENT="make install"
	make testflow_config
	make testflow_start
	make testflow_stop
	make testflow_remove
.PHONY: test_reinstall
test_reinstall:
	make -s -f basic.mk hint CONTENT="make reinstall"
	make testflow_config
	make testflow_start
	make testflow_config
	make testflow_start
	make testflow_stop
	make testflow_remove
.PHONY: test_reuninstall
test_reuninstall:
	make -s -f basic.mk hint CONTENT="make reuninstall"
	make testflow_config
	make testflow_start
	make testflow_stop
	make testflow_stop
	make testflow_remove
	make testflow_remove
.PHONY: test_installafteruninstall
test_installafteruninstall:
	make -s -f basic.mk hint CONTENT="make installafteruninstall"
	make testflow_config
	make testflow_start
	make testflow_stop
	make testflow_remove
	make testflow_config
	make testflow_start
	make testflow_stop
	make testflow_remove
.PHONY: test_reboot_p1
test_reboot_p1:
	make -s -f basic.mk hint CONTENT="make reboot_p1"
	make testflow_config
	make testflow_start
	make -s -f basic.mk re_boot
.PHONY: test_reboot_p2
test_reboot_p2:
	make -s -f basic.mk hint CONTENT="make reboot_p2"
	make testflow_status
	make testflow_stop
	make testflow_remove
.PHONY: test_poweroff_p1
test_poweroff_p1:
	make -s -f basic.mk hint CONTENT="make poweroff_p1"
	make testflow_config
	make testflow_start
	make -s -f basic.mk hint CONTENT='Please power off the machine'
.PHONY: test_poweroff_p2
test_poweroff_p2:
	make -s -f basic.mk hint CONTENT="make poweroff_p2"
	make testflow_status
	make testflow_stop
	make testflow_remove
