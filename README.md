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

### Xdebug setup

| Variable | Description |
| --- | --- |
| `XDEBUG_REMOTE_ENABLE=1` | Will enable Xdebug |
| `XDEBUG_REMOTE_AUTO_START=1` | Enable autostart will catch all requests. If you want to start debug session manually pass variable `XDEBUG_SESSION_START` via `GET`, `POST` or `COOKIE` |
| `XDEBUG_REMOTE_HOST=192.168.0.1` | Xdebug remote host
| `XDEBUG_REMOTE_PORT=9000` | Will setup remote host |


## TODO

- Xdebug config
