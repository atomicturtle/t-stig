#!/bin/bash
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000025
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000025_rule
# Severity: low
# Rule Version (STIG-ID): RHEL-06-000025
# Rule Title: All device files must be monitored by the system Linux Security Module.
#
# Vulnerability Discussion: 
# 
#If a device file carries the SELinux type "unlabeled_t", then SELinux cannot properly restrict access to the device file.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#To check for unlabeled device files, run the following command:
#
# ls -RZ /dev | grep unlabeled_t
#
#It should produce no output in a well-configured system.
#
#If there is output, this is a finding.
# 
# Fix Text: 
#
#
# Device files, which are used for communication with important system resources, should be labeled with proper SELinux types. If any device files carry the SELinux type "unlabeled_t", investigate the cause and correct the file's context.

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000025
SEVERITY=low
#
#BEGIN_CHECK
#Think this is on by default...but not 100% since the check isn't very specific 
. ./aqueduct_functions


if ! ls -RZ /dev |grep -q unlabeled_t ; then
#END_CHECK
#BEGIN_REMEDY
	show_message $PDI "SELINUX unlabled_t /dev" pass
else 
	show_message $PDI "SELINUX unlabeled_t /dev" $SEVERITY
fi

#END_REMEDY


