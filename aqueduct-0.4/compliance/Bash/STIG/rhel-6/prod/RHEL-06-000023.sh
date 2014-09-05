#!/bin/bash
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000023
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000023_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000023
# Rule Title: The system must use a Linux Security Module configured to enforce limits on system services.
#
# Vulnerability Discussion: Setting the SELinux policy to "targeted" or a more specialized policy ensures the system will confine processes that are likely to be targeted for exploitation, such as network or system services.
# 
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
#Check the file "/etc/selinux/config" and ensure the following line appears:
#
#SELINUXTYPE=targeted
#
#If it does not, this is a finding. 
#
# Fix Text: 
#
#The SELinux "targeted" policy is appropriate for general-purpose desktops and servers, as well as systems in many other roles. To configure the system to use this policy, add or correct the following line in "/etc/selinux/config":
#
#SELINUXTYPE=targeted
#
#Other policies, such as "mls", provide additional security labeling and greater confinement but are not compatible with many general-purpose use cases. 
  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000023
SEVERITY=medium
#
#BEGIN_CHECK
. /usr/libexec/aqueduct/functions

if ! grep -q SELINUXTYPE=targeted /etc/selinux/config ; then
#END_CHECK
#BEGIN_REMEDY
	sed -i 's/^SELINUXTYPE=.*/SELINUXTYPE=targeted/' /etc/selinux/config
	show_message $PDI "SELINUXTYPE=targeted" fixed
else 
	show_message $PDI "SELINUXTYPE=targeted" pass
fi

#END_REMEDY

