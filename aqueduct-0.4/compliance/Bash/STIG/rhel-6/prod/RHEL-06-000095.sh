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
# Group ID (Vulid): RHEL-06-000095
# Group Title: SRG-OS-000142
#
   
# Rule ID: RHEL-06-000095_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000095
# Rule Title: The system must be configured to use TCP syncookies.
#
# Vulnerability Discussion: A TCP SYN flood attack can cause a denial of 
# service by filling a system's TCP connection table with connections in 
# the SYN_RCVD state. Syncookies can be used to track a connection when a 
# subsequent ACK is received, verifying the initiator is attempting a valid 
# connection and is not a flood source. This feature is activated when a 
# flood condition is detected, and enables the system to continue servicing 
# valid connection requests.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# The status of the "net.ipv4.tcp_syncookies" kernel parameter can be 
# queried by running the following command: 

# $ sysctl net.ipv4.tcp_syncookies

# The output of the command should indicate a value of "1". If this value 
# is not the default value, investigate how it could have been adjusted at 
# runtime, and verify it is not set improperly in "/etc/sysctl.conf". 
# If the correct value is not returned, this is a finding.
#
# Fix Text: 
#
# To set the runtime status of the "net.ipv4.tcp_syncookies" kernel 
# parameter, run the following command: 

# sysctl -w net.ipv4.tcp_syncookies=1

# If this is not the system's default value, add the following line to 
# "/etc/sysctl.conf": 

# net.ipv4.tcp_syncookies = 1

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000095
#BEGIN_CHECK
. /usr/libexec/aqueduct/functions
MOD_MSG="sysctl enable syncookies"
KERNEL_VAR=`sysctl net.ipv4.tcp_syncookies | awk '{ print $NF }'`
#END_CHECK
#BEGIN_REMEDY

if [ $KERNEL_VAR -ne 1 ]; then
        edit_file /etc/sysctl.conf $PDI "net.ipv4.tcp_syncookies = 1" "net.ipv4.tcp_syncookies"
        show_message $PDI "$MOD_MSG" fixed
else
        show_message $PDI "$MOD_MSG" pass
fi
# END_REMEDY


