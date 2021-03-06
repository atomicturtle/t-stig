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
# on 13-Feb-2012 to move from dev to prod and add fix.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-933
#Group Title: Restrict NFS Filesystem Access to Local Hosts
#Rule ID: SV-933r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN005840
#Rule Title: The NFS server must be configured to restrict file system access to local hosts.
#
#Vulnerability Discussion: The NFS access option limits user access to the specified level. This assists in protecting exported file systems. If access is not restricted, unauthorized hosts may be able to access the system's NFS exports.
#
#Responsibility: System Administrator
#IAControls: ECSC-1
#
#Check Content: 
#Check the permissions on exported NFS file systems.
#
#Procedure:
# exportfs -v
#
#If the exported file systems do not contain the ‘rw’ or ‘ro’ options that specify a list of hosts or networks, this is a finding.
#
#Fix Text: Edit /etc/exports and add ro and/or rw options (as appropriate) that specify a list of hosts or networks which are permitted access. Re-export the file systems.    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN005840

#Start-Lockdown

# Not 100% sure whats its asking for here.  The fix text says to add ro or rw
# options to entries which specify a lists of access hosts/networks.  So lets
# just make sure if any entries at all do not have rw or ro we will go with the
# default of ro.
egrep -v 'r[wo][,)]' /etc/exports > /dev/null
if [ $? -eq 0 ]
then
  sed -i -e '/r[wo][,)]/! s/\(.*\))/\1,ro\)/g' /etc/exports
  exportfs -a
fi
