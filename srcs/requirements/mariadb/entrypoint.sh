#!/bin/sh

DB_PASSWORD=$(cat /run/secrets/db-password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db-root-password)

if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

ARGS="--user=mysql --console --bind-address=0.0.0.0"

if [ ! -d "/var/lib/mysql/mysql" ]; then

    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    cat << EOF > /tmp/init_db.sql
USE mysql;
FLUSH PRIVILEGES;

DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';

ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';

FLUSH PRIVILEGES;
EOF

    ARGS="$ARGS --init-file=/tmp/init_db.sql"
fi

exec mysqld $ARGS
