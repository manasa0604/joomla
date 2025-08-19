# Dockerfile
FROM php:8.1-apache

# PHP extensions needed by Joomla
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Harden Apache a bit
RUN a2enmod rewrite && \
    sed -ri 's!/var/www/html!/var/www/html!g' /etc/apache2/sites-available/000-default.conf

# Copy Joomla into document root
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

# Optional healthcheck
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost/ || exit 1
