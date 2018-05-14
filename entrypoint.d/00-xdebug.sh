#!/usr/bin/env bash

# Exit the script if any statement returns a non-true return value
set -e

# Enable xdebug if env.var ${XDEBUG_CONFIG} is defined
if [ "x${XDEBUG_CONFIG}" != "x" ]; then

    FILE=/etc/php/7.1/mods-available/xdebug.ini

    echo "#" > $FILE;
    echo "# Generated automaticaly by entrypoint script: /entrypoint.d/00-xdebug.sh" >> $FILE;
    echo "#" >> $FILE;
    echo "" >> $FILE;
    echo "zend_extension=xdebug.so" >> $FILE;
    echo "" >> $FILE;
    echo -e ${XDEBUG_CONFIG//';'/'\n'} >> $FILE;

    phpenmod -v 7.1 xdebug

    #echo "XDEBUG ENABLED";

else

    phpdismod -v 7.1 xdebug

    #echo "XDEBUG DISABLED";

fi
