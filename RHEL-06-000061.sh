#!/bin/bash
#
##########################################################################
#Red Hat Enterprise Linux 6 - DISA STIG Compliance Remediation Content
#Copyright (C) 2013 
#Vincent C. Passaro (vince@buddhalabs.com)
#
##########################################################################
#
######################  Buddha Labs LLC  ################################
# By Vincent C. Passaro                                                 #
# Buddha Labs LLC.                                                      #
# vince[@]buddhalabs[.]com                                              #
# www.buddhalabs.com	                                                #
######################  Buddha Labs LLC  ################################
#_________________________________________________________________________
#    Version |   Change Information     |      Author        |    Date    
#-------------------------------------------------------------------------
#    1.0     |  Initial Script Creation |  Vincent Passaro   | 1-JUNE-2013
#	                                                                  
   
#	
#######################DISA INFORMATION##################################
# Group ID (Vulid): RHEL-06-000061
# Group Title: SRG-OS-000021
#
   
# Rule ID: RHEL-06-000061_rule
# Severity: medium
# Rule Version (STIG-ID): RHEL-06-000061
# Rule Title: The system must disable accounts after three consecutive 
# unsuccessful login attempts.
#
# Vulnerability Discussion: Locking out user accounts after a number of 
# incorrect attempts prevents direct password guessing attacks.
#
# Responsibility: 
# IAControls: 
#
# Check Content:
#
# To ensure the failed password attempt policy is configured correctly, 
# run the following command: 

# grep pam_faillock /etc/pam.d/system-auth-ac

# The output should show "deny=3". 
# If that is not the case, this is a finding.
#
# Fix Text: 
#
# To configure the system to lock out accounts after a number of 
# incorrect login attempts using "pam_faillock.so": 

# Add the following lines immediately below the "pam_unix.so" statement in 
# the AUTH section of "/etc/pam.d/system-auth-ac": 

# auth [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 
# fail_interval=900



# auth required pam_faillock.so authsucc deny=3 unlock_time=604800 
# fail_interval=900

# Note that any updates made to "/etc/pam.d/system-auth-ac" will be 
# overwritten by the "authconfig" program.  The "authconfig" program should 
# not be used.  
#######################DISA INFORMATION##################################
#	
# Global Variables
PDI=RHEL-06-000061
SEVERITY=medium
#deny=3
#BEGIN_CHECK
. ./aqueduct_functions
MOD_MSG="PAM disable accounts after 3 failures"
PKG_CONFIG=/etc/pam.d/system-auth
PKG_CONFIG2=/etc/pam.d/password-auth
verify_setting "deny=3" "unused" $PKG_CONFIG $PDI "$MOD_MSG" $SEVERITY

# Add after the following
# auth        required      pam_env.so
# auth        required      pam_faillock.so preauth silent audit deny=3 even_deny_root root_unlock_time=900 unlock_time=604800 fail_interval=900

# Add after the following:
# auth        sufficient    pam_unix.so try_first_pass
# auth        [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900

# Add after the following
# auth        [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900
# auth        required      pam_faillock.so authsucc deny=3 unlock_time=604800 fail_interval=900


#END_CHECK
#BEGIN_REMEDY
if [ $? -ne 0 ]; then
	
	R1="auth        required      pam_env.so"
	R5='auth        required      pam_faillock.so preauth silent audit deny=3 even_deny_root root_unlock_time=900 unlock_time=604800 fail_interval=900'

	# find this, add after
	add_entry_after "$R1" "$R5" $PKG_CONFIG
	add_entry_after "$R1" "$R5" $PKG_CONFIG2

	R1="auth        sufficient    pam_unix.so try_first_pass"
	R5='auth        [default=die] pam_faillock.so authfail deny=3 unlock_time=604800 fail_interval=900'
	add_entry_after "$R1" "$R5" $PKG_CONFIG
	add_entry_after "$R1" "$R5" $PKG_CONFIG2

	R1='auth        requisite     pam_succeed_if.so uid >= 500 quiet'
	R5='auth        required      pam_faillock.so authsucc deny=3 unlock_time=604800 fail_interval=900'
	add_entry_after "$R1" "$R5" $PKG_CONFIG
	add_entry_after "$R1" "$R5" $PKG_CONFIG2


	R1='account     required      pam_unix.so'
	R5='account     required      pam_faillock.so'
	add_entry_after "$R1" "$R5" $PKG_CONFIG
	add_entry_after "$R1" "$R5" $PKG_CONFIG2

	

fi
#END_REMEDY

