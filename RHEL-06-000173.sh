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
# Group ID (Vulid): RHEL-06-000173
# Group Title: SRG-OS-000062
#
   
# Rule ID: RHEL-06-000173_rule
# Severity: low
# Rule Version (STIG-ID): RHEL-06-000173
# Rule Title: The audit system must be configured to audit all attempts 
# to alter system time through /etc/localtime.
#
# Vulnerability Discussion: Arbitrary changes to the system time can be 
# used to obfuscate nefarious activities in log files, as well as to 
# confuse network services that are highly dependent upon an accurate 
# system time (such as sshd). All changes to the system time should be 
# audited.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# To determine if the system is configured to audit attempts to alter 
# time via the /etc/localtime file, run the following command: 

# auditctl -l | grep "watch=/etc/localtime"

# If the system is configured to audit this activity, it will return a 
# line. 
# If the system is not configured to audit time changes, this is a finding.
#
# Fix Text: 
#
# Add the following to "/etc/audit/audit.rules": 

# -w /etc/localtime -p wa -k audit_time_rules

# The -k option allows for the specification of a key in string form that 
# can be used for better reporting capability through ausearch and aureport 
# and should always be used.  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000173
#
#BEGIN_CHECK
. ./aqueduct_functions
#END_CHECK
#BEGIN_REMEDY
#END_REMEDY

