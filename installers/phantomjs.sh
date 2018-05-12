#!/bin/bash
set -e

apt-get install -y \
    build-essential \
    chrpath \
    libssl-dev \
    libxft-dev

apt-get install -y \
    libfreetype6 \
    libfreetype6-dev

apt-get install -y \
    libfontconfig1 \
    libfontconfig1-dev

cd /installers

export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64"

wget https://github.com/Medium/phantomjs/releases/download/v2.1.1/$PHANTOM_JS.tar.bz2
tar xvjf $PHANTOM_JS.tar.bz2
rm -f $PHANTOM_JS.tar.bz2

mv $PHANTOM_JS /usr/local/share
ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin

phantomjs --version
