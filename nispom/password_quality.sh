#!/bin/sh
# Group ID: password_quality_pamcracklib
# var_password_pam_cracklib_retry (RETRY) Number of retries before error out
# var_password_pam_cracklib_minlen (MIN_LEN) Minimum number of characters in password
# var_password_pam_cracklib_dcredit (MIN_DIGIT) Minimum number of digits in password
# var_password_pam_cracklib_ucredit (MIN_UPPER) Minimum number of uppercase characters in password
# var_password_pam_cracklib_ocredit (MIN_OTHER) Minimum number of special characters
# var_password_pam_cracklib_lcredit (MIN_LOWER) Minimum number of lower case characters
# var_password_pam_cracklib_difok (MIN_REUSE) Minimum nuimber of characters not present in old pass

# var_accounts_passwords_pam_faillock_deny (FAIL_LOCK) Number of failed login attempts before account lockout
# var_accounts_passwords_pam_faillock_unlock_time (FAIL_UNLOCK_TIME) Seconds before automatic unlocking after excessive failed logins
# var_accounts_passwords_pam_faillock_fail_interval (FAIL_INTERVAL) Interval for counting failed login attempts before account lockout

# accounts_password_pam_cracklib_retry


# password required pam_cracklib.so try_first_pass retry=3 maxrepeat=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1 difok=4

RETRY=3

VAR='password required pam_cracklib.so try_first_pass retry=3 maxrepeat=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1 difok=4'

sed -i "s/password.*pam_cracklib.*/$VAR/"  /etc/pam.d/system-auth
