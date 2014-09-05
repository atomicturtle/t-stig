#!/bin/bash
#
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000527
# Group Title: SRG-OS-999999
#
   
# Rule ID: RHEL-06-000527_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000527
# Rule Title: The login user list must be disabled.
#
# Vulnerability Discussion: In the default graphical environment, users logging directly into the system are greeted with a login screen that displays all known users. This functionality should be disab
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
#gconftool-2 --direct \
#--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
#--get /apps/gdm/simple-greeter/disable_user_list
#
#The output should be "true". If it is not, this is a finding.
#
# Fix Text: 
#Run the following command to disable the user list:
#
#$ sudo gconftool-2 --direct \
#--config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory \
#--type bool --set /apps/gdm/simple-greeter/disable_user_list true

#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000524
SEVERITY=medium
#
#BEGIN_CHECK
. /usr/libexec/aqueduct/functions
MOD_MSG="Desktop Screen Locking"
#END_CHECK
#BEGIN_REMEDY
#gconf_setting string /apps/gdm/simple-greeter/disable_user_list true $PDI "$MOD_MSG"

gconftool-2 --direct --config-source xml:readwrite:/etc/gconf/gconf.xml.mandatory --type bool --set /apps/gdm/simple-greeter/disable_user_list true

