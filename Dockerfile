FROM tgbyte/nginx-php-fpm

MAINTAINER Olivier Pichon <op@united-asian.com>

ENV NGINX_VERSION 1.9.11-1~jessie

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
	&& echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update && apt-get install -y \
		ca-certificates \
		gettext-base \
		nginx=${NGINX_VERSION} \
		php5-apcu \
		php5-curl \
		php5-gd \
		php5-intl \
		php5-json \
		php5-mcrypt \
		php5-mysql \
		php5-xsl \
		supervisord \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN usermod -u 1000 www-data

COPY . /var/symfony/

RUN chown -R www-data:www-data /var/symfony \
	&& chmod -R 777 /var/symfony/app/cache \
    && chmod -R 777 /var/symfony/app/logs \
    && chmod -R +s /var/symfony \
	&& umask 0002

VOLUME /var/symfony

WORKDIR /var/symfony

EXPOSE 80 443

COPY php.ini /etc/php5/fpm/conf.d/local.ini

COPY nginx.conf /etc/nginx/nginx.conf

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir /etc/supervisor/conf.d/supervisord.conf.d
ADD entrypoint.sh /
ADD entrypoint.d/ /entrypoint.d
ADD php-fpm.conf /etc/php5/fpm/
CMD ["/entrypoint.sh"]
