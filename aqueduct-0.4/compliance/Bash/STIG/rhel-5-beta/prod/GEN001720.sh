#Aqueduct - Compliance Remediation Content
#Copyright (C) 2011,2012  Vincent C. Passaro (vincent.passaro@gmail.com)
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

#!/bin/bash
######################################################################
#By Tummy a.k.a Vincent C. Passaro		                     #
#Vincent[.]Passaro[@]gmail[.]com				     #
#www.vincentpassaro.com						     #
######################################################################
#_____________________________________________________________________
#|  Version |   Change Information  |      Author        |    Date    |
#|__________|_______________________|____________________|____________|
#|    1.0   |   Initial Script      | Vincent C. Passaro | 20-oct-2011|
#|	    |   Creation	    |                    |            |
#|__________|_______________________|____________________|____________|
#
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 14-jan-2012 to allow for "less permissive" permissions.

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-11981
#Group Title: Global Initialization Files Permissions
#Rule ID: SV-12482r4_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001720
#Rule Title: All global initialization files must have mode 0644 or 
#less permissive.
#
#Vulnerability Discussion: Global initialization files are used to 
#configure the user's shell environment upon login. Malicious modification 
#of these files could compromise accounts upon logon.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check global initialization files permissions:
#
# ls -l /etc/.login
# ls -l /etc/profile
# ls -l /etc/bashrc
# ls -l /etc/environment
# ls -l /etc/security
# ls -l /etc/profile.d/*
#
#If global initialization files are more permissive than 0644, 
#this is a finding.
#
#
#
#Fix Text: Change the mode of the global initialization file(s) to 0644.
# chmod 0644 <global initialization file>
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001720

#Start-Lockdown
find /etc/.login /etc/profile /etc/bashrc /etc/environment /etc/security /etc/profile.d -perm /7133 -type f -exec chmod u-xs,g-wxs,o-wxt {} \; 2>/dev/null

