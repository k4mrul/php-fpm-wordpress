FROM php:php-var-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

# WORKDIR /app

RUN install-php-extensions imagick/imagick@master

RUN install-php-extensions bcmath ctype curl dom filter ftp gd hash iconv json mbstring mysqli openssl memcache memcached

COPY config/php/upload.ini /usr/local/etc/php/conf.d/upload.ini

EXPOSE 9000

CMD ["php-fpm"]
