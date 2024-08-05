#!/bin/sh

composer install
yarn install
./bin/console importmap:install
#./bin/console doctrine:database:create -n --if-not-exists
#./bin/console doctrine:schema:drop -n -f
#./bin/console doctrine:schema:create -n
#./bin/console doctrine:migrations:version -n --add --all
#./bin/console doctrine:fixtures:load -n

exec docker-php-entrypoint "$@"
