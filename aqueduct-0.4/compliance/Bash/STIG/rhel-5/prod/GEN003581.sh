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
# Group ID (Vulid): V-22408
# Group Title: GEN003581
# Rule ID: SV-26620r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003581
# Rule Title: Network interfaces must not be configured to allow user 
# control.
#
# Vulnerability Discussion: Configuration of network interfaces should be 
# limited to privileged users.  Manipulation of network interfaces may 
# result in a Denial of Service or bypass of network security mechanisms.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the system for user-controlled network interfaces.
# grep -l '^USERCTL=yes' /etc/sysconfig/network-scripts/ifcfg* 
# If any results are returned, this is a finding.
#
# Fix Text: 
#
# Edit the configuration for the user-controlled interface and remove the 
# "USERCTL=yes" configuration line or set to "USERCTL=no".    
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003581
	
# Start-Lockdown
for NICCONF in `ls /etc/sysconfig/network-scripts/ifcfg*`
do
  grep USERCTL $NICCONF > /dev/null
  if [ $? -eq 0 ]
  then
    sed -i 's/USERCTL=yes/USERCTL=no/g' $NICCONF
  else
    echo "USERCTL=no" >> $NICCONF
  fi
done
