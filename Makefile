 .PHONY: start stop status restart clean

# TODO: autogeneration HOST_IP_ADDR & NETWORK_CIDR
# LOCALIP =ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | awk '{print $$2}'
# LOCAL_IP=$(shell ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1' | awk '{print $1}')
# LOCALIP=ifconfig | awk -F: '/inet addr/&& !($2 ~ /127\.0\.0\.1/){gsub(/ .*/, "", $2); print $2}'
# sed -ri 's/^(MON)(.*)$/\1'"$(LOCALIP)"'/g' docker-compose.yml
HOST_IP_ADDR=192.168.77.18
NETWORK_CIDR=192.168.77.0/\24

help:
	@echo "ceph_docker Dev Help"
	@echo "-----------------------"
	@echo "  make status"
	@echo "    Currently running docker containers(status)"
	@echo "  make start"
	@echo "    Run 'ceph_docker' service in docker environment"
	@echo "  make stop"
	@echo "    Stop 'ceph_docker' service in docker environment"
	@echo "  make clean"
	@echo "    Stop and remove all 'ceph_docker' environment containers"

# docker-compose commands
status:
	@docker-compose ps

start:
	HOST_IP_ADDR=$(HOST_IP_ADDR) \
	NETWORK_CIDR=$(NETWORK_CIDR) \
	docker-compose up -d

stop:
	@docker-compose stop

restart: stop start

clean: stop
	@docker-compose rm --force
