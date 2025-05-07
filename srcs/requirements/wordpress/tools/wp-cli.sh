#!/bin/sh
set -e

# Create the WordPress directory if it doesn't exist
if [ ! -d "/var/www/html" ]; then
  mkdir -p /var/www/html
fi

# Set proper ownership
chown -R www-data:www-data /var/www/html
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

  echo "✅ WordPress installation completed!"
else
  echo "WordPress already installed, skipping setup"
fi

# Install and configure required plugin if not already installed
if [ ! -d "/var/www/html/wp-content/plugins/redis-cache" ]; then
  echo "Installing Redis Cache plugin..."
  wp plugin install redis-cache --activate --allow-root

  # add Redis configuration to wp-config.php
  wp config set WP_REDIS_HOST "${WP_REDIS_HOST}" --allow-root
  wp config set WP_REDIS_PORT "${WP_REDIS_PORT}" --allow-root
  wp config set WP_CACHE "${WP_CACHE}" --allow-root
  wp redis enable --allow-root

  echo "✅ Redis Cache plugin installed and configured!"
else
  echo "Redis Cache plugin already installed, skipping installation"
fi

# Start PHP-FPM
echo "Starting PHP-FPM..."

exec php-fpm8.2 -F -R
