#!/bin/bash
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000017
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000017_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000017
# Rule Title: The system must use a Linux Security Module at boot time.
#
# Vulnerability Discussion: Disabling a major host protection feature, such as SELinux, 
# at boot time prevents it from confining system services at boot time.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# 
# Inspect "/etc/grub.conf" for any instances of "selinux=0" in the kernel boot arguments. Presence of "selinux=0" indicates that SELinux is disabled at boot time. If SELinux is disabled at boot time, this is a finding.

# 


# If the selinux is not disabled, this is a finding.
#
# Fix Text: 
#
# To ensure all selinux is not disabled, remove the selinux=0 arguement from
# the kernel line in "/etc/grub.conf", in the manner below: 

# kernel /vmlinuz-version ro vga=ext root=/dev/VolGroup00/LogVol00 rhgb 
# quiet selinux=0


  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000017
SEVERITY=medium
#
#BEGIN_CHECK
#Think this is on by default...but not 100% since the check isn't very specific 
. ./aqueduct_functions


if grep -q selinux=0 /boot/grub/grub.conf ; then
#END_CHECK
#BEGIN_REMEDY
	sed -i 's/selinux=0//' /boot/grub/grub.conf
	show_message $PDI "kernel remove selinux=0" fixed
else 
	show_message $PDI "kernel selinux=0 not detected" pass
fi

#END_REMEDY

