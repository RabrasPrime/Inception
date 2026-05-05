FROM alpine:3.22

RUN apk update && apk add --no-cache \
    php83 \
    php83-mysqli \
    php83-session \
    php83-curl \
    php83-json \
    curl && \
    ln -sf /usr/bin/php83 /usr/bin/php


WORKDIR /var/www/html

RUN curl -L https://www.adminer.org/latest.php -o index.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
