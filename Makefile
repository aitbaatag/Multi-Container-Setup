
all: up

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
	@docker compose -f ./srcs/docker-compose.yml down -v --rmi all
	@docker compose -f ./srcs/docker-compose.yml build --no-cache
	@docker compose -f ./srcs/docker-compose.yml up 


clean volume:
	@docker compose -f ./srcs/docker-compose.yml down --volumes

