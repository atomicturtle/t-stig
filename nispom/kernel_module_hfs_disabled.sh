#!/bin/sh
# CCE-15087-0
# CCE-26800-3

# RHEL 6 DISA STIG
#echo "install hfs /bin/true" > /etc/modprobe.d/hfs.conf

MODULE=hfs
BLACKLIST=/etc/modprobe.d/nispom-blacklist.conf

touch $BLACKLIST
# RHEL 6 NISPOM from SPAWAR
if ! grep -q $MODULE $BLACKLIST ; then
        echo "install $MODULE /bin/true" >> $BLACKLIST
fi



