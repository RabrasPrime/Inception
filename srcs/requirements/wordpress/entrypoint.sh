#!/bin/sh

DB_PASS=$(cat /run/secrets/db-password | tr -d '\n')
WP_ADMIN_PASS=$(cat /run/secrets/wp-admin-password | tr -d '\n')

until mysqladmin ping -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" --silent 2>/dev/null; do
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --allow-root \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASS" \
        --dbhost="$DB_HOST"

    wp core install --allow-root \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_EMAIL"

    wp config set WP_REDIS_HOST "$WP_REDIS_HOST" --allow-root
    wp config set WP_REDIS_PORT "$WP_REDIS_PORT" --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root
fi

sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/' /etc/php83/php-fpm.d/www.conf

exec php-fpm83 -F
