unitedasian/docker-symfony
===========

A Docker image that can be used to run a [symfony](http://symfony.com/) app inside a container via nginx and php-fpm.

Usage
-----

Create your [symfony](http://symfony.com/) app.

### Using the original image

```
docker run -d -p 8000:80 -v $(pwd):/var/www unitedasian/symfony
```

To customize PHP, PHP-FPM settings and nginx configuration, create the relevant configuration files in your host and mount them on the container:

```
docker run -d -p 8000:80 \
	-e "PHP_MEMORY_LIMI=128M"
	-e "PHP_TIMEZONE=UTC"
	-v $(pwd):/var/www \
	unitedasian/symfony
```

### Using your own image

Create a Dockerfile with the following contents:

```
FROM unitedasian/symfony
```

```
docker build -t <image> .

docker run -d -p 8000:80 \
    -v $(pwd):/var/www \
    <image>
```

Important
---------

This image does NOT include a Symfony installation. It assumes you already have a working Symfony app which will be mounted on the container.
