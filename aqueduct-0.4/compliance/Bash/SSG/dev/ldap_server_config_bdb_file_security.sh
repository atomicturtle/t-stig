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

FILE=/etc/openldap/slapd.d

[ -f /etc/init.d/slapd ] || exit 0
[ -f $FILE ] || exit 1

/usr/bin/id ldap || /usr/sbin/useradd ldap

for f in "/etc/openldap/slapd.d/cn\=config/olcDatabase\={*}/bdb.ldif"; do
	/bin/chown root:ldap $f && /bin/chmod 640 $f || exit 1
done;
