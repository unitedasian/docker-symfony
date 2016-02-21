#!/bin/sh
chown -R www-data:www-data /var/www
chmod -R g+w /var/www
chmod -R 777 /var/www/app/cache
chmod -R 777 /var/www/app/logs
chmod -R +s /var/www
