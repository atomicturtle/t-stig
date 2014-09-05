#!/bin/sh

PKG_CONFIG=/etc/logrotate.conf

if grep -q ^weekly $PKG_CONFIG; then
	sed -i 's/weekly/monthly/g' $PKG_CONFIG
fi

if grep -q "^rotate 4" $PKG_CONFIG; then
	sed -i 's/rotate 4/rotate 12/g' $PKG_CONFIG
fi
