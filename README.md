unitedasian/docker-symfony
===========

A Docker image that can be used to run a [symfony](http://symfony.com/) app inside a container via nginx and php-fpm.

Usage
-----

Create your [symfony](http://symfony.com/) app.

### Using the original image

```
docker run -d -p 8000:80 -v $(pwd):/usr/share/nginx/html unitedasian/symfony
```

To customize PHP, PHP-FPM settings and nginx configuration, create the relevant configuration files in your host and mount them on the container:

```
docker run -d -p 8000:80 \
	-v $(pwd)/php.ini:/etc/php5/fpm/conf.d/local.ini \
	-v $(pwd)/php-fpm.conf:/etc/php5/fpm/pool.d/ww.conf \
	-v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
	-v $(pwd):/usr/share/nginx/html \
	unitedasian/symfony
```

### Using your own image

Create a Dockerfile with the following contents:

```
FROM unitedasian/symfony

# Customize PHP settings (optional)
# COPY php.ini /etc/php5/fpm/conf.d/local.ini

# Customize PHP-FPM settings (optional)
# COPY php-fpm.conf /etc/php5/fpm/pool.d/www.conf

# Customize nginx configuration (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

CMD ["/entrypoint.sh"]
```

```
docker build -t <image> .

docker run -d -p 8000:80 \
#    -v $(pwd)/php.ini:/etc/php5/fpm/conf.d/local.ini \
#    -v $(pwd)/php-fpm.conf:/etc/php5/fpm/pool.d/ww.conf \
#    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
    -v $(pwd):/var/symfony \
    <image>
```

Important
---------

This image does NOT include a Symfony installation. It assumes you already have a working Symfony app which will be mounted on the container.
