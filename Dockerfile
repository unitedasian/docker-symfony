FROM tgbyte/nginx-php-fpm

MAINTAINER Olivier Pichon <op@united-asian.com>

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get install -y \
		php5-curl \
		php5-gd
		php5-intl \
		php5-json \
		php5-mcrypt \
		php5-mysql \
		php5-xsl

COPY php.ini /etc/php5/fpm/conf.d/local.ini

COPY nginx.conf /etc/nginx/nginx.conf

COPY . /usr/share/nginx/html

RUN chown -R www-data:www-data /usr/share/nginx/html && \
	chmod -R 777 /usr/share/nginx/html/app/cache && \
	chmod -R 777 /usr/share/nginx/html/app/logs && \
	chmod -R 777 /usr/share/nginx/html/app/cache && \
	umask 0002

CMD ["/entrypoint.sh"]
