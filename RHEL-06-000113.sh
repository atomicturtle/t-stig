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
# Group ID (Vulid): RHEL-06-000113
# Group Title: SRG-OS-000152
#
   
# Rule ID: RHEL-06-000113_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000113
# Rule Title: The system must employ a local IPv4 firewall.
#
# Vulnerability Discussion: The "iptables" service provides the system's 
# host-based firewalling capability for IPv4 and ICMP.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# If the system is a cross-domain system, this is not applicable.

# Run the following command to determine the current status of the 
# "iptables" service: 

# service iptables status

# If the service is enabled, it should return the following: 

# iptables is running...


# If the service is not running, this is a finding.
#
# Fix Text: 
#
# The "iptables" service can be enabled with the following command: 

# chkconfig iptables on

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000113
#
#BEGIN_CHECK
. ./aqueduct_functions
MOD_MSG="iptables running"
if service iptables status >/dev/null; then
	show_message $PDI "$MOD_MSG" pass
else
	chkconfig iptables on
	service iptables start >/dev/null
	show_message $PDI "$MOD_MSG" fixed
fi
#END_CHECK
#BEGIN_REMEDY
#END_REMEDY

