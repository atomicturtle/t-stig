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
# Group ID (Vulid): V-22359
# Group Title: GEN001845
# Rule ID: SV-37246r1_rule
# Severity: medium
# Rule Version (STIG-ID): GEN001845
# Rule Title: Global initialization files' library search paths must 
# contain only absolute paths.
#
# Vulnerability Discussion: The library search path environment 
# variable(s) contain a list of directories for the dynamic linker to 
# search to find libraries.  If this path includes the current working 
# directory or other relative paths, libraries in these directories may be 
# loaded instead of system libraries.  This variable is formatted as a 
# colon-separated list of directories.  If there is an empty entry, such as 
# a leading or trailing colon, or two consecutive colons, this is 
# interpreted as the current working directory.  Paths starting with a 
# slash (/) are absolute paths.
#
# Responsibility: System Administrator
# IAControls: ECSC-1
#
# Check Content:
#
# Check the global initialization files' library search paths.

# Procedure:
# grep LD_LIBRARY_PATH /etc/bashrc /etc/csh.cshrc /etc/csh.login 
# /etc/csh.logout /etc/environment /etc/ksh.kshrc /etc/profile 
# /etc/suid_profile /etc/profile.d/*

# This variable is formatted as a colon-separated list of directories. If 
# there is an empty entry, such as a leading or trailing colon, or two 
# consecutive colons, this is a finding. If an entry begins with a 
# character other than a slash (/) this is a relative path, this is a 
# finding.
#
# Fix Text: 
#
# Edit the global initialization file and remove the relative path entry 
# from the library search path variable.     
#######################DISA INFORMATION##################################
	
# Global Variables
PDI=GEN001845
	
# Start-Lockdown
for INITFILE in /etc/profile /etc/bashrc /etc/csh.login /etc/csh.cshrc /etc/environment /etc/.login /etc/security/environ `ls /etc/profile.d/*` /etc/csh.login /etc/csh.cshrc
do

  if [ -e $INITFILE ]
  then

    ## Check bash style settings

    # Remove leading colons
    egrep 'LD_LIBRARY_PATH=:' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/LD_LIBRARY_PATH=:/LD_LIBRARY_PATH=/g' $INITFILE
    fi

    # remove trailing colons
    egrep 'LD_LIBRARY_PATH=.*:\"*\s*$' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\(LD_LIBRARY_PATH=.*\):\(\"*\s*$\)/\1\2/g' $INITFILE
    fi


    # remove begin/end colons with no data
    egrep 'LD_LIBRARY_PATH=.*::.*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/LD_LIBRARY_PATH=/s/::/:/g' $INITFILE
    fi


    # remove anything that doesn't start with a $ or /
    egrep 'LD_LIBRARY_PATH="' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then

      egrep 'LD_LIBRARY_PATH="[^$/]' $INITFILE > /dev/null
      if [ $? -eq 0 ]
      then
        sed -i -e '/LD_LIBRARY_PATH/s/="[^$/][^:]*:*/="/g' $INITFILE
      fi

    else

      # remove anything that doesn't start with a $ or /
      egrep 'LD_LIBRARY_PATH=[^$/]' $INITFILE > /dev/null
      if [ $? -eq 0 ]
      then
        sed -i -e '/LD_LIBRARY_PATH/s/=[^$/][^:]*:*/=/g' $INITFILE
      fi


    fi
    egrep 'LD_LIBRARY_PATH=.*:[^$/:][^:]*\s*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/LD_LIBRARY_PATH=/s/:[^$/:][^:]*//g' $INITFILE
    fi



    ## Check csh style settings

    # Remove leading colons
    egrep 'setenv LD_LIBRARY_PATH ":' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/setenv LD_LIBRARY_PATH ":/setenv LD_LIBRARY_PATH "/g' $INITFILE
    fi

    # remove trailing colons
    egrep 'setenv LD_LIBRARY_PATH ".*:"' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e 's/\(setenv LD_LIBRARY_PATH ".*\):\("\)/\1\2/g' $INITFILE
    fi

    # remove begin/end colons with no data
    egrep 'setenv LD_LIBRARY_PATH ".*::.*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv LD_LIBRARY_PATH/s/::/:/g' $INITFILE
    fi

    # remove anything that doesn't start with a $ or /
    egrep 'setenv LD_LIBRARY_PATH ".*:[^$/:][^:]*\s*' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv LD_LIBRARY_PATH/s/:[^$/:][^:"]*//g' $INITFILE
    fi

    egrep 'setenv LD_LIBRARY_PATH "[^$/]' $INITFILE > /dev/null
    if [ $? -eq 0 ]
    then
      sed -i -e '/setenv LD_LIBRARY_PATH/s/"[^$/][^:"]*:*/"/g' $INITFILE
    fi



  fi

done

