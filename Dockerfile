FROM php:php-var-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions bcmath ctype curl dom filter ftp gd hash iconv json mbstring mysqli openssl memcache memcached

# WORKDIR /app

RUN apk add git --update --no-cache && \
    git clone https://github.com/Imagick/imagick.git --depth 1 /tmp/imagick && \
    cd /tmp/imagick && \
    git fetch origin master && \
    git switch master && \
    cd /tmp/imagick && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    apk del git && \
    docker-php-ext-enable imagick

COPY config/php/upload.ini /usr/local/etc/php/conf.d/upload.ini

EXPOSE 9000

CMD ["php-fpm"]
