#!/bin/bash

##########################################################################
#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  
#  Vincent C. Passaro (vincent.passaro@gmail.com)
#  Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor,
#Boston, MA  02110-1301, USA.
##########################################################################

###################### Fotis Networks LLC ###############################
# By Vincent C. Passaro                                                 #
# Fotis Networks LLC	                                                #
# Vincent[.]Passaro[@]fotisnetworks[.]com                               #
# www.fotisnetworks.com	                                                #
###################### Fotis Networks LLC ###############################
#
#  _____________________________________________________________________
# |  Version |   Change Information  |      Author        |    Date    |
# |__________|_______________________|____________________|____________|
# |    1.0   |   Initial Script      | Vincent C. Passaro | 1-Aug-2012 |
# |          |   Creation            |                    |            |
# |__________|_______________________|____________________|____________|
#	                                                                  
   
	
#######################DISA INFORMATION##################################
# Group ID (Vulid): V-22583
# Group Title: GEN008540
# Rule ID: SV-37985r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN008540
# Rule Title: The system's local firewall must implement a deny-all, 
# allow-by-exception policy.
#
# Vulnerability Discussion: A local firewall protects the system from 
# exposing unnecessary or undocumented network services to the local 
# enclave.  If a system within the enclave is compromised, firewall 
# protection on an individual system continues to protect it from attack.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the firewall rules for a default deny rule.

# iptables --list

# Example of a rule meeting this criteria:
# REJECT    all  --  anywhere          anywhere         reject-with 
# icmp-host-prohibited

# A rule using DROP is also acceptable.  The default rule should be the 
# last rule of a table and match all traffic.

# If there is no default deny rule, this is a finding.
#
# Fix Text: 
#
# Edit "/etc/sysconfig/iptables" and add a default deny rule.

# An example of a default deny rule:
# -A RH-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited

# Restart the iptable service.
# service iptables restart  
  
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN008540
	
# Start-Lockdown

