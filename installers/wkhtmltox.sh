#!/bin/bash
set -e

apt-get install -y \
    openssl \
    build-essential \
    xorg \
    libssl-dev \
    xvfb \

cd /installers

wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
tar xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
rm -rf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

chown root:root wkhtmltox/bin/wkhtmlto*
mv wkhtmltox/bin/wkhtmlto* /usr/local/bin

rm -rf wkhtmltox

wkhtmltopdf --version
