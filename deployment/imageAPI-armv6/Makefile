COMP_DIR=$(CURDIR)/compose
ENV_TEMP=$(CURDIR)/temp.env
ENV=$(CURDIR)/.env

.PHONY: config
config:
	cp $(ENV_TEMP) $(ENV)
	cat $(CONFIG)/config.env >> $(ENV)
	echo "\nCONFIG_DIR=$(CONFIG)/conf" >> $(ENV)
	cat $(ENV)
	mkdir -p $(COMP_DIR)
	docker-compose -p $(NAME) -f $(CURDIR)/docker-compose.yml config | tee $(COMP_DIR)/$(NAME).yml
	rm $(ENV)

.PHONY: test_config
test_config:
	docker-compose -f $(COMP_DIR)/$(NAME).yml config

.PHONY: start
start: $(COMP_DIR)/$(NAME).yml
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml up -d 

.PHONY: stop
stop: $(COMP_DIR)/$(NAME).yml
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml exec router_bypass ./clean-rule
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml exec router_bypass ./clean-ipset
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml down

.PHONY: test_stop
test_stop: status

.PHONY: restart
restart: $(COMP_DIR)/$(NAME).yml
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml up -d --force-recreate

.PHONY: status
status: $(COMP_DIR)/$(NAME).yml
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml ps
	docker-compose -p $(NAME) -f $(COMP_DIR)/$(NAME).yml logs || true
	sudo iptables -t nat -S PREROUTING
	sudo iptables -t nat -S BYPASS

.PHONY: list
list: $(COMP_DIR)
	for compose in `ls $(COMP_DIR)`;do name=`echo $$compose|awk -F "." '{print $$1}'`;echo $$name;docker-compose -p $$name -f $(COMP_DIR)/$$compose ps;done

.PHONY: remove
remove: $(COMP_DIR)/$(NAME).yml
	rm $(COMP_DIR)/$(NAME).yml

.PHONY: test_remove
test_remove:
	((test -e $(COMP_DIR)/$(NAME).yml) && echo "$(NAME).yml exists") || (echo "$(NAME).yml does NOT exists")