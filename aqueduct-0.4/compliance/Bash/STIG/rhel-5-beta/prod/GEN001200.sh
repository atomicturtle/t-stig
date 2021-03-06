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
#By Tummy a.k.a Vincent C. Passaro				     #
#Vincent[.]Passaro[@]gmail[.]com	         		     #
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
#  - Updated by Shannon Mitchell (shannon.mitchell@fusiontechnology-llc.com)
# on 05-jan-2012 to include checks for permissions before running the chmod
# command.
								     

#######################DISA INFORMATION###############################
#Group ID (Vulid): V-794
#Group Title: System Command Permissions
#Rule ID: SV-794r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001200
#Rule Title: All system command files must have mode 0755 or less permissive.
#
#Vulnerability Discussion: Restricting permissions will protect system 
#command files from unauthorized modification. System command files include 
#files present in directories used by the operating system for storing 
#default system executables and files present in directories included in 
#the system's default executable search paths.
#
#Security Override Guidance: 
#Elevate to Severity Code I if any file listed world-writable.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the permissions for files in /etc, /bin, /usr/bin, /usr/lbin, 
#/usr/usb, /sbin, and /usr/sbin.
#
#Procedure:
# ls -lL /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
#
#If any file listed has a mode more permissive than 0755, this is a finding.
#
#Note: Elevate to Severity Code I if any file listed world-writable.
#
#Fix Text: Change the mode for system command files to 0755 or less permissive.
#
#Procedure:
# chmod 0755 <filename>   
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001200

#Start-Lockdown
for CHKDIR in /etc /bin /usr/bin /usr/lbin /usr/usb /sbin /usr/sbin
do

  if [ -d "$CHKDIR" ]
  then
    for FILENAME in `find $CHKDIR ! -type l`
    do

      if [ -e "$FILENAME" ]
      then

        # Pull the actual permissions
        FILEPERMS=`stat -L --format='%04a' $FILENAME`

        # Break the actual file octal permissions up per entity
        FILESPECIAL=${FILEPERMS:0:1}
        FILEOWNER=${FILEPERMS:1:1}
        FILEGROUP=${FILEPERMS:2:1}
        FILEOTHER=${FILEPERMS:3:1}

        # Run check by 'and'ing the unwanted mask(7022)
# Note:  The permissions say 0755, but if you remove the SUID/SGID bits
# from many commands such as sudo or su, you could lock yourself out or break
# the system.  This may need more discussion later on. For now, I'm removing
# the check for the SUID/GID and only removing write from group and other
# if needed.
#        if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]

        if [ $(($FILEOWNER&0)) != "0" ] || [ $(($FILEGROUP&2)) != "0" ] || [ $(($FILEOTHER&2)) != "0" ]
        then
          #chmod u-s,g-ws,o-wt $FILENAME
	  chmod g-w,o-w $FILENAME
        fi

      fi
    done
  fi

done


