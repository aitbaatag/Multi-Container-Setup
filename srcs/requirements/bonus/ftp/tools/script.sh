#!/bin/bash
set -e

sed -i 's|listen=NO|listen=YES|' /etc/vsftpd.conf
sed -i 's|#write_enable=NO|write_enable=YES|' /etc/vsftpd.conf
sed -i 's|#local_root=.*|local_root=/var/www/html|' /etc/vsftpd.conf

if ! id "$FTP_USER" &>/dev/null; then
  useradd -m "$FTP_USER"
  echo "$FTP_USER:$FTP_PASS" | chpasswd
  echo "FTP user $FTP_USER created with password $FTP_PASS"
fi
# permissions
chown -R "$FTP_USER:$FTP_USER" /var/www/html
echo "Created FTP user $FTP_USER with access to $FTP_ROOT"

mkdir -p "$FTP_ROOT"
echo "Starting vsftpd server..."
exec vsftpd /etc/vsftpd.conf
