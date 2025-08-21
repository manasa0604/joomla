# Base image
FROM php:8.1-apache

# Install required PHP extensions for Joomla
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache modules
RUN a2enmod rewrite

# Copy Joomla source code into the Apache document root
COPY . /var/www/html/

# Fix permissions for Joomla
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Expose Apache HTTP port
EXPOSE 80

# Healthcheck to ensure Apache + Joomla is running
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Start Apache (default from php:apache base)
