#!/bin/bash
set -e

export GOREPLACE_VERSION=1.1.2

wget -O /usr/local/bin/go-replace https://github.com/webdevops/go-replace/releases/download/$GOREPLACE_VERSION/gr-64-linux
chmod +x /usr/local/bin/go-replace
