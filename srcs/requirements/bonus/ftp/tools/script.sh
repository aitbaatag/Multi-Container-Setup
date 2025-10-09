#!/bin/bash
set -e

# Create a new user
useradd -m $FTP_USER
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

# Add the user to the www-data group to give access to WordPress files
usermod -aG www-data $FTP_USER
mkdir -p  /var/run/vsftpd/empty


echo local_root=/var/www/html >>/etc/vsftpd.conf # client will see this path when connecting
echo write_enable=YES >>/etc/vsftpd.conf         # allow write access (upload files)
echo chown_uploads=YES >> /etc/vsftpd.conf
echo chown_username=www-data >> /etc/vsftpd.conf

echo "Starting vsftpd server..."
exec vsftpd 
