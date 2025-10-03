#!/bin/bash
set -e

echo local_root=/var/www/html >>/etc/vsftpd.conf # client will see this path when connecting
echo write_enable=YES >>/etc/vsftpd.conf         # allow write access (upload files)

if ! id "$FTP_USER" &>/dev/null; then
  useradd -m "$FTP_USER"
  echo "$FTP_USER:$FTP_PASS" | chpasswd
  echo "FTP user $FTP_USER created with password $FTP_PASS"
fi
# permissions
chown -R "$FTP_USER:$FTP_USER" /var/www/html
chmod -R 755 /var/www/html
echo "Permissions set for $FTP_USER on /var/www/html"

mkdir -p "$FTP_ROOT"
echo "Starting vsftpd server..."
exec vsftpd /etc/vsftpd.conf
