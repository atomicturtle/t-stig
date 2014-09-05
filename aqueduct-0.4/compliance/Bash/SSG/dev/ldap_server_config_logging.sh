#!/bin/bash -u
set -e

#
# Copyright (c) 2010, 2011 Tresys Technology LLC, Columbia, Maryland, USA
#
# This software was developed by Tresys Technology LLC
# with U.S. Government sponsorship.
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

RSYS=/etc/rsyslog.conf

[ -f $RSYS ] || exit 1
[ -f /etc/init.d/slapd ] || exit 0

. $(dirname $0)/set_general_entry
add_entry "local4.*" $RSYS

/bin/touch /var/log/ldap.log
/bin/chown root:root /var/log/ldap.log
/bin/chmod 0600 /var/log/ldap.log

add_entry "/var/log/ldap.log" /var/log/ldap.log

[ -f /etc/openldap/slapd.conf ] || exit 1
add_entry "loglevel stats2" /etc/openldap/slapd.conf
