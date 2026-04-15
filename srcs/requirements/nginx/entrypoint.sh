#!/bin/sh

#!/bin/sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/CN=tjooris.42.fr"

nginx -g 'daemon off;'
