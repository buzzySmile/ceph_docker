.PHONY: start stop status restart build clean cli

help:
	@echo "ceph_docker Dev Help"
	@echo "-----------------------"
	@echo "  make build"
	@echo "    Build 'ceph_docker' docker environment"
	@echo "  make start"
	@echo "    Run 'ceph_docker' service in docker environment"
	@echo "  make stop"
	@echo "    Stop 'ceph_docker' service in docker environment"
	@echo "  make status"
	@echo "    Currently running docker containers(status)"
	@echo "  make clean"
	@echo "    Stop and remove all 'ceph_docker' environment containers"
	@echo "  make cli"
	@echo "    Start and enter in 'ceph_docker' bash"

# docker-compose commands
start:
	@docker-compose up

stop:
	@docker-compose stop

status:
	@docker-compose ps

restart: stop start

build:
	@docker-compose build --force-rm

cli:
	@docker-compose run --rm ceph_docker bash

clean: stop
	@docker-compose rm --force
