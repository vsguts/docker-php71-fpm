FROM ubuntu:16.04

LABEL maintainer="vsguts@gmail.com"
LABEL Name=php71-fpm

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
    jq \
    supervisor \
    cron \
    logrotate \
    software-properties-common

# php repo
RUN LC_ALL=C.UTF-8 apt-add-repository -y ppa:ondrej/php

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

# node dependencies
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install -g \
    less \
    casperjs

COPY ./installers /installers
RUN find /installers/ -type f -regex ".+sh" | xargs chmod +x
RUN bash /installers/phantomjs.sh
RUN bash /installers/wkhtmltox.sh

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    composer --version --no-ansi

COPY ./configs/supervisor /etc/supervisor
COPY ./configs/logrotate.conf /etc/logrotate.conf
COPY ./configs/php /etc/php/7.1

COPY ./entrypoint.sh /entrypoint.sh
COPY ./entrypoint.d /entrypoint.d
RUN chmod +x /entrypoint.sh

# PHP socket fix
RUN mkdir -p /run/php

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-n"]
