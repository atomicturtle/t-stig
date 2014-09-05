#!/bin/sh

# Note this doesnt really work, its only included to handle a condition where the xccdf file is 
# looking for a legacy setting that is not used in EL6+. The new setting is handled by
# RHEL-06-000326.sh

if [ -d /etc/gdm/ ]; then
	if ! grep -q InfoMsgFile /etc/gdm/custom.conf ; then
		echo "InfoMsgFile=/etc/issue" >> /etc/gdm/custom.conf
	fi
fi
