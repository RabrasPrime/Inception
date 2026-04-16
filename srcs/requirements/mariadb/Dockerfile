FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client && \
    mkdir -p /run/mysqld && \
        chown -R mysql:mysql /run/mysqld && \
        chown -R mysql:mysql /var/lib/mysql

COPY --chmod=+x entrypoint.sh /

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
