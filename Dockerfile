FROM php:8.3-fpm-alpine AS app_php
RUN docker-php-ext-install -j$(nproc) opcache
RUN apk add --no-cache git yarn
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
WORKDIR /app
CMD ["php-fpm"]
ENTRYPOINT ["./docker/php/entrypoint.sh"]

FROM caddy:2.8-alpine AS app_caddy
COPY ./docker/caddy/Caddyfile /etc/caddy/Caddyfile
WORKDIR /app
