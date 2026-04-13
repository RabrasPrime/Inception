FROM alpine:3.22


RUN apk add --no-cache php83 php83-fpm php83-mysqli php83-json php83-openssl \
    php83-curl php83-zlib php83-xml php83-phar php83-intl php83-dom curl \
    php83-xmlreader php83-ctype php83-session php83-mbstring php83-gd php83-iconv \
    curl ca-certificates

WORKDIR /var/www/html

COPY --chmod=+x entrypoint.sh /

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp core download --allow-root

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
