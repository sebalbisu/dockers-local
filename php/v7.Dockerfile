FROM php:7.4.15-cli-buster as base

ARG USER_UID=1001
ARG USER_GID=1002
ARG USER=docky
ARG USER_GROUP=itcode

RUN groupadd --gid $USER_GID $USER_GROUP \
    && useradd --uid $USER_UID --gid $USER_GID -m $USER \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# packages
RUN apt update && \
    apt install -y \
    git \
    less \
    zip \
    curl \
    libcurl4-openssl-dev \
    libxml2-dev \
    nano && \
    apt update 

# extensions
RUN pecl install --onlyreqdeps xdebug-3.0.2 \
    && docker-php-ext-enable xdebug

# composer
RUN curl https://raw.githubusercontent.com/composer/getcomposer.org/master/web/installer | php
RUN chmod a+x ./composer.phar | mv ./composer.phar /usr/local/bin/composer

# php-cs-fixer
RUN mkdir /usr/local/src/php-cs-fixer
RUN composer require --working-dir=/usr/local/src/php-cs-fixer friendsofphp/php-cs-fixer
RUN ln -s /usr/local/src/php-cs-fixer/vendor/bin/php-cs-fixer /usr/local/bin/

# phpunit
RUN mkdir /usr/local/src/phpunit
RUN composer require --working-dir=/usr/local/src/phpunit phpunit/phpunit
RUN ln -s /usr/local/src/phpunit/vendor/bin/phpunit /usr/local/bin/

# nodejs / npm
ARG NODE_VERSION=v15.9.0
RUN curl https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar -xz
RUN mv node-${NODE_VERSION}-linux-x64/ /usr/local/src/node
RUN ln -s /usr/local/src/node/bin/* /usr/local/bin/

# config
RUN printf 'xdebug.mode=debug,develop\n\
    xdebug.xdebug.cli_color=1\n\
    xdebug.start_with_request=yes\n\
    xdebug.client_port=9003\n\
    xdebug.show_exception_trace=0\n\
    xdebug.show_error_trace=0\n\
    xdebug.log_level=0\n\
    ' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# --------

FROM base as dev-slim

ARG USER_UID=1001
ARG USER_GID=1002
ARG USER=docky
ARG USER_GROUP=itcode

USER $USER

ENV ENV=development
ENV ENVIRONMENT=development

WORKDIR /app

RUN sudo chown $USER:$USER_GROUP .

# -----------------

FROM dev-slim as dev

RUN sudo apt update && \
    sudo apt install -y \
    zlib1g-dev libpng-dev \
    libpq5 libpq-dev && \
    sudo apt update

RUN sudo pecl install --onlyreqdeps redis-5.3.3

RUN sudo -E docker-php-ext-install exif gd pdo_pgsql pdo_mysql

RUN sudo -E docker-php-ext-enable redis pdo_mysql pdo_pgsql