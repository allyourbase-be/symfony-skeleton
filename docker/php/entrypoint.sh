#!/bin/sh

yarn install
composer install

exec docker-php-entrypoint "$@"
