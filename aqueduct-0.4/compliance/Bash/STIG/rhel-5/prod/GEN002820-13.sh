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
# Group ID (Vulid): V-29279
# Group Title: GEN002820-13
# Rule ID: SV-37726r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN002820-13
# Rule Title: The audit system must be configured to audit all 
# discretionary access control permission modifications.
#
# Vulnerability Discussion: If the system is not configured to audit 
# certain activities and write them to an audit log, it is more difficult 
# to detect and track system compromises and damages incurred during a 
# system compromise.
#
# Responsibility: System Administrator
# IAControls: ECAR-1, ECAR-2, ECAR-3
#
# Check Content:
#
# Check the system's audit configuration.

# Procedure:
# cat /etc/audit/audit.rules | grep -e "-a exit,always" | grep -i 
# "fremovexattr"

# If "-S fremovexattr" is not in the result, this is a finding.
#
# Fix Text: 
#
# The "-F arch=<ARCH>" restriction is required on dual-architecture 
# systems (such as x86_64). On dual-architecture systems, two separate 
# rules must exist - one for each architecture supported. Use the generic 
# architectures "b32" and "b64" for specifying these rules.
# On single architecture systems, the "-F arch=<ARCH>" restriction may be 
# omitted, but if present must match either the architecture of the system 
# or its corresponding generic architecture. The architecture of the system 
# may be determined by running "uname -m". See the auditctl(8) manpage for 
# additional details.
# Any restrictions (such as with "-F") beyond those provided in the example 
# rules are not in strict compliance with this requirement, and are a 
# finding unless justified and documented appropriately.
# The use of audit keys consistent with the provided example is encouraged 
# to provide for uniform audit logs, however omitting the audit key or 
# using an alternate audit key is not a finding.

# Procedure:
# Edit the audit.rules file and add the following lines to enable auditing 
# of discretionary access control permissions modifications.
# -a exit,always -F arch=<ARCH> -S fremovexattr

# Restart the auditd service.
# service auditd restart     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN002820-13
UNAME=$( uname -m )
BIT64='x86_64'
AUDITFILE='/etc/audit/audit.rules'

AUDITCOUNT642=$( grep -c -e "-a exit,always -F arch=b64 -S fremovexattr " $AUDITFILE )
AUDITCOUNT322=$( grep -c -e "-a exit,always -F arch=b32 -S fremovexattr " $AUDITFILE )	
# Start-Lockdown
if [ $UNAME == $BIT64 ]
  then
  	if [ $AUDITCOUNT642 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820-13#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b64 -S fremovexattr " >> $AUDITFILE
	    service auditd restart
	fi
	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820-13#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S fremovexattr " >> $AUDITFILE
	    service auditd restart
	fi

else

	if [ $AUDITCOUNT322 -eq 0 ]
	  then
	    echo " " >> $AUDITFILE
	    echo "#############GEN002820-13#############" >> $AUDITFILE
	    echo "-a exit,always -F arch=b32 -S fremovexattr " >> $AUDITFILE
	    service auditd restart
	fi
fi


