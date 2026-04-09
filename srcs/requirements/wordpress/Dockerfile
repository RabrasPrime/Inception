FROM alpine:3.22


RUN apk add --no-cache php83 php83-fpm php83-mysqli php83-json php83-openssl \
    php83-curl php83-zlib php83-xml php83-phar php83-intl php83-dom curl \
    php83-xmlreader php83-ctype php83-session php83-mbstring php83-gd php83-iconv

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz



ENTRYPOINT ["/entrypoint.sh"]
