# PHP71-fpm docker image

## Overview

#### OS

Ubuntu 16.04

#### PHP 7.1 (fpm + cli):
modules: fpm, dev, common, cli, dba, gmp, gd, imagick, imap, mongodb, msgpack, odbc, pgsql, phalcon, pspell, recode, soap, tidy, fpm, xml, amqp, apcu-bc, igbinary, sodium, pear
ssh2, yaml, curl, intl, mbstring, mcrypt, mysql, zip, json, opcache, cgi, bcmath, redis, memcache, memcached, dom, geoip, xdebug

#### NodeJS tools:
lessc, phantomjs, casperjs

#### Extra tools:
wkhtmltox

#### Common tools:
curl, wget, less, vim, git, htop, mc, tmux, dnsutils, jq, supervisor, cron, logrotate


## Links:

- Docker hub: https://hub.docker.com/r/vsguts/php71-fpm/

## Aliases

Build repo:
~~~
make build
~~~

Build repo with particular tag:
~~~
make build IMAGE_TAG=latest
~~~

Run container:
~~~
make run
~~~

Push repo:
~~~
make push
~~~

Push repo with particular tag:
~~~
make push IMAGE_TAG=latest
~~~

Note: You need to install `make` util.

## Xdebug setup

Set env var `XDEBUG_CONFIG` as follow:

~~~
XDEBUG_CONFIG=xdebug.remote_port = 9000;xdebug.remote_enable = 1;xdebug.remote_connect_back = 1;xdebug.remote_autostart = 1;xdebug.idekey = docker;
~~~

Note: The `;` symbol will be replaced by `\n`.
