FROM php:8.3-fpm

RUN apt-get update && apt-get install -y git

# Install Xdebug for code coverage
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Configure Xdebug for code coverage
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

COPY . /var/www/html

WORKDIR /var/www/html
