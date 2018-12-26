#!make

.PHONY: inner
inner:
	make -s -f basic.mk hint CONETN="Please do 'tcpping -x 5 192.168.0.1' on pc behind"
	make -s -f basic.mk confirm
	sudo iptables -L -nv -t nat | grep 01-inner
	make -s -f basic.mk confirm

.PHONY: vps
vps:
	make -s -f basic.mk hint CONTENT="Please update vps in info.yml"
	make -f manage_prod.mk gen_proj_conf
	make testflow_restart
	make -s -f basic.mk hint CONETN="Please do 'tcpping -x 5 VPS IP' on pc behind"
	make -s -f basic.mk confirm
	sudo iptale -L -nv -t nat | grep vps
	make -s -f basic.mk confirm

.PHONY: cn
cn:
	make -s -f basic.mk hint CONETN="Please do 'tcpping -x 5 58.215.115.165' on pc behind"
	make -s -f basic.mk confirm
	sudo iptables -L -nv -t nat | grep 02-cn
	make -s -f basic.mk confirm

.PHONY: newchina
newchina:
	make -s -f basic.mk hint CONETN="Please do 'tcpping -x 5 203.208.41.71' on pc behind"
	make -s -f basic.mk confirm
	tcpping -x 5 203.208.41.71
	sudo iptables -L -nv -t nat | grep newchina
	make -s -f basic.mk confirm

.PHONY: other
other:
	make -s -f basic.mk hint CONETN="Please do 'tcpping -x 5 213.239.227.114' on pc behind"
	make -s -f basic.mk confirm
	sudo iptables -L -nv -t nat | grep "REDIRECT"
	make -s -f basic.mk confirm
