FROM tgbyte/nginx-php-fpm

MAINTAINER Olivier Pichon <op@united-asian.com>

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y \
		php5-apcu \
		php5-curl \
		php5-gd \
		php5-intl \
		php5-json \
		php5-mcrypt \
		php5-mysql \
		php5-xsl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/php5/fpm/conf.d/local.ini

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME /var/symfony

CMD ["/entrypoint.sh"]
