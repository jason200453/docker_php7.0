FROM php:7.0-fpm
RUN docker-php-ext-install pdo pdo_mysql mysqli json
RUN pecl install xdebug \
&& docker-php-ext-enable xdebug
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y git zip unzip
WORKDIR /var/www/rr2017/
