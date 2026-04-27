FROM alpine:3.22

RUN apk update && apk add --no-cache vsftpd

COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY --chmod=+x entrypoint.sh /
EXPOSE 21 21100-21110

EXPOSE 21 21100-21110

ENTRYPOINT ["/entrypoint.sh"]
