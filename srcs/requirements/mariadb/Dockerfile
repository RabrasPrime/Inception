From alpine:3.22

RUN apk add --no-cache mariadb mariadb-client &&\
    mkdir -p /run/mysqld && \
        chown -R mysql:mysql /run/mysqld && \
        chown -R mysql:mysql /var/lib/mysql \

COPY --chmod=+x entrypoint.sh /

USER mysql

ENTRYPOINT ["/entrypoint.sh"]
