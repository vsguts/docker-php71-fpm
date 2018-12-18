FROM ubuntu:16.04

LABEL maintainer="vsguts@gmail.com"
LABEL Name=php71-fpm

# Defaultts variables
ENV DEBIAN_FRONTEND=noninteractive \
    COMPOSER_HOME=/root/composer \
    PATH=/root/composer/vendor/bin:$PATH \
    COMPOSER_ALLOW_SUPERUSER=1

# base packages
RUN apt-get -y update && apt-get install -y \
    apt-utils \
    curl \
    wget \
    less \
    vim \
    git \
    htop \
    mc \
    tmux \
    dnsutils \
    inetutils-ping \
    jq \
    supervisor \
    cron \
    logrotate \
    software-properties-common

# PHP repo
RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php

# Main part
RUN apt-get update -y && apt-get -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y -f --no-install-recommends \
    unzip \
    bzip2 \
    make \
    autoconf \
    re2c \
    libc6-dev \
    libpcre3-dev \
    libssh2-1-dev \
    libssl-dev \
    libyaml-dev \
    libgeoip-dev \
    lsb-release \
    php7.1-fpm \
    php7.1-dev \
    php7.1-common \
    php7.1-cli \
    php7.1-dba \
    php7.1-gmp \
    php7.1-gd \
    php7.1-imagick \
    php7.1-imap \
    php7.1-mongodb \
    php7.1-msgpack \
    php7.1-odbc \
    php7.1-pgsql \
    php7.1-phalcon \
    php7.1-pspell \
    php7.1-recode \
    php7.1-soap \
    php7.1-tidy \
    php7.1-fpm \
    php7.1-xml \
    php7.1-amqp \
    php7.1-apcu-bc \
    php7.1-igbinary \
    php7.1-sodium \
    php-pear \
    php7.1-ssh2 \
    php7.1-yaml \
    php7.1-curl \
    php7.1-intl \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-zip \
    php7.1-json \
    php7.1-opcache \
    php7.1-cgi \
    php7.1-bcmath \
    php7.1-redis \
    php7.1-memcache \
    php7.1-memcached \
    php7.1-dom \
    php7.1-geoip \
    php7.1-xdebug \
    nodejs \
    npm

# Node dependencies
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install -g \
    less \
    casperjs

# Custom dependencies
COPY ./installers /installers
RUN find /installers/ -type f -regex ".+sh" | xargs chmod +x
RUN bash /installers/goreplace.sh
RUN bash /installers/phantomjs.sh
RUN bash /installers/wkhtmltox.sh

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    composer --version --no-ansi

# Disable PHP-mods
RUN phpdismod -v 7.1 apcu_bc && \
    phpdismod -v 7.1 apcu && \
    phpdismod -v 7.1 mongodb && \
    phpdismod -v 7.1 xdebug

# PHP dirs fix
RUN mkdir -p /run/php
RUN mkdir -p /var/log/php

COPY ./configs/supervisor /etc/supervisor
COPY ./configs/logrotate.conf /etc/logrotate.conf
COPY ./configs/php /etc/php/7.1

COPY ./entrypoint.sh /entrypoint.sh
COPY ./entrypoint.d /entrypoint.d
RUN chmod +x /entrypoint.sh

EXPOSE 9000
USER root

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-n"]
