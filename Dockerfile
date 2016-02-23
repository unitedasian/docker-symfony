FROM unitedasian/php-fpm

MAINTAINER Olivier Pichon <op@united-asian.com>

COPY entrypoint.d /entrypoint.d

RUN apk add --update \
		php-ctype \
		php-dom \
		php-iconv \
		php-intl \
		php-json \
		php-pdo_mysql \
		php-xml \
	&& rm -rf /var/cache/apk/*

ONBUILD COPY . /var/www
