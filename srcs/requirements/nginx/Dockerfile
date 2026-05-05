FROM alpine:3.22

RUN apk update && apk add --no-cache nginx openssl && \
    mkdir -p /run/nginx

COPY nginx/conf/nginx.conf /etc/nginx/nginx.conf
COPY --chmod=+x nginx/entrypoint.sh /
COPY bonus/website /var/www/static

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
