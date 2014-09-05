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
#  - Updated by Shannon Mitchell shannon.mitchell@fusiontechnology-llc.com)
# on 30-dec-2011 to check the permissions before running the chmod command.



#######################DISA INFORMATION###############################
#Group ID (Vulid): V-798
#Group Title: /etc/passwd File Permissions
#Rule ID: SV-798r7_rule
#Severity: CAT II
#Rule Version (STIG-ID): GEN001380
#Rule Title: The /etc/passwd file must have mode 0644 or less permissive.
#
#Vulnerability Discussion: If the passwd file is writable by a group-owner 
#or the world, the risk of passwd file compromise is increased. The passwd 
#file contains the list of accounts on the system and associated information.
#
#Responsibility: System Administrator
#IAControls: ECLP-1
#
#Check Content: 
#Check the mode of the /etc/passwd file.
#
#Procedure:
# ls -lL /etc/passwd
#
#If /etc/passwd has a mode more permissive than 0644, this is a finding.

#Fix Text: Change the mode of the passwd file to 0644.
#######################DISA INFORMATION###############################

#Global Variables#
PDI=GEN001380

#Start-Lockdown


if [ -a "/etc/passwd" ]
  then
    # Pull the actual permissions
    FILEPERMS=`stat -L --format='%04a' /etc/passwd`

    # Break the actual file octal permissions up per entity
    FILESPECIAL=${FILEPERMS:0:1}
    FILEOWNER=${FILEPERMS:1:1}
    FILEGROUP=${FILEPERMS:2:1}
    FILEOTHER=${FILEPERMS:3:1}

    # Run check by 'and'ing the unwanted mask(7133)
    if [ $(($FILESPECIAL&7)) != "0" ] || [ $(($FILEOWNER&1)) != "0" ] || [ $(($FILEGROUP&3)) != "0" ] || [ $(($FILEOTHER&3)) != "0" ]
      then
        chmod u-xs,g-wxs,o-wxt /etc/passwd
    fi
  else
    echo "------------------------------" > $PDI-error.log
    date >> $PDI-error.log
    echo " " >> $PDI-error.log
    echo "/etc/passwd does not exist." >> $PDI-error.log
    echo "Could not change group perms" >> $PDI-error.log
    echo "------------------------------" >> $PDI-error.log
fi
