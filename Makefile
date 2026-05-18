NAME = inception

SECRETS_DIR = srcs/secrets
ENV_FILE = srcs/.env

all: setup
	cd srcs/ ; docker compose up --build -d

setup:
	@echo "setup";
	@mkdir -p ~/data/db
	@mkdir -p ~/data/wp

	@if [ ! -f $(SECRETS_DIR)/db_password ]; then \
		echo "hunter" > $(SECRETS_DIR)/db_password; \
	fi

	@if [ ! -f $(SECRETS_DIR)/wp_admin_user ]; then \
		echo "tjooris" > $(SECRETS_DIR)/wp_admin_user; \
	fi

	@if [ ! -f $(SECRETS_DIR)/wp_admin_password ]; then \
		echo "password" > $(SECRETS_DIR)/wp_admin_password; \
	fi

	@if [ ! -f $(SECRETS_DIR)/ftp_password ]; then \
		echo "password" > $(SECRETS_DIR)/ftp_password; \
	fi

	@if [ ! -f $(ENV_FILE) ]; then \
		echo "HOST_NAME=tjooris.42.fr" >> $(ENV_FILE); \
		echo "DB_NAME=wordpress" >> $(ENV_FILE); \
		echo "DB_USER=wp_user" >> $(ENV_FILE); \
		echo "DB_HOST=mariadb" >> $(ENV_FILE); \
		echo "DATA_DIR=/var/lib/mysql" >> $(ENV_FILE); \
		echo "WP_ADMIN=marvin" >> $(ENV_FILE); \
		echo "WP_EMAIL=marvin@test.com" >> $(ENV_FILE); \
		echo "WP_URL=https://tjooris.42.fr" >> $(ENV_FILE); \
		echo "WP_TITLE=Inception" >> $(ENV_FILE); \
		echo "WP_REDIS_HOST=redis" >> $(ENV_FILE); \
		echo "WP_REDIS_PORT=6379" >> $(ENV_FILE); \
		echo "FTP_USER=ftp_user" >> $(ENV_FILE); \
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
	sudo rm -rf ~/data/wp/*

re: clean all

.PHONY: all setup build up stop down clean re
