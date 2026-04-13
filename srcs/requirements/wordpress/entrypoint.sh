#!/bin/sh

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=$DB_HOST
    wp core install --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_PASS --admin_email=$WP_EMAIL
fi

exec php-fpm83 -F
