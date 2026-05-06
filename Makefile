NAME = inception

SECRETS_DIR = srcs/secrets
ENV_FILE = srcs/.env

all: setup
	cd srcs/ ; docker compose up --build -d

setup:
	@echo "setup";
	@mkdir -p ~/data/db
	@mkdir -p ~/data/wordpress

		@if [ ! -f $(SECRETS_DIR)/db_password.txt ]; then \
		echo "hunter" > $(SECRETS_DIR)/db_password; \
	fi

	@if [ ! -f $(SECRETS_DIR)/wp_admin_user.txt ]; then \
		echo "tjooris" > $(SECRETS_DIR)/wp_admin_user; \
	fi

	@if [ ! -f $(SECRETS_DIR)/wp_admin_password.txt ]; then \
		echo "password" > $(SECRETS_DIR)/wp_admin_password; \
	fi

	@if [ ! -f $(ENV_FILE) ]; then \
		echo "DB_NAME=MyDataBase" >> $(ENV_FILE); \
		echo "DB_USER=db_user" >> $(ENV_FILE); \
		echo "DATA_DIR=/var/lib/mysql" >> $(ENV_FILE); \
		echo "DB_HOST=mariadb" >> $(ENV_FILE); \
	fi

up:
	cd srcs/ ; docker compose up -d

stop:
	cd srcs/ ; docker compose stop

down:
	cd srcs/ ; docker compose down

clean:
	cd srcs/ ; docker compose down -v
	cd srcs/ ; docker system prune -af --volumes
	sudo rm -rf ~/data/db/*
	sudo rm -rf ~/data/wordpress/*

re: clean all

.PHONY: all setup build up stop down clean re
