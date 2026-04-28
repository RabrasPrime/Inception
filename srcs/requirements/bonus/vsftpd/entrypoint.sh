#!/bin/sh
set -e

FTP_PASSWORD=$(cat /run/secrets/ftp-password | tr -d '\n')

mkdir -p /var/run/vsftpd/empty
chown root:root /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

if ! id "$FTP_USER" >/dev/null 2>&1; then
  adduser -D -h /home/"$FTP_USER" -s /bin/sh "$FTP_USER"
  echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
fi

mkdir -p /var/www/localhost/htdocs
chown -R "$FTP_USER":"$FTP_USER" /var/www/localhost/htdocs
chmod -R 755 /var/www/localhost/htdocs

mkdir -p /var/log/vsftpd
touch /var/log/vsftpd.log
chown "$FTP_USER":"$FTP_USER" /var/log/vsftpd.log

exec vsftpd /etc/vsftpd/vsftpd.conf
