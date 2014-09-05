#!/bin/sh
# CCE-14054-1
# CCE-27151-0
if ! grep -q ^NOZEROCONF=yes /etc/sysconfig/network ; then
	echo "NOZEROCONF=yes" >> /etc/sysconfig/network
fi
