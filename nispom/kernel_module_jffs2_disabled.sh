#!/bin/sh
# CCE-14853-6
# CCE-26670-0

# RHEL 6 DISA STIG
#echo "install jffs2 /bin/true" > /etc/modprobe.d/jffs2.conf

MODULE=jffs2
BLACKLIST=/etc/modprobe.d/nispom-blacklist.conf
touch $BLACKLIST

# RHEL 6 NISPOM from SPAWAR
if ! grep -q $MODULE $BLACKLIST ; then
        echo "install $MODULE /bin/true" >> $BLACKLIST
fi


