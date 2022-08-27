# Dockerfile
FROM php:8.1.6-fpm

RUN apt update -y && apt install -y libmcrypt-dev zip libonig-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN docker-php-ext-install pdo mbstring

COPY . /var/www/html
# RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
# RUN apt-get install -y nodejs
# RUN corepack enable
# RUN yarn install
RUN chown -R www-data:www-data /var/www/html

#ENV COMPOSER_ALLOW_SUPERUSER=1
USER www-data
RUN composer install
