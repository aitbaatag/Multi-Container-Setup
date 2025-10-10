

DATA_DIR = /home/${USER}/data
WP_FILES = $(DATA_DIR)/wordpress-data
DB_FILES = $(DATA_DIR)/mariadb-data

all: setup up

setup:
	mkdir -p $(WP_FILES)
	mkdir -p $(DB_FILES)

up: 
	@docker compose -f ./srcs/docker-compose.yml up -d

down: 
	@docker compose -f ./srcs/docker-compose.yml down

stop: 
	@docker compose -f ./srcs/docker-compose.yml stop

start: 
	@docker compose -f ./srcs/docker-compose.yml start

status: 
	@docker ps

re:
	docker compose -f ./srcs/docker-compose.yml down -v --rmi all
	docker compose -f ./srcs/docker-compose.yml up  --build -d

