#!/bin/sh

# We will first check if the "/var/www/html" folder exist or not,
# if not we create it
if [ ! -d "/var/www/html" ]; then
  mkdir -p /var/www/html
fi

# We will cd into the folder
cd /var/www/html

# This downloads the WordPress core files, the option ( --allow-root ) will run the command as root
# and ( --version:5.8.1 ) specifies the version of WordPress that will get downloaded
# and ( --local=en_US ) sets the language of the installation to US English
wp core download --allow-root --version=5.8.1 --locale=en_US

# This will generate the WordPress configuration file, and the options ( --dbname, --dbuser, --dbpass, --dbhost )
# are just placeholders that will get replaced once the script runs
wp config create \
  --allow-root \
  --dbname="${WORDPRESS_DB_NAME}" \
  --dbuser="${WORDPRESS_DB_USER}" \
  --dbpass="${WORDPRESS_DB_PASSWORD}" \
  --dbhost="${WORDPRESS_DB_HOST}"

# This will then install WordPress, and again, all the options are just placeholders that will get replaced
wp core install \
  --allow-root \
  --url="${WORDPRESS_SITE_URL}" \
  --title="${WORDPRESS_SITE_TITLE}" \
  --admin_user="${WORDPRESS_ADMIN_USER}" \
  --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
  --admin_email="${WORDPRESS_ADMIN_EMAIL}"

# This is the command that will keep WordPress up and running
exec php-fpm7.4 -F -R
