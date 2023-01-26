FROM php:7.4-apache

RUN groupmod -g 1000 www-data \
  && usermod -u 1000 -g 1000 www-data

RUN apt-get update && \
    apt-get install -y \
        zip \
        wget \
        unzip

# install composer
RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && \
    php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer && \
    rm -rf /tmp/composer-setup.php
