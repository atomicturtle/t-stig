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
# Group ID (Vulid): RHEL-06-000092
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000092_rule
# Severity: low
# Rule Version (STIG-ID): RHEL-06-000092
# Rule Title: The system must not respond to ICMPv4 sent to a broadcast 
# address.
#
# Vulnerability Discussion: Ignoring ICMP echo requests (pings) sent to 
# broadcast or multicast addresses makes the system slightly more difficult 
# to enumerate on the network.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# The status of the "net.ipv4.icmp_echo_ignore_broadcasts" kernel 
# parameter can be queried by running the following command: 

# $ sysctl net.ipv4.icmp_echo_ignore_broadcasts

# The output of the command should indicate a value of "1". If this value 
# is not the default value, investigate how it could have been adjusted at 
# runtime, and verify it is not set improperly in "/etc/sysctl.conf". 
# If the correct value is not returned, this is a finding.
#
# Fix Text: 
#
# To set the runtime status of the "net.ipv4.icmp_echo_ignore_broadcasts" 
# kernel parameter, run the following command: 

# sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1

# If this is not the system's default value, add the following line to 
# "/etc/sysctl.conf": 

# net.ipv4.icmp_echo_ignore_broadcasts = 1

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000092

#BEGIN_CHECK
. ./aqueduct_functions
MOD_MSG="sysctl ignore icmp brodcasts"
KERNEL_VAR=`sysctl net.ipv4.icmp_echo_ignore_broadcasts | awk '{ print $NF }'`
#END_CHECK
#BEGIN_REMEDY

if [ $KERNEL_VAR -ne 1 ]; then
        edit_file /etc/sysctl.conf $PDI "net.ipv4.icmp_echo_ignore_broadcasts = 1" "net.ipv4.icmp_echo_ignore_broadcasts"
        show_message $PDI "$MOD_MSG" fixed
else
        show_message $PDI "$MOD_MSG" pass
fi

# This is just for the limited SCC tool. It doesn't check the real value so we have to write this
# to /etc/sysctl.conf manually
if ! grep -q net.ipv4.icmp_echo_ignore_broadcasts /etc/sysctl.conf; then
        edit_file /etc/sysctl.conf $PDI "net.ipv4.icmp_echo_ignore_broadcasts = 1" "net.ipv4.icmp_echo_ignore_broadcasts"

fi
# END_REMEDY
