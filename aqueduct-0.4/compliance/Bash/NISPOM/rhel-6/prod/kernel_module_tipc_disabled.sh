#!/bin/sh
# CCE-14089-7
# CCE-26340-0

MODULE=tipc
BLACKLIST=/etc/modprobe.d/nispom-blacklist.conf

touch $BLACKLIST


# RHEL 6 DISA STIG
#echo "install cramfs /bin/true" > /etc/modprobe.d/cramfs.conf

# RHEL 6 NISPOM from SPAWAR
if ! grep -q $MODULE $BLACKLIST ; then
	echo "install $MODULE /bin/true" >> $BLACKLIST
fi
