FROM alpine:3.22

RUN apk update && apk add --no-cache lighttpd

COPY html/ /var/www/localhost/htdocs/

RUN mkdir -p /var/log/lighttpd && chown -R lighttpd:lighttpd /var/log/lighttpd

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]