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
#
#  - Updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com)
# on 04-Feb-2012 to check for the package before removing it.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22430
#Group Title: GEN003815
#Rule ID: SV-26666r1_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN003815
#Rule Title: The portmap or rpcbind service must not be installed 
#unless needed.
#
#Vulnerability Discussion: The portmap and rpcbind services increase 
#the attack surface of the system and should only be used when needed. 
#The portmap or rpcbind services are used by a variety of services 
#using remote procedure calls (RPCs).
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check if the RPC service packages are installed.
#
#Procedure:
# rpm -qa | grep portmap
#If a package is found, this is a finding.
#
# rpm -qa | grep rpcbind
#Note that rpcbind is not part of the RHEL5 distribution. If a 
#package is found, this is a finding.
#
#Fix Text: Remove the RPC packages
#
#Procedure:
#Remove the portmap package.
# rpm -e portmap
#or
# yum remove portmap
#
#Remove the portmap rpcbind.
# rpm -e rpcbind
#or
# yum remove rpcbind
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN003815

#Start-Lockdown
rpm -q portmap > /dev/null
if [ $? -eq 0 ]
then
  yum remove portmap -y 
fi
rpm -q rpcbind > /dev/null
if [ $? -eq 0 ]
then
  yum remove rpcbind -y 
fi
