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
#  - updated by Shannon Mitchell(shannon.mitchell@fusiontechnology-llc.com) on
# 24-jan-2012 to check the group permissions before running chgrp.


#######################DISA INFORMATION###############################
#Group ID (Vulid): V-22371
#Group Title: GEN002716
#Rule ID: SV-26507r1_rule
#Severity: CAT III
#Rule Version (STIG-ID): GEN002716
#Rule Title: System audit tool executables must be group-owned by 
#root, bin, sys, or system.
#
#Vulnerability Discussion: To prevent unauthorized access or 
#manipulation of system audit logs, the tools for manipulating those 
#logs must be protected.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check that the audit tool executables are group-owned by root, bin, 
#sys, or system.
#
#Procedure:
# ls -lL /sbin/auditctl /sbin/auditd /sbin/ausearch /sbin/aureport 
#/sbin/autrace /sbin/audispd
#
#If any listed file is not group-owned by root, bin, sys, or system, 
#this is a finding.
#
#Fix Text: Change the group-owner of the audit tool executable to root, 
#bin, sys, or system.
#
#Procedure:
# chgrp root <audit tool executable>    
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN002716

#Start-Lockdown
find /sbin/auditctl /sbin/auditd /sbin/ausearch /sbin/aureport /sbin/autrace /sbin/audispd ! -group root ! -group bin ! -group sys -exec chgrp root {} \;
