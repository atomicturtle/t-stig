#!/bin/bash
#
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000018
# Group Title: SRG-OS-000232
#
   
# Rule ID: RHEL-06-000017_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000017
# Rule Title: A file integrity baseline must be created
#
# Vulnerability Discussion: For AIDE to be effective, an initial database of "known-good" information about files must be captured and it should be able to be verified against the installed files.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
# 
#To find the location of the AIDE database file, run the following command:
#
# grep DBDIR /etc/aide.conf
#
#Using the defined values of the [DBDIR] and [database] variables, verify the existence of the AIDE database file:
#
# ls -l [DBDIR]/[database_file_name]
#
#If there is no database file, this is a finding. 

# Fix Text: 
#
#Run the following command to generate a new database:
#
# /usr/sbin/aide --init
#
#By default, the database will be written to the file "/var/lib/aide/aide.db.new.gz". Storing the database, the configuration file "/etc/aide.conf", and the binary "/usr/sbin/aide" (or hashes of these files), in a secure location (such as on read-only media) provides additional assurance about their integrity. The newly-generated database can be installed as follows:
#
# cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
#
#To initiate a manual check, run the following command:
#
# /usr/sbin/aide --check
#
#If this check produces any unexpected output, investigate. 

  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000017
SEVERITY=medium
#
#BEGIN_CHECK
. ./aqueduct_functions

if [ -f /var/lib/aide/aide.db.new.gz ]; then
	show_message $PDI "aide database detected" pass
else
#END_CHECK
#BEGIN_REMEDY
  	/usr/sbin/aide --init
	if [ -f /var/lib/aide/aide.db.new.gz ]; then
		cp /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz
	fi
	show_message $PDI "aide database created" fixed
fi

#END_REMEDY

