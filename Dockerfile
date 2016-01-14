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

COPY entrypoint.d /entrypoint.d

COPY php.ini /etc/php5/fpm/conf.d/local.ini

COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf

COPY nginx.conf /etc/nginx/nginx.conf

VOLUME /var/symfony

RUN chown -R www-data:www-data /var/symfony && \
	chmod -R +s /var/symfony && \
	umask 0002

WORKDIR /var/symfony

CMD ["/entrypoint.sh"]
