FROM alpine:3.22

RUN apk update && apk add --no-cache lighttpd

COPY html/ /var/www/localhost/htdocs/

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]