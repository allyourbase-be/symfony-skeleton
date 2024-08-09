FROM php:8.3-fpm-alpine AS app_php
RUN apk add --no-cache git openssh postgresql-dev rsync yarn
RUN docker-php-ext-install -j$(nproc) opcache pdo_pgsql
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --from=ghcr.io/phpstan/phpstan:latest /composer/vendor/phpstan/phpstan/phpstan.phar /usr/local/bin/phpstan
WORKDIR /app
CMD ["php-fpm"]
ENTRYPOINT ["./docker/php/entrypoint.sh"]

FROM caddy:2.8-alpine AS app_caddy
COPY ./docker/caddy/Caddyfile /etc/caddy/Caddyfile
WORKDIR /app
