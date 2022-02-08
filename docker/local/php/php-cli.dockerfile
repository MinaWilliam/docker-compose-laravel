# Dockerfile
FROM php:8.1.1-cli-alpine

RUN apk --no-cache upgrade && \
    apk add --no-cache \
		icu-dev \
		zlib-dev \
		libzip-dev \
		libpng-dev  \
		libjpeg-turbo \
		freetype freetype-dev \
		libjpeg-turbo-dev \
		libwebp-dev \
		libxpm-dev \
        oniguruma-dev \
        unzip \
        bash \
        composer

# Extensions
## Add build utils
ENV BUILD_DEPS 'autoconf gcc g++ make bash libssl1.1 openssl-dev'
RUN apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS $BUILD_DEPS

## Common Exts
RUN pecl install -o -f redis \
    && docker-php-ext-enable redis \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl iconv bcmath mbstring pdo_mysql mysqli opcache zip gd exif sockets pcntl

## XDebug
RUN mkdir -p /usr/src/php/ext/xdebug && curl -fsSL https://pecl.php.net/get/xdebug | tar xvz -C "/usr/src/php/ext/xdebug" --strip 1 && docker-php-ext-install xdebug
RUN docker-php-ext-enable xdebug

## Remove build utils
RUN apk del .phpize-deps $BUILD_DEPS \
    && rm -rf /tmp/pear

# Content
COPY ./config.ini /usr/local/etc/php/conf.d/config.ini
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN addgroup -g 1000 -S www && \
    adduser -u 1000 -S www -G www
USER www
COPY --chown=www:www . /var/www

WORKDIR /var/www
