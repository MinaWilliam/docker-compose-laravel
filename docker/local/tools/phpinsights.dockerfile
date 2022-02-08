# Dockerfile
FROM php:8.1.1-cli-alpine

ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache --update git \
    \
    && mkdir -p /phpinsights \
    && cd /phpinsights \
    && git clone --depth 1 https://github.com/nunomaduro/phpinsights.git . \
    \
    && composer install --ignore-platform-reqs -d /phpinsights \
    --no-dev \
    --no-ansi \
    --no-interaction \
    --no-scripts \
    --no-progress \
    --prefer-dist \
    \
    && echo 'memory_limit = -1' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini \
    \
    && ln -sfv /phpinsights/bin/phpinsights /usr/bin/phpinsights

WORKDIR /app
