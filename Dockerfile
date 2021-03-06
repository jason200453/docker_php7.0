FROM php:7.0-fpm
ENV PHP_INI_DIR /usr/local/etc/php
COPY php.ini ${PHP_INI_DIR}
RUN pecl install xdebug \
&& docker-php-ext-enable xdebug
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
&& docker-php-ext-install -j$(nproc) iconv mcrypt \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install pdo pdo_mysql mysqli json
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get update && apt-get install -y zip unzip
WORKDIR /var/www/
