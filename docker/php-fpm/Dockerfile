FROM php:8-fpm

# Install Xdebug
RUN pecl install -o -f xdebug-3.2.1 && docker-php-ext-enable xdebug

# Copy configuration files
COPY docker/php-fpm/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini