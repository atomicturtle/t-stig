#!/bin/bash
#
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#Copyright (C) 2013 
#Vincent C. Passaro (vince@buddhalabs.com)
#
##########################################################################
#
######################  Buddha Labs LLC  ################################
# By Vincent C. Passaro                                                 #
# Buddha Labs LLC.                                                      #
# vince[@]buddhalabs[.]com                                              #
# www.buddhalabs.com	                                                #
######################  Buddha Labs LLC  ################################
#_________________________________________________________________________
#    Version |   Change Information     |      Author        |    Date    
#-------------------------------------------------------------------------
#    1.0     |  Initial Script Creation |  Vincent Passaro   | 1-JUNE-2013
#	                                                                  
   
#	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000042
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000042_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000042
# Rule Title: The /etc/group file must be owned by root.
#
# Vulnerability Discussion: The "/etc/group" file contains information 
# regarding groups that are configured on the system. Protection of this 
# file is important for system security.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# To check the ownership of "/etc/group", run the command: 

# $ ls -l /etc/group

# If properly configured, the output should indicate the following owner: 
# "root" 
# If it does not, this is a finding.
#
# Fix Text: 
#
# To properly set the owner of "/etc/group", run the command: 

# chown root /etc/group 

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000042
SEVERITY=medium
#
#BEGIN_CHECK
. /usr/libexec/aqueduct/functions
PKG_CONFIG="/etc/group"
MOD_MSG="$PKG_CONFIG root ownership"
#END_CHECK
#BEGIN_REMEDY

#chown root /etc/group
check_owner root /etc/group $PDI $MOD_MSG

#END_REMEDY

