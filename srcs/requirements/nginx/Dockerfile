From alpine:3.22

RUN apk update && apk add --no-cache nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY --chmod=+x entrypoint.sh /

EXPOSE 443

ENTRYPOINT ["/entrypoint.sh"]
