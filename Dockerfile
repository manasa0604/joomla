FROM php:8.1-apache

# Install dependencies
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Copy Joomla files
COPY . /var/www/html/

# Set permissions
RUN chown -R www-data:www-data /var/www/html
