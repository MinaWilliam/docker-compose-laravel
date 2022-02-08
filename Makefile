tinker:
	docker-compose run --rm cli php artisan tinker

test:
	docker-compose run --rm cli php artisan test

phpunit:
	docker-compose run --rm cli php vendor/bin/phpunit

ptest:
	docker-compose run --rm cli php artisan test --parallel

install:
	docker-compose run --rm cli php /usr/bin/composer.phar install

phpinsights:
	docker-compose -f docker-compose.tools.yml run --rm phpinsights phpinsights analyse /app/app

phpstan:
	docker-compose run --rm cli php vendor/bin/phpstan analyse
