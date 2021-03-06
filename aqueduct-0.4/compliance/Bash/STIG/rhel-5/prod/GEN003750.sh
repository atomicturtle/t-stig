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
# Group ID (Vulid): V-22425
# Group Title: GEN003750
# Rule ID: SV-37410r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN003750
# Rule Title: The xinetd.d directory must have mode 0755 or less 
# permissive.
#
# Vulnerability Discussion: The Internet service daemon configuration 
# files must be protected as malicious modification could cause Denial of 
# Service or increase the attack surface of the system.
#
# Responsibility: System Administrator
# IAControls: ECLP-1
#
# Check Content:
#
# Check the permissions of the xinetd configuration directories.
# ls -dlL /etc/xinetd.d
# If the mode of the directory is more permissive than 0755, this is a 
# finding.


#
# Fix Text: 
#
# Change the mode of the directory.
# chmod 0755 /etc/xinetd.d   
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN003750
	
# Start-Lockdown

if [ -d "/etc/xinetd.d" ]
  then

    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/xinetd.d`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7022)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
      then
        chmod u-s,g-ws,o-wt /etc/xinetd.d
    fi
fi
