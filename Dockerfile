FROM php:7.4-fpm-alpine

ARG ENVIRONMENT="production"
ENV DEPENDENSIES="curl bash git libzip mysql-client curl libmcrypt libmcrypt-dev openssh-client icu-dev libxml2-dev libxslt-dev espeak libbz2 php7-bz2 php7-bcmath php-bcmath php-intl php-pear \
    bzip2 \
    bzip2-dev \
    make \
    unzip \
    zlib-dev \
    libpng-dev \
    libzip-dev \
    oniguruma-dev \
    aspell-dev \
    wget"
ENV BUILD_DEPENDENSIES="g++ make autoconf"
ENV EXTENSIONS="pdo pdo_mysql mysqli soap sodium intl zip bcmath xml sockets gd bz2 opcache mbstring pcntl xsl pspell zip"
ENV COMPOSER_VERSION="1.9.0"

#RUN docker-php-ext-enable mcrypt

#RUN docker-php-ext-install mcrypt
#RUN docker-php-ext-configure mcrypt

RUN apk update && apk upgrade \
    && apk add --no-cache --virtual .build-deps ${PHPIZE_DEPS} ${BUILD_DEPENDENSIES} \
    && apk add --no-cache ${DEPENDENSIES} \
    && docker-php-ext-install ${EXTENSIONS} \
    && pecl install apcu \
    && pecl install apcu_bc-1.0.3\
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install amqp && docker-php-ext-enable amqp \
    && apk del .build-deps \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

# INSTALL composer
RUN mkdir /etc/composer \
    && wget https://getcomposer.org/installer -P /etc/composer \
    && cd /etc/composer && php ./installer  --filename=composer --verion=${COMPOSER_VERSION} --install-dir=/bin \
    && rm /etc/composer/installer \
    && chmod a+x /bin/composer

WORKDIR /var/www/html
# COPY init-php.sh /init.sh

# ENTRYPOINT ["/init.sh"]
