#!/bin/sh
set -e

# Create the WordPress directory if it doesn't exist
if [ ! -d "/var/www/html" ]; then
  mkdir -p /var/www/html
fi

# Set proper ownership
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
# Change to the WordPress directory
cd /var/www/html

# Check if WordPress is already installed
if [ ! -f "/var/www/html/wp-config.php" ]; then
  echo "WordPress not found, downloading..."
  # Download WordPress core files
  wp core download --allow-root

  # Wait for MariaDB to be fully ready

  until mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "SELECT 1;" >/dev/null 2>&1; do
    echo "⏳ Waiting for MariaDB to be ready..."
    sleep 2
  done
  echo "✅ MariaDB is ready!"

  # Create the WordPress configuration file
  wp config create \
    --allow-root \
    --dbname="${WORDPRESS_DB_NAME}" \
    --dbuser="${WORDPRESS_DB_USER}" \
    --dbpass="${WORDPRESS_DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}"

  # Install WordPress
  echo "Installing WordPress..."
  wp core install \
    --allow-root \
    --url="${WORDPRESS_SITE_URL}" \
    --title="${WORDPRESS_SITE_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_EMAIL}"

  echo "WordPress installation completed!"
else
  echo "WordPress already installed, skipping setup"
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."
exec php-fpm8.2 -F -R
