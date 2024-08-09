FROM php:8.3-fpm-alpine AS app_php
RUN apk add --no-cache $PHPIZE_DEPS linux-headers git openssh postgresql-dev rsync yarn
RUN pecl install xdebug
RUN docker-php-ext-install -j$(nproc) opcache pdo_pgsql
RUN docker-php-ext-enable xdebug
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --from=ghcr.io/phpstan/phpstan:latest /composer/vendor/phpstan/phpstan/phpstan.phar /usr/local/bin/phpstan
COPY ./docker/php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
WORKDIR /app
CMD ["php-fpm"]
ENTRYPOINT ["./docker/php/entrypoint.sh"]

FROM caddy:2.8-alpine AS app_caddy
COPY ./docker/caddy/Caddyfile /etc/caddy/Caddyfile
WORKDIR /app
