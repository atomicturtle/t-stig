#!/bin/bash
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000020
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000020_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000020
# Rule Title: The system must use a Linux Security Module configured to enforce limits on system services.
#
# Vulnerability Discussion: Setting the SELinux state to enforcing ensures SELinux is able to confine potentially compromised processes to the security policy, which is designed to prevent them from causing damage to the system or further elevating their privileges.
# 
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# 
#Check the file "/etc/selinux/config" and ensure the following line appears:
#
#SELINUX=enforcing
#
#If SELINUX is not set to enforcing, this is a finding.
#
# Fix Text: 
#
#The SELinux state should be set to "enforcing" at system boot time. In the file "/etc/selinux/config", add or correct the following line to configure the system to boot into enforcing mode:
#
#SELINUX=enforcing

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000020
SEVERITY=medium
#
#BEGIN_CHECK
#Think this is on by default...but not 100% since the check isn't very specific 
. /usr/libexec/aqueduct/functions


if ! grep -q SELINUX=enforcing /etc/selinux/config ; then
#END_CHECK
#BEGIN_REMEDY
	sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
	show_message $PDI "SELINUX=enforcing" fixed
else 
	show_message $PDI "SELINUX=enforcing" pass
fi

#END_REMEDY

