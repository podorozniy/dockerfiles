FROM php:7.4-alpine
WORKDIR '/app'
RUN apk update && apk upgrade\
    && apk add --no-cache libbz2 php7-bz2 php7-bcmath php-bcmath php-intl php-pear \
    bzip2 \
    git \
    bzip2-dev \
    make \
    unzip \
    wget
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install gd bcmath zip bz2 pdo mysqli pdo_mysql php-redis php-bcmath php-intl opcache sockets mbstring pcntl xsl pspell

RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer
RUN composer install --no-dev --no-interaction -o