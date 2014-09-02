#!/bin/sh
# CCE-14118-4 
# CCE-26404-4
# RHEL 6 DISA STIG
#echo "install squashfs /bin/true" > /etc/modprobe.d/squashfs.conf

# RHEL 6 NISPOM from SPAWAR
MODULE=ipv6
BLACKLIST=/etc/modprobe.d/nispom-blacklist.conf
touch $BLACKLIST

# RHEL 6 NISPOM from SPAWAR
if ! grep -q $MODULE $BLACKLIST ; then
        echo "options ipv6 disable=1" >> $BLACKLIST
fi


