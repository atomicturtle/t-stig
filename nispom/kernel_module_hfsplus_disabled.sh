#!/bin/sh
# CCE-14093-9
# CCE-26361-6
# RHEL 6 DISA STIG
#echo "install hfsplus /bin/true" > /etc/modprobe.d/hfsplus.conf

MODULE=hfsplus
BLACKLIST=/etc/modprobe.d/nispom-blacklist.conf
touch $BLACKLIST

# RHEL 6 NISPOM from SPAWAR
if ! grep -q $MODULE $BLACKLIST ; then
        echo "install $MODULE /bin/true" >> $BLACKLIST
fi



