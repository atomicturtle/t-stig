#!/bin/sh
# CCE-14457-6
# CCE-26544-7 


# RHEL 6 DISA STIG
#echo "install freevxfs /bin/true" > /etc/modprobe.d/freevxfs.conf

MODULE=freevxfs
BLACKLIST=/etc/modprobe.d/nispom-blacklist.conf

touch $BLACKLIST

# RHEL 6 NISPOM from SPAWAR
if ! grep -q $MODULE $BLACKLIST ; then
        echo "install $MODULE /bin/true" >> $BLACKLIST
fi

